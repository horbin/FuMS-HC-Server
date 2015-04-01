//FillLoot.sqf
// Horbin
// 1/8/15
// FillLoot is ONLY called by LootData.sqf from the applicable theme folder!
// INPUTS: Loot Option, position (x,y,y(ARRAY) OR a veh object(OBJECT)), and LootData to parse!.
// Outputs: box item, if created.
// ASSERT Global Variable BaseLoot.sqf have been defined!
//GetQuantity = compile preprocessFileLineNumbers format ["HC\Encounters\Functions\GetQuantity.sqf"];
//GetBox = compile preprocessFileLineNumbers format ["HC\Encounters\Functions\GetBox.sqf"];

private ["_lootOption","_pos","_options","_typeLoot","_boxtype","_box","_weapons","_magazines","_items","_backpacks","_found","_isVehicle",
"_item","_number","_lootData","_randomLootData","_themeIndex"];
_lootOption = _this select 0;
_pos = _this select 1;
_themeIndex = _this select 2;

if (((FuMS_THEMEDATA select _themeIndex) select 0) select 3) then
{
   _lootData = FuMS_LOOTDATA select FuMS_GlobalDataIndex;   
}else
{
   _lootData = FuMS_LOOTDATA select _themeIndex;      
};
if (isNil "_lootData") exitWith
{
    diag_log format ["FillLoot: ERROR: no theme specific LootData.sqf for theme #%1",_themeIndex];
    diag_log format ["Check options in ThemeData.sqf for theme %1",((FuMS_THEMEDATA select _themeIndex) select 0) select 0];
};

