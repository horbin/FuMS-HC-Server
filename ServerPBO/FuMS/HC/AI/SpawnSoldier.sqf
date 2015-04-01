//SpawnSoldier.sqf
// Horbin
// 1/11/15
// Inputs: Group, typeSoldier, position, Theme Index
// Outputs: Unit created.
// Input Data format expected:
// 0:"Type", 1:[ 8 numbers], 2:Uniform, 3:Vest, 4:Helmet, 5:Backpack, 6;Rifle, 7:[3 numbers], 
// 8: Pistol,9: [5 numbers beltItems], 10:[3numbers visionItems], 11:[2 Flags],12:[ array of items]
//AddIt = compile preprocessFileLineNumbers "HC\Encounters\Functions\AddIt.sqf";
//GetChoice = compile preprocessFileLineNumbers "HC\Encounters\LogicBomb\GetChoice.sqf";
//AttachMuzzle = compile preprocessFileLineNumbers "HC\Encounters\AI_Logic\AttachMuzzle.sqf";
private ["_group","_type","_pos","_themeIndex","_unit","_typeFound","_aiName","_gear","_flags","_skills","_types","_i","_priweapon","_soldierData","_secweapon",
"_radio"];
_group = _this select 0;
_type = _this select 1;
_pos = _this select 2;
_themeIndex = _this select 3;

if (((FuMS_THEMEDATA select _themeIndex) select 0) select 4) then
{
   _soldierData = FuMS_SOLDIERDATA select FuMS_GlobalDataIndex;   
}else
{
   _soldierData = FuMS_SOLDIERDATA select _themeIndex;      
};
if (isNil "_soldierData") exitWith
{
    diag_log format ["SpawnSoldier: ERROR: no theme specific SoldierData.sqf for theme #%1",_themeIndex];
    diag_log format ["Check options in ThemeData.sqf for theme %1",((FuMS_THEMEDATA select _themeIndex) select 0) select 0];
};

