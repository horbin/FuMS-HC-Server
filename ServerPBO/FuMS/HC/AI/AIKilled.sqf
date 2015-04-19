//AI_Killed.sqf
// Horbin
// 12/28/14
// INPUTS: _victim:obj, _killer:obj
// Destroys equipment on AI to AI deaths
// Shooting AI from a vehicle 'turrent' should preserve gear.
private ["_victim","_killer","_droppedLauncher","_isRPG"];
_victim = _this select 0;
_killer = _this select 1;

//diag_log format ["##AI_Killed:%2 PriWeapon:%1", primaryweapon _victim,_victim];
//diag_log format ["##AI_Killed:%2 All Weapons:%1", weapons _victim,_victim];

//_victim RemoveMagazineGlobal "RPG32_HE_F";
//_victim RemoveMagazineGlobal "RPG32_F";
//_victim RemoveWeaponGlobal "launch_RPG32_F";
//    [], //Uniforms
//            [], // Vests
//            [], // Backpacks.
//            [], // Helmets
//            ["launch_RPG32_F"], // Weapons
//            ["RPG32_HE_F","RPG32_F"], // Magazines
//            [] // Items
diag_log format ["<FuMS> AIKilled: Victim:%1  SoldierOnly Items:%2",_victim, FuMS_SoldierOnlyItems];

for [{_i=0},{_i < count FuMS_SoldierOnlyItems},{_i=_i+1}]do
{
    _itemList = FuMS_SoldierOnlyItems select _i;
    if (count _itemList > 0) then
    {
        {
            switch (_i) do
            {
                case 0:
                {
                    if (_x == uniform _victim) then {RemoveUniform _victim;};
                };
                case 1:
                {
                    if (_x == vest _victim) then { RemoveVest _victim;};
                };
                case 2:
                {
                    if (_x == backpack _victim) then {RemoveBackpack _victim;};
                };
                case 3:
                {
                    if (_x == headgear _victim) then {RemoveHeadGear _victim;};
                };
                case 4:
                {
                    if (_x == primaryweapon _victim) then {_victim removeweapon _x;};
                    if (_x == secondaryweapon _victim) then {_victim removeweapon _x;};
                };
                case 5: {_victim removemagazine _x;};
                case 6: {_victim unlinkitem _x; _victim removeItem _x;};                
            };
        }foreach _itemList;
    };
};

// perform a check within 2m's of the AI for any "Launcher_RPG32_F" and delete them also
// code implemented to address issue of AI dropping the rocket launcher before this EH triggers!!!
//diag_log format ["##AI_Killed: Neareast Objects within 5m :%1",nearestObjects [_victim,[],5]];

    _droppedLauncher = nearestObjects [_victim, [],5];
    if (!isNil "_droppedLauncher") then
    {
        {
          //  diag_log format ["##AI_Killed: Checking %1, which is typeOf:%2",_x, typeOf _x];
            if (_x isKindOf "WeaponHolderSimulated") then
            {
                //deleteVehicle _x;                
                _isRPG = getWeaponCargo _x;
               // diag_log format ["##AI_Killed: Trying to delete RPG from %1 which contains %2",_x, _isRPG];
                {
                    //if ( ((_isRPG select 0) select 0) == "launch_RPG32_F") then { clearWeaponCargo _x;};
                    if ( ((_isRPG select 0) select 0) == _x) then { clearWeaponCargo _x;};
                }foreach FuMS_SoldierOnlyItems;
            };
        }foreach _droppedLauncher; // should only be one!
    };


//if (!isPlayer _killer and _killer isKindOf "Man" ) then
if (isPlayer _killer and (_killer == vehicle _killer)) then
{
    private ["_data","_unitCallsign","_channel","_range","_themeIndex","_playername","_killerFullName","_findbrace"];
    _data = _victim getVariable "FuMS_RadioChat";
    if (!isNil "_data") then
    {
        // diag_log format ["##Killed EH: RadioChat var=%1", _data];
        _unitCallsign = _data select 0;
        _channel = _data select 1;
        _range = _data select 2;
        _themeIndex = _data select 3;
        // get the killer's name from the actual object
        _findbrace = false;
        _playername = "";
        _killerFullName = format["%1", _killer];
        //KRON_StrToArray (Kronzky)
        private["_i","_arr","_out","_msg"];
        _arr = toArray(_killerFullName);
        _out=[];
        for "_i" from 0 to (count _arr)-1 do
        {
            _out=_out+[toString([_arr select _i])];
        };
        // diag_log format ["##Killed EH: killer  _out:%1",_out];
        // parse the array.        
        for [{_i=0},{_i < (count _out)},{_i=_i+1}] do
        {
            if (_findbrace) then
            {
                if (_out select _i == ")") then {_findbrace = false;}
                else { _playername = format ["%1%2",_playername, _out select _i];};
            } else
            { 
                if (_out select _i == "(") then {_findbrace = true;};
            };
        };       
        if (_playername == "") then
        {
            // diag_log format ["##Killed EH: Friendly Fire: %1",_unitCallsign];
            _msg = format ["%1 was killed by a friendly! Check you shots!",_unitCallsign];
        }else
        {
            // diag_log format ["##Killed EH: %1 was killed by %2",_unitCallsign, _playername];
            _msg = format ["%1 was killed by %2",_unitCallsign,_playername];   
        };    
       // diag_log format ["##Killed EH: %1.",_msg];
        if (isNil "_msg") then
        {
            diag_log format ["##EH Killed: ERROR No message to send to RadioChatter player:%1, unit:%2",_playername, _unitCallsign];
        } else
        {
            [_msg, _channel, _range, position _victim] spawn FuMS_fnc_HC_AI_RC_RadioChatter;
        };   
    };
    // get info on the unit.
    private ["_var"];
    _var = _victim getVariable "FuMS_XFILL";
    if (!isNil "_var") then
    {
        private ["_themeIndex"];
        _themeIndex = _var select 0;
        FuMS_BodyCount set [_themeIndex, ((FuMS_BodyCount select _themeIndex) + 1)];
        diag_log format ["##AI_Killed: BodyCount for Theme#%1 is:%2",_themeIndex, (FuMS_BodyCount select _themeIndex)];
        diag_log format ["##AI_Killed: Player side = %1  Victim Side:%2", side _killer,  side _victim];
    };    
    if (side _victim == civilian) then
    { 
         // player killed a friendly!!!!!
        //_killer addRating (-5500); // make the player KOS to everyone!
        // documentation seems to indicate you can do the following:
        // _killer joinSilent _group <-- where group is a badguy side to change the side of a unit!
        
    };   
}else
{
    //SPLAT CODE if not killed by a player!
    removeHeadgear _victim;
    removeVest _victim;
    removeBackpack _victim;
    removeAllWeapons _victim;
    _victim unassignItem "NVG_EPOCH";
    _victim removeItem "NVG_EPOCH";
    _victim unassignItem "Binocular";
    _victim removeItem "Binocular";
    _victim unassignItem "Rangefinder";
    _victim removeItem "Rangefinder";
    _victim removeweapon "ItemGPS";
    _victim removeweapon "ItemWatch";
    _victim removeweapon "EpochRadio0";
    _victim removeweapon "ItemCompass";
    _victim removeweapon "ItemMap";
};