_isVehicle = false;
if ( (TypeName _pos) == "OBJECT") then
{
    // ASSERT value passed is a vehicle object!
    _isVehicle = true;
};
_box = [];
//diag_log format ["## FillLoot: _lootOption:%1 _pos:%2 LOOTDATA index:%3",_lootOption, _pos, _this select 2];
if (_lootOption != "NONE") then
{   
    if (_lootOption == "RANDOM" or _lootOption == "Random") then
    {
        _randomLootData = _lootData call BIS_fnc_selectRandom; // grab a random loot data set.
        _options = _randomLootData select 0;  // grab the 1st block of data from the loot.
        _lootOption = _options select 0; // assign this loot's name to the loot option.
    };   
    _found = false;
    {
        _options = _x select 0; // _options : "LootSetName", "BoxforLoot"
        _typeLoot = _options select 0;
        _boxtype = _options select 1;                
        if (_typeLoot == _lootOption) then  // Found lootOption in the list of LOOTDATA!
        {
            // check boxtype for "RANDOM" if so select from the global random options in BasicLoot.sqf       
            diag_log format ["## FillLoot: _typeLoot:%1, _lootOption:%2 _boxtype:%3",_typeLoot, _lootOption, _boxtype];
            if (_boxtype == "RANDOM" or _boxtype=="Random") then { _boxtype = call FuMS_fnc_HC_Loot_GetBox;};
            diag_log format ["## FillLoot: _typeLoot:%1, _lootOption:%2 _boxtype:%3",_typeLoot, _lootOption, _boxtype];
            _found = true;
            _weapons = _x select 1;
            _magazines = _x select 2;
            _items = _x select 3;
            _backpacks = _x select 4;
            if (_isVehicle) then {_box = _pos;} // _pos contains a vehicle Object!
            else 
            {             
                if (count _pos ==2) then //offset being used so find something nearby that is Safe.
                {
                    _pos = [_pos, 0, 30, 1,0, 8,0,[],[]] call BIS_fnc_findSafePos; // 1m clear, terraingradient 8 pretty hilly
                }; //else leave the 3d solution because person making the mission knows what they are doing!
    //           diag_log format ["##FillLoot : Creating %1 at %2",_boxtype, _pos];
                _box = createVehicle [_boxtype, _pos,[],0,"NONE"];
                if (FuMS_LootSmoke ) then
                { 
                         // FuMS_SmokeProximity = _dat select 1;
                         // FuMS_SmokeColors = _dat select 2;
                         //FuMS_SmokeDuration = _dat select 3;
                    diag_log format ["##FillLoot: SmokeBox Proximity:%1 Dur:%2 Colors:%3",FuMS_SmokeProximity, FuMS_SmokeDuration, FuMS_SmokeColors];
                    [_box] spawn
                    {
                        private ["_box","_smoke01","_smokeStopTIme","_count","_smokeOn","_players","_color"];
                        _box = _this select 0;                       
                        _count = 1;
                        _smokeOn = false;
                        while {!isNil "_box"} do
                        {
                            if (FuMS_SmokeProximity !=0) then {_smokeOn=true;FuMS_SmokeProximity=2000;_smokeStopTime = time+60*FuMS_SmokeDuration;};
                            while {!_smokeOn} do
                            {
                                _players = _box nearEntities ["Man",FuMS_Proximity];
                                if (count _players > 0) then
                                {
                                    _smokeOn = true;
                                    _smokeStopTime = time+60*FuMS_SmokeDuration;
                                };   
                                sleep 5;
                            };
                            while {_smokeOn and !isNil "_box"} do
                            {
                                if (_count == 1) then
                                {     
                                    {   
                                        _color = "";
                                        _x = toupper _x;
                                        if (_x != "WHITE") then
                                        {
                                            if (_x == "RED" or _x=="GREEN" or _x=="YELLOW" or _x=="ORANGE" or _x=="PURPLE" or _x=="BLUE") then {_color=_x;};
                                        };
                                        _smoke01 = (format ["SmokeShell%1",_color] )createVehicle (getPos _box);    
                                    }foreach FuMS_SmokeColors;                                
                                    _count = 0;
                                    sleep 30;
                                };
                                _count = _count +1;
                                if (time>_smokeStopTime) then {_smokeOn = false;};                        
                            };
                        };
                        deleteVehicle _smoke01;                     
                    };
                    
                };
                clearWeaponCargoGlobal _box;
                clearMagazineCargoGlobal _box;
                clearItemCargoGlobal _box;              
            };
           // diag_log format ["########################################"];
            _numItems = 0;
            {                
             //   diag_log format ["##FillLoot: Weapons: _x:%1, _x[0]:%2, _x[1]:%3", _x, _x select 0, _x select 1];
                // _x[0] = "weapon name" or 'array of weapon names'
                // _x[1] = quantity to add.
                if (TypeName (_x select 0) == "ARRAY") then
                {
                    _item = (_x select 0) call BIS_fnc_selectRandom;
                }else
                {  
                    _item = (_x select 0);
                };
                _number = [_x select 1] call FuMS_fnc_HC_Loot_GetQuantity;
                _box addWeaponCargoGlobal [_item, _number]; 
                _numItems = _numItems + _number;
            }foreach _weapons;
            {
              //  diag_log format ["##FillLoot: Magazines: _x:%1 _x[0]:%2 _x[1]:%3", _x, _x select 0, _x select 1];
                if (TypeName (_x select 0) == "ARRAY") then
                {
                    _item = ((_x select 0) call BIS_fnc_selectRandom);
                }else
                {  
                    _item = (_x select 0);
                };
                _number = [_x select 1] call FuMS_fnc_HC_Loot_GetQuantity;
                _box addMagazineCargoGlobal [_item, _number];   
                _numItems = _numItems + _number;
            }foreach _magazines;
            {
               // diag_log format ["##FillLoot: Items: _x:%1  _x[0]:%2  _x[1]:%3", _x, _x select 0, _x select 1];
                if (TypeName (_x select 0) == "ARRAY") then
                {
                    _item = (_x select 0) call BIS_fnc_selectRandom;
                }else
                { 
                    _item = (_x select 0);
                };
                _number = [_x select 1] call FuMS_fnc_HC_Loot_GetQuantity;
                _box addItemCargoGlobal [_item, _number]; 
                _numItems = _numItems + _number;
            }foreach _items;
            {
             //   diag_log format ["##FillLoot: Backpacks: _x:%1 _x[0]:%2 _x[1]:%3", _x, _x select 0, _x select 1];
                if (TypeName (_x select 0) == "ARRAY") then
                {
                    _item = (_x select 0) call BIS_fnc_selectRandom;
                }else{  _item = (_x select 0);};
                _number = [_x select 1] call FuMS_fnc_HC_Loot_GetQuantity;
                _box addBackpackCargoGlobal [_item, _number]; 
                _numItems = _numItems + _number;
            }foreach _backpacks;
            //initialize FuMSLoot variable
            _box setVariable ["FuMS_Loot", [0, _numItems], true];            
        };   
    }foreach _lootData;
    if (!_found) then
    {
        diag_log format ["*******************************************************"];
        diag_log format ["*****FillLoot: Error! Loot option %1 in Theme Index #%2 found!", _lootOption, _this select 2];
        diag_log format ["*******************************************************"];
       // make an empty box and put it at 0 on the map since it isn't defined!
         if (_isVehicle) then {_box = _pos;}// _pos contains a vehicle Object!
        else
        {
            _box = createVehicle ["box_nato_ammoveh_f", [0,0,0],[],0,"NONE"];                                
            clearWeaponCargoGlobal _box;
            clearMagazineCargoGlobal _box;
            clearItemCargoGlobal _box;        
        };
    };
};
_box