//diag_log format ["##SpawnSoldier: Index:%2 _soldierData:%1",_soldierData,_themeIndex];
_typeFound = false;
// locate the data for 'type' soldier.
{
    _aiName = _x select 0;  // type name
    if (_type == _aiName) then
    {
        _typeFound = true;
     //  diag_log format ["##SpawnSoldier: Found:%1",toupper _type];
        // Basic AI creation
        if (toupper _type == "ZOMBIE") then
        {        
            //_unit = _group createUnit["A3L_Zombie", _pos, [], 25, "FORM"];
            _unit = _group createUnit["I_Soldier_EPOCH", _pos, [], 25, "FORM"];    // swap when skins available            
            _unit disableAI "FSM";
            _unit disableAI "AUTOTARGET";
            _unit disableAI "TARGET";
            _unit setBehaviour "CARELESS";
            _unit enableFatigue false;
            _unit setVariable ["BIS_noCoreConversations", true];	
            _unit setVariable ["BIS_enableRandomization", false]; // to permit skins to work
           // _textureList = getObjectTextures _unit;
          //  diag_log format ["##SpawnSoldier: Zombie: textures pre-skin:%1",_textureList];
           // _unit setObjectTextureGlobal [0, "HC\Zombies\zskin.jpg"];
            // _unit setObjectTextureGlobal [0, "zskin.jpg"];
            //diag_log format ["##SpawnSoldier: Zombie: textures post-skin:%1",_textureList];
            _unit setMimic "hurt";
            _unit addEventHandler ["hit",
            {
                //[[_this select 0,"hurt"], "FuMS_INF_fnc_NextSound"] call BIS_fnc_MP;
                [_this select 0, "hurt"] spawn FuMS_fnc_HC_Zombies_Logic_Znoise;
		       (_this select 0) lookAt (_this select 1);
		       _nextTarget = [] + [_this select 1];
                missionNamespace setVariable [format ["%1_nextTarget",_this select 0], _nextTarget];
            }];    
            _unit addEventHandler ["firedNear",
            {
                diag_log format ["##Roam: %1 has heard a sound from %2",_this select 0, _this select 1];
                if ((str (_this select 4)) in ["muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG"]) exitwith {};
                [_this select 0, _this select 1] spawn FuMS_fnc_HC_Zombies_Logic_Investigating;
            }];

        }
        else
        {
            _unit = _group createUnit["I_Soldier_EPOCH", _pos, [], 25, "FORM"];
        };
        // NOTE if I_Soldier_EPOCH type is changed, AllDeadorGone.sqf will need to be modified
        removeUniform _unit;
        removeHeadgear _unit;
        removeVest _unit;
        removeAllWeapons _unit;
        _unit removeweapon "ItemWatch";
        _unit removeweapon "EpochRadio0";
        _unit removeweapon "ItemCompass";
        _unit removeweapon "ItemMap";  
        // Destroys gear for AI killed by AI and handle other stuff
        // ONLY NEEDS TO RUN ON HeadlessClient!
        // If a port to server only occurs, this will possibly need to be modified to MP to support server notifications.
        _unit addEventHandler ["killed",{[(_this select 0), (_this select 1)] spawn FuMS_fnc_HC_AI_AIKilled;}];
        _gear = [_x select 2] call FuMS_fnc_HC_Loot_GetChoice;if (_gear != "") then {_unit forceAddUniform _gear;};
      //  if (toupper _type == "ZOMBIE")then { _unit setObjectTextureGlobal [0, "HC\Zombies\zskin.jpg"];};
        _gear = [_x select 3] call FuMS_fnc_HC_Loot_GetChoice;if (_gear != "") then {_unit addVest _gear;};
        _gear = [_x select 4] call FuMS_fnc_HC_Loot_GetChoice;if (_gear != "") then {_unit addHeadgear _gear;};
        _gear = [_x select 5] call FuMS_fnc_HC_Loot_GetChoice;if (_gear != "") then {_unit addBackpack _gear;};
        // Rifle
        _gear = [_x select 6] call FuMS_fnc_HC_Loot_GetChoice;
        //diag_log format ["##SpawnSoldier: Rifle-gear:%1",_gear];
        _priweapon = "";
        if (TypeName _gear =="ARRAY") then
        {
            _priweapon = _gear select 0;
            _unit addWeapon _priweapon;
            _mag = getArray (configFile >> "CfgWeapons" >> _priweapon >> "magazines") select 0;
            _unit addMagazines [ _mag, FuMS_SoldierMagCount_Rifle];
           // _unit addMagazine [(_gear select 1),_numRifleMags];
        }else
        {
            if (_gear != "") then
            {
                _priweapon= _gear;
                _unit addWeapon _priweapon;
                  _mag = getArray (configFile >> "CfgWeapons" >> _priweapon >> "magazines") select 0;
                _unit addMagazines [ _mag, FuMS_SoldierMagCount_Rifle];
            };
        };   
       // diag_log format ["##SpawnSoldier: Rifle added:%1",_priweapon];
        //Pistol
        _secweapon = "";
        _gear = [_x select 8] call FuMS_fnc_HC_Loot_GetChoice;
    //    diag_log format ["##SpawnSoldier: Pistol-gear:%1",_gear];
        if (TypeName _gear =="ARRAY") then
        {
            _secweapon = _gear select 0;
            _unit addWeapon _secweapon;
            _mag = getArray (configFile >> "CfgWeapons" >> _secweapon >> "magazines") select 0;
            _unit addMagazines [ _mag, FuMS_SoldierMagCount_Pistol];
            //_unit addMagazine [(_gear select 1),_numPistolMags];
        }else
        {
            if (_gear != "") then
            {
                _secweapon= _gear;
                _unit addWeapon _secweapon;
                  _mag = getArray (configFile >> "CfgWeapons" >> _secweapon >> "magazines") select 0;
            _unit addMagazines [ _mag, FuMS_SoldierMagCount_Pistol];
            };
        };   
        // Rifle Attachments
        _gear = _x select 7;
        if ([_gear select 0] call FuMS_fnc_HC_Loot_AddIt) then{ _unit addPrimaryWeaponItem (WeaponAttachments_Optics call BIS_fnc_selectRandom);};  //scopes
        if ([_gear select 1] call FuMS_fnc_HC_Loot_AddIt) then
        { 
            _muzzle = [_priweapon] call FuMS_fnc_HC_AI_AttachMuzzle;
            //if (_muzzle != "None") then
            if (!isNil "_muzzle") then
            {
              //  diag_log format ["##SpawnSolder: Adding %1",_muzzle];
                _unit addPrimaryWeaponItem _muzzle;
            };
        };  //muzzle
        if ([_gear select 2] call FuMS_fnc_HC_Loot_AddIt) then { _unit addPrimaryWeaponItem "acc_flashlight"};  //flashlight       
        // Belt Items
        _gear = _x select 9;
        if ([_gear select 0] call FuMS_fnc_HC_Loot_AddIt) then {_unit addweapon "ItemMap";};  //Map.
        if ([_gear select 1] call FuMS_fnc_HC_Loot_AddIt) then {_unit addweapon "ItemCompass";};  //Compass
        if ([_gear select 3] call FuMS_fnc_HC_Loot_AddIt) then {_unit addweapon "ItemGPS";};  //GPS
        if ([_gear select 4] call FuMS_fnc_HC_Loot_AddIt) then {_unit addweapon "ItemWatch";};  //Watch
        if ((_gear select 5) > 0 ) then
        {
            _radio = format ["EpochRadio%1",(_gear select 5)];
            _unit addweapon _radio;
        };  //Radio
        // Vision items
        _gear = _x select 10;
         if ([_gear select 0] call FuMS_fnc_HC_Loot_AddIt) then {_unit addweapon "Binocular";};  //Binoculars
        if ([_gear select 1] call FuMS_fnc_HC_Loot_AddIt) then {_unit addweapon "Rangefinder";};  //RangeFinders
        if ([_gear select 2] call FuMS_fnc_HC_Loot_AddIt) then {_unit addweapon "NVG_EPOCH"};  //NVGs
        // Other Equipment       
        _gear = _x select 12;
    //    diag_log format ["##SpawnSoldier: Other Equipment:%1",_gear];
        {  
            private ["_item","_variance","_min","_numitems"];
         //   diag_log format ["##SpawnSoldier: Attempting to add %1", _x];
            _item = [_x select 0] call FuMS_fnc_HC_Loot_GetChoice;
            if (_item != "") then 
            {
                _variance = _x select 1;
                _min = _variance select 0;
                _numItems = _min + floor (random ( (_variance select 1)-_min) );
             //   diag_log format ["##SpawnSoldier: Adding %1 %2",_numItems, _item];
                _unit addMagazines [ _item, _numItems];
            };
        }foreach _gear;
        // Flags
        _flags = _x select 11;
        // in water, so give them scuba gear!
        if (_flags select 0) then{if (surfaceIsWater _pos) then{_unit forceAddUniform "U_B_Wetsuit" ;_unit addVest "V_19_EPOCH";};};
        // give them unlimited ammo!
        if (_flags select 1) then
        {
            _unit addeventhandler ["fired",
            {
                 _gunDevice = vehicle (_this select 0); // if in a vehicle and firing, refill vehicle's ammo. _gunDevice is the AI if not in a vehicle.
                _gunDevice setvehicleammo 1;
            }];
        };
        // give them some RPG's!
        _rpg = _flags select 2;
        if (!isNil "_rpg") then
        {
            if (_rpg) then
            {
                _unit addMagazines ["RPG32_HE_F", 1];
                _unit addMagazines ["RPG32_F", 1];
                _unit addWeapon "launch_RPG32_F";
            };
        };
        
        // Set skills
        _skills = _x select 1;
        _types = ["aimingAccuracy","aimingShake","aimingSpeed","spotDistance","spotTime","courage","reloadSpeed","commanding"];
        for [ {_i=0},{_i<8},{_i=_i+1}] do
        { 
            if (FuMS_SoldierSkillsOverride select _i == 0) then
            {
                _unit setSkill [ (_types select _i), (_skills select _i)];
            }else
            {
                _unit setSkill [ (_types select _i), (FuMS_SoldierSkillsOverride select _i)];
            };
        };
    };   
}foreach _soldierData;
if (!_typeFound) then
{
    diag_log format ["*******************************************************"];
    diag_log format ["******SpawnSoldier: %1 not found in Theme index %2's SoldierData.sqf",_type, _themeIndex];
    diag_log format ["*******************************************************"];
};
_unit