// PVEH.sqf
// Horbin
// 2/28/15
// Collection of Server side PVEH's.
FuMS_RegisterVehicle_Server =
{
    // for use by non-FuMS addons to register vehicles to keep them from going poof.
    [_this select 0] call EPOCH_server_setVToken;
};


"FuMS_RegisterVehicle" addPublicVariableEventHandler
{
    [_this select 1] spawn FuMS_RegisterVehicle_Server;
};

"FuMS_DataValidation" addPublicVariableEventHandler
{
	_msg = _this select 1;
    diag_log format ["-------------------------------------------------------------------------------------"];
    diag_log format ["----------------            Fulcrum Mission System                    -----------------"];
    diag_log format ["-------------------------------------------------------------------------------------"];   
    diag_log format [" Potential fatal errors in FuMS initialization or mission execution.     "];
    diag_log format ["   check your Headless Client's .rpt for specifics!"];
    diag_log format ["Offending File: %1",_msg];
    diag_log format ["-------------------------------------------------------------------------------------"];
    diag_log format ["-------------------------------------------------------------------------------------"];      
};


FuMS_BuildVehicle_Server =
{
      //        diag_log format ["##HC_HAL: BuildVehicle_HAL fired!"];  
    private ["_vehObj"];
  _vehObj = _this select 0;

    _vehObj setVariable ["HCTEMP", "AI", true]; // HCTEMP set to "PLAYER" once a player enters.

  //  _vehObj=createVehicle[_item,_position,[],0,"NONE"];
    _vehObj call EPOCH_server_setVToken;
	
    addToRemainsCollector[_vehObj];
    _vehObj disableTIEquipment true;
    clearWeaponCargoGlobal    _vehObj;
    clearMagazineCargoGlobal  _vehObj;
    clearBackpackCargoGlobal  _vehObj;
    clearItemCargoGlobal	  _vehObj;   
        
    _vehObj addEventHandler ["GetIn",
    {
        _vehobj = _this select 0;
        _vehseat = _this select 1;
        _owner = _this select 2;
        _idowner = owner _owner;
        _vehactual = vehicle _vehobj;
        // If it is ID:0, the server, or the HC controlling AI, then no changes required.
        // HC_HAL_ID is a null object after a disconnect or if it is NOT the 1st thing to connect after a reboot...        
       // _hcID =HCHAL_ID;
       // diag_log format ["###EH:GetIn: HC_HAL_Player: %1, _hcID: %2, _owner: %4, _idowner: %3",HC_HAL_Player, _hcID, _idowner, _owner];
        // Any one of the below checks implies _veh owned by AI, not a player.
        if ( (!isPlayer _owner) ) then
        // if (  (_idowner == 0) or (_idowner == _hcID) or (!isPlayer _owner)  ) then
        {
           // diag_log format ["###EH:GetIn:AI DETECTED: %1 ID entered a vehicle: %2",_idowner,_vehobj];
        }else
        {
			_typeveh = typeOf _vehobj;
			_abort = false;
			{
				if (_typeveh == _x) exitWith
				{
					FuMS_AIONLYVEHICLE = true;
					_idowner publicVariableClient "FuMS_AIONLYVEHICLE";
					_owner action ["getOut", _vehobj];
					_abort = true;
				};
			}foreach FuMS_AIONLYVehicles;
			if (_abort) exitWith {};
		
            //diag_log format ["###EH:GetIn: %1 with ID:%4 entering %2 on %3",_owner, _vehseat, _vehactual, _idowner];
            FuMS_TEMPVEHICLE = true;
            _idowner publicVariableClient "FuMS_TEMPVEHICLE";
            // If a player enters the vehicle, update the HCTEMP, so server will not delete vehicle on  an HC disconnect!
            _value = _vehobj getVariable "HCTEMP";
			if (_value != "PLAYER" and (FuMS_GlobalLootOptions select 2) ) then // make vehicle purchasable, and save it to the Hive!
			{
				// Possibly needed to keep from breaking normal vehicle limits?    
				EPOCH_VehicleSlotsLimit = EPOCH_VehicleSlotsLimit + 1;
				EPOCH_VehicleSlots pushBack str(EPOCH_VehicleSlotsLimit);
				// Code below is used when a vehicle is 'purchased' off a vendor!
				_slot=EPOCH_VehicleSlots select 0;
				EPOCH_VehicleSlots=EPOCH_VehicleSlots-[_slot];
				EPOCH_VehicleSlotCount=count EPOCH_VehicleSlots;
				publicVariable "EPOCH_VehicleSlotCount";
				 _vehObj setVariable["VEHICLE_SLOT",_slot,true];
				_vehObj call EPOCH_server_save_vehicle;
                
                if (FuMS_VehicleZeroAmmo) then {_vehobj setvehicleAmmo 0;};
				//_vehObj call EPOCH_server_vehicleInit;
			};
            //diag_log format ["###EH:GetIn: HCTEMP = %1", _value];
            _vehobj setVariable ["HCTEMP", "PLAYER", true];
        };       
    }];   

};

"FuMS_BuildVehicle_HC" addPublicVariableEventHandler
{
    [_this select 1] spawn FuMS_BuildVehicle_Server;
};

FuMS_RadioChatter_Server =
{
    private["_data","_msg","_receivers"];
    _data = _this select 0;
    _msg = _data select 0;
    _receivers = _data select 1;
    //diag_log format ["#FuMsnInit: RadioChatter for:%1",_receivers];
    FuMS_RADIOCHATTER = _msg;
    {
        (owner (vehicle _x)) publicVariableClient "FuMS_RADIOCHATTER";
    }foreach _receivers; 
};

"FuMS_RADIOCHATTER_Distro" addPublicVariableEventHandler
{
    [_this select 1] spawn FuMS_RadioChatter_Server;
};


FuMS_HeartMonitor = compile preprocessFileLineNumbers "\FuMS\Functions\HeartMonitor.sqf";

// invoked by an HC when it connects.
"FuMS_GetHCIndex" addPublicVariableEventHandler
{
    if (!FuMS_ServerIsClean) exitWith {diag_log format ["##PVEH: Server Dirty! HC connections temporarily denied!"];};
    FuMS_ServerIsClean = false;
    _headlessClient = _this select 1; // set to 'player' object by HC before sending.
    _hcID = owner _headlessClient;
    diag_log format ["##GetHCIndex PVEH: player:%1 owner id:%2",_headlessClient, _hcID];
    _prefix = "FuMS_HC_isAlive";
    _var = format ["%1%2",_prefix, _hcID]; 
    missionNamespace setVariable [_var, true];
    FuMS_HC_SlotNumber = _hcID; // used to broadcast _hcID back to the HC for variable suffix'ing.
    _hcID publicVariableClient "FuMS_HC_SlotNumber";
    [_headlessClient] spawn FuMS_HeartMonitor;  
    FuMS_ServerIsClean = true;
};

FuMS_ZombieNoise_Server =
{
    private ["_data","_sound","_zombie","_players"];
    _data = _this select 0;
    _sound = _data select 0;
    _zombie = _data select 1;
    _players = _data select 2;
    diag_log format ["##PVEH %1 is pushing sound %2 to %3",_zombie, _sound, _players];
    {
        FuMS_ZombieNoise = [_sound, _zombie];
        (owner _x) publicVariableClient "FuMS_ZombieNoise";      
        //"FuMS_ZombieNoise" addPublicVariableEventHandler
        publicVariable "FuMS_ZombieNoise";
    }foreach _players;
};

"FuMS_ZombieNoise" addPublicVariableEventHandler
{
    [_this select 1] spawn FuMS_ZombieNoise_Server;    
};




