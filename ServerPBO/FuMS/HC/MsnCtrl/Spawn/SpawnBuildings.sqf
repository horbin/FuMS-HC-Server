//SpawnBulding.sqf
// Horbin
// 1/4/2015
//INPUTS: Building data from Mission main, eCenter, themeIndex, _curMission
//OUTPUTS: array of buildings
//XPos = compile preprocessFileLineNumbers "HC\Encounters\Functions\XPos.sqf";
//ValidateBuilding = compile preprocessFileLineNumbers "HC\Encounters\Functions\DataCheck\ValidateBuildings.sqf";
//GetSafeSpawnVehPos = compile preprocessFileLineNumbers "HC\Encounters\Functions\GetSafeSpawnVehPos.sqf";

private ["_type","_offset","_newpos","_rotation","_bldg","_buildings","_buildingData","_eCenter","_themeIndex","_curMission","_vehicles"];
_buildingData = _this select 0;
_eCenter = _this select 1;
_themeIndex = _this select 2;
_curMission = _this select 3;

_buildings = [];
_vehicles = [];

if (!isNil "_buildingData") then
{
    if (count _buildingData > 0) then
    {
        private ["_firstBuilding"];
        // check if 1st building is at [0,0,0]. If so, work offsets!
        _firstBuilding = _buildingData select 0;
        if (TypeName _firstBuilding == "ARRAY") then {_firstBuilding = [_firstBuilding] call BIS_fnc_selectRandom;};
       // if ([_firstBuilding] call FuMS_fnc_HC_Val_Msn_ValidateBuildings) then
        if (true) then
        {
            private ["_fbLoc","_useOffset","_fireEffect"];
            _fbLoc = _firstBuilding select 1;
            _useOffset = false;          
            if (_fbLoc select 0 == 0 and _fbLoc select 1 == 0 and _fbLoc select 2 ==0) then {_useOffset = true;};    //3d locations, using offsets! 
      //      diag_log format ["##SpawnBuildings: Debug: 1stBuilding: %1  _useOffset:%2",_firstBuilding, _useOffset];
            //foreach _buildingData
            {
               // if ([_x] call FuMS_fnc_HC_Val_Msn_ValidateBuildings) then
                if (true) then
                {
                    _type = _x select 0;
                    _offset = _x select 1;
                    _rotation = _x select 2;
                    
                  //  diag_log format ["<FuMS> SpawnBuildings: _type:%1",_type];
                    if (TypeName _type == "ARRAY") then {_type = _type call BIS_fnc_selectRandom;};
                 //   diag_log format ["<FuMS> SpawnBuildings: _type selected:%1",_type];
                    
                    if (count _x > 4) then
                    {
                        _fireEffect = toupper(_x select 4);
                       // diag_log format ["<FuMS> SpawnBuildings: Fire/Smoke effect found for %1",_x];
                    }else{_fireEffect="NONE";};
                    
                    if (_useOffset) then
                    {
                        private ["_newx","_newy","_newz"];
                        if (count _eCenter == 2) then {_eCenter set [2,0];};
                        _newx = _eCenter select 0;
                        _newx = _newx + (_offset select 0);
                        
                        _newy = _eCenter select 1;
                        _newy = _newy + (_offset select 1);
                        
                        _newz = _eCenter select 2;
                        _newz = _newz + (_offset select 2);
                        _newpos = [_newx, _newy, _newz];
                    }else {_newpos = [ _eCenter, _offset] call FuMS_fnc_HC_MsnCtrl_Util_XPos;};
                    //   _newpos = [_newpos, 0, 100, 1,0, 8,0,[],[[0,0],[0,0]]] call BIS_fnc_findSafePos; // 1m clear, terraingradient 8 pretty hilly
                    if (_type isKindOf "Air" or _type isKindOf "LandVehicle" or _type isKindOf "Ship") then
                    {
                        private ["_data","_veh","_settings"];    
                        _settings = _x select 3;
                        _data = [_newpos, "none", _type] call FuMS_fnc_HC_MsnCtrl_Util_GetSafeSpawnVehPos;	
                        //diag_log format ["pos:%1, driver:%2, type:%3 data:%4",_pos, _driver, _vehType select _i,_data];
                        _veh = [ _type, _data select 0, [], 30 , _data select 1] call FuMS_fnc_HC_Util_HC_CreateVehicle;	                                                
        //                diag_log format ["##SpawnBuildings: created:%1, _type:%2",_veh,_type];                                                                  
                        _vehicles = _vehicles + [_veh];                            
                        _veh setDir _rotation;                        
                        _veh setFuel (_settings select 0);
                        _veh setVehicleAmmo (_settings select 1);
                        _veh setHitPointDamage ["hitEngine",_settings select 2];
                        _veh setHitPointDamage ["hitFuel", _settings select 3];
                        _veh setHitPointDamage ["HitHull", _settings select 4];    
                        
                        [_veh,_fireEffect] call FuMS_fnc_HC_Util_Effects;
                        
                    }else
                    {
                        private ["_keep"];
                        _bldg = createVehicle [ _type, _newpos,[],0,"CAN_COLLIDE"];
                        _bldg setDir _rotation;
                        _keep = false;
                        if (_x select 3 == 1) then {_keep = true;};
                        _bldg setVariable ["FuMS_PERSIST",_keep,false];
                        
                        [_bldg,_fireEffect] call FuMS_fnc_HC_Util_Effects;
                        
                        // store in HC variable.
                        _buildings = _buildings+ [_bldg];
                     //   HC_HAL_NumBuildings = HC_HAL_NumBuildings + 1;
                        // diag_log format ["## SPAWN Buildings: _bldg:%1   _buildings:%2",_bldg, _buildings];                
                    };
                }else
                {
                    diag_log format ["<FuMS> SpawnBuilding: ERROR in building data format for mission %1/%2", FuMS_ActiveThemes select _themeIndex,  _curMission];
                    diag_log format ["<FuMS> SpawnBuilding: Offending building/vehicle : %1", _x];
                    _buildingData=_buildingData-[_x];
                };
            } foreach _buildingData;
            //diag_log format ["## SPAWN Buildings: %1",_buildings];
            if (count _buildings > 0) then
            {
                ["Buildings",_buildings] call FuMS_fnc_HC_Util_HC_AddObject;             
            };
            if (count _vehicles > 0 ) then
            {
                ["Vehicles",_vehicles] call FuMS_fnc_HC_Util_HC_AddObject;            
            };
        };
    };
};
[ _buildings, _vehicles]
