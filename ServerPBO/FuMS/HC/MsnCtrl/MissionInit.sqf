//MissionInit.sqf
// Horbin
// 1/4/15
// Called by a 'missionname.sqf' configuration file located in 'mission theme' folder
// INPUTS: Init data from mission config file
// and array containing: [mission theme name, theme ID, phaseID, mission Name override]
// Theme will determine what folder mission specifics are read.
private ["_eCenter","_missionTheme","_missionArea","_markers","_curMission","_mkr1","_mkr2","_initData","_silentspawn",
"_notifications","_lootConfig","_buildingData","_groupData","_vehicleData","_phaseData","_encounterSize","_triggerData",
"_buildings","_groups","_vehicles","_msnStatus","_convoys","_themeIndex","_phaseID","_fragments",
"_missionNameOverride","_passthroughData","_boxes","_aircraftData","_dat"];

_initData = _this select 0;
_passthroughData = _this select 1;
_eCenter = _passthroughData select 0;
_missionTheme = _passthroughData select 1; // used in locating phased missions attached to this mission
_themeIndex = _passthroughData select 2;
_phaseID = _passthroughData select 3;
_missionNameOverride = _passthroughData select 4;
if (isNil "_missionNameOverride") then {_missionNameOverride = "";};
_msnStatus = "STATIC";
_boxes = [];
//diag_log format ["_pos:%1, Theme:%2, _initData:%3",_eCenter, _missionTheme, _initData];
_missionArea =_initData select 0;
_markers = _initData select 1;
_notifications = _initData select 2;
_lootConfig = _initData select 3;
_buildingData = _initData select 4;
_groupData = _initData select 5;
_vehicleData= _initData select 6;
_triggerData = _initData select 7;
_phaseData = _initData select 8;  
_aircraftData = _initData select 9;
//diag_log format ["##MissionInit : override=%1",_missionNameOverride];
if ( _missionNameOverride != "") then
{
    _curMission = _missionNameOverride;
}
else { _curMission = _missionArea select 0;};
_encounterSize = _missionArea select 1;

FuMS_MissionTerritory = FuMS_MissionTerritory + [[_eCenter, _encounterSize, format ["%1%2",_missionTheme,_curMission]]];

_mkr1 = format ["%3_%1_%2_1",_missionTheme select 0, _curMission, _eCenter,FuMS_HC_SlotNumber];
_mkr2 = format ["%3_%1_%2_2",_missionTheme select 0, _curMission ,_eCenter,FuMS_HC_SlotNumber];
createMarker [_mkr1, [0,0]];
createMarker [_mkr2, [0,0]];

_dat = [_buildingData, _eCenter, _themeIndex, _curMission] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnBuildings;
_buildings = _dat select 0;
_vehicles = _dat select 1;
sleep 2; // pause for 2 seconds to allow buildings to fully materialize and position.
_silentspawn = (((FuMS_THEMEDATA select _themeIndex) select 3) select 0) select 1;
//diag_log format ["##MissionInit: SpawnGroup at center:%1",_eCenter];
_groups = [_groupData, _eCenter, _encounterSize, _themeIndex, _silentspawn,_curMission] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnGroup;
_convoys = [_vehicleData, _eCenter, _encounterSize, _groups, _vehicles, _themeIndex, _curMission] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnVehicle;
_groups = _convoys select 0;
_vehicles = _convoys select 1;
if (!isNil "_aircraftData") then
{
    _convoys = [_aircraftData, _eCenter, _encounterSize, _groups, _vehicles, _themeIndex, _curMission] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnVehicle;
    _groups = _convoys select 0;
    _vehicles = _convoys select 1;
};
_boxes = [_lootConfig, _eCenter, _msnStatus, _themeIndex, _boxes] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnMissionLoot;

[_markers, _notifications, _msnStatus, _mkr1, _mkr2, _eCenter, _missionNameOverride] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnNotifications;
// Mission Completion Logic
_fragments = [_msnStatus,_buildingData, _buildings, _groups, _vehicles, _boxes];
//diag_log format ["****************************************"];
//diag_log format ["##MissionInit :%2 : Pre-LogicBomb: %1", _fragments, _curMission];
_fragments = [[_missionTheme,_eCenter, _encounterSize, _phaseData, _themeIndex, _curMission],_triggerData, 
                        [_buildingData,_buildings, _groups, _vehicles,_boxes]       ] call FuMS_fnc_HC_MsnCtrl_LogicBomb;
// merge objects from child with this parent.
//diag_log format ["##MissionInit :%2 Post-LogicBomb: %1", _fragments, _curMission];
//diag_log format ["****************************************"];
_msnStatus = _fragments select 0;
_buildingdata = _fragments select 1;
_buildings = _fragments select 2;
_groups = _fragments select 3;
_vehicles = _fragments select 4;
_boxes = _fragments select 5;
// Mission complete: Take action based upon Trigger/Mission Logic above
diag_log format ["<FuMS> MissionInit: Mission %2 finished with status of :%1",_msnStatus, _curMission];
_boxes = [_lootConfig, _eCenter, _msnStatus,_themeIndex, _boxes] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnMissionLoot;

[_markers, _notifications, _msnStatus, _mkr1, _mkr2,_eCenter, _missionNameOverride] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnNotifications;
// **********************************************************************
// Common Mission clean up
FuMS_MissionTerritory = FuMS_MissionTerritory - [_eCenter, _encounterSize, format ["%1%2",_missionTheme,_curMission]];
// For boxes: look to have a seperate timer, spawn a process to wait that timer period then delete them!
diag_log format ["<FuMS> MissionInit: Preparing to delete loot: %1",_boxes];
{
    if (typeName _x != "ARRAY") then
    {
        [_x] spawn
        {
            private ["_box","_timer"];
            _box = _this select 0;
            _timer = time + (FuMS_LootBoxTime)*60;
       //     diag_log format ["##MissionInit: _box:%1 set to expire at %2",_box, _timer];    
            while {time < _timer} do
            {              
                sleep 30;
            };
            deleteVehicle _box;
        };
    };
}foreach _boxes;
// Remove all of the triggers. - completed in 'LogicBomb'
//Remove Structures
//if (_msnStatus != "NO TRIGGERS") then
//{
    if (_phaseID !=0 ) then
    {
        // this is not a root parent, so ensure evertyhing is preserved, as control is transfered to the parent mission.   
        _fragments = [_msnStatus, _buildingData, _buildings, _groups, _vehicles, _boxes];
       // diag_log format ["##MissionInit:%4: _phaseID:%1  _curMission:%2  _fragments:%3",_phaseID, _curMission, _fragments, _curMission];
       FuMS_PhaseMsn set [ _phaseID, _fragments];
    }else
    {
        private ["_keep","_found"];
           
        //***************BUILDINGS************************
        {
            private ["_keep"];
            _keep = _x getVariable "FuMS_PERSIST";    
            if (!isNil "_keep") then
            {
                if (!_keep) then
                {                      
                    //_effects = _x getVariable "effects";
                   // {deleteVehicle _x} forEach _effects;  
                    { 
                        diag_log format ["<FuMS> MissionInit: deleting effect :%1",_x];
                        detach _x; 
                        deleteVehicle _x;
                    } foreach attachedObjects _x;
                    //      diag_log format ["## MissionInit: %2: deleting building :%1", _x, _curMission];
                    deleteVehicle _x;
                    // store in HC variable.
                    ["Buildings",_x] call FuMS_fnc_HC_Util_HC_RemoveObject;              
                };       
            };
        } foreach _buildings;        
        //Remove vehicles before Groups. Any vehicle occupied by AI will be removed!
       // diag_log format ["##MissionInit: Removing vehicles:%1",_vehicles];      
        //Flatten array...somehow getting arrays of arrays of objects, vs just a simple array of objects.
        //   need to flatten to permit clean deletion.
        {
            if (TypeName _x == "ARRAY") then
            {
                // do nothing for now. Not sure why vehicle array is becoming an array of arrays.
            }else
            {
                _keep = driver _x;
                if (! (isNull _keep) and !(isPlayer _keep) )then
                { 
                    private ["_enemy"];
                    _enemy = _keep findNearestEnemy _keep;
                    if (!isNull _enemy) then
                    {
// Vehicle persists spawn process                        
                        [_keep] spawn
                        {
                            private ["_unit","_timer","_done","_veh","_enemy"];
                            _unit = _this select 0;                            
                            _timer = time;
                            _done = false;
                            _veh = vehicle _unit;
                            diag_log format ["<FuMS> MissionInit: %1 cleanup delayed because its driver, %2, is engaged with players!",_veh,_unit];
                            while {alive _unit  and !_done} do
                            {
                                _enemy = _unit findNearestEnemy _unit;
                                if (isNull _enemy) then 
                                {
                                    if (time > _timer + 180) then { _done = true;};
                                }else{_timer = time;};
                                sleep 15;
                            };    
                            if (alive _unit) then
                            { 
                                { 
                                    diag_log format ["<FuMS> MissionInit: deleting effect :%1",_x];
                                    detach _x; 
                                    deleteVehicle _x;
                                } foreach attachedObjects _x;      
                                deleteVehicle _veh;                            
                            } // if driver was alive delete the vehicle
                            else
                            {
                               //driver was dead, so wait 3 minutes for TEMPVAR to change on vehicle. If it does not, delete it!
                                [_veh] spawn
                                {
                                    private ["_timer","_veh","_keep"];
                                    _veh = _this select 0;
                                    _timer = time+ 180;
                                    _keep = false;
                                    while {time < _timer} do
                                    {
                                        if ((_veh getVariable "HCTEMP") == "PLAYER") then
                                        {
                                            _keep = true;
                                            _timer = time;
                                        };
                                        sleep 15;
                                    };
                                    if (!_keep) then
                                    { 
                                  //      _effects = _x getVariable "effects";
                                    //    {deleteVehicle _x} forEach _effects;   
                                        { 
                                            diag_log format ["<FuMS> MissionInit: deleting effect :%1",_x];
                                            detach _x; 
                                            deleteVehicle _x;
                                        } foreach attachedObjects _x;                                          
                                        deleteVehicle _veh;
                                    };                                    
                                };                                
                            };                            
                            deleteVehicle _unit;
                        };
                    }else
                    {                       
                        ["Vehicles",_x] call FuMS_fnc_HC_Util_HC_RemoveObject;
                         { 
                             diag_log format ["<FuMS> MissionInit: deleting effect :%1",_x];
                             detach _x; 
                             deleteVehicle _x;
                         } foreach attachedObjects _x;      
                        deleteVehicle _x;
                    };
                };
            };
        }foreach _vehicles;             
        // Remove Groups
        {
            {
                private ["_enemy"];
                _enemy = _x findNearestEnemy _x;
                if (!isNull _enemy) then                
                {
// start of unit spawn code.                    
                    [_x] spawn
                    {
                        private ["_unit","_timer","_done","_enemy"];
                        _unit = _this select 0;
                        _timer = time;
                        _done = false;
                         diag_log format ["<FuMS> MissionInit: %1 cleanup delayed because it is engaged with players!",_unit];
                        while {alive _unit  and !_done} do
                        {
                            _enemy = _unit findNearestEnemy _unit;
                            if (isNull _enemy) then 
                            {
                                if (time > _timer + 180) then { _done = true;};
                            }else{_timer = time;};
                            sleep 15;
                        };    
                        deleteVehicle _unit;
                    };
                }else { deleteVehicle _x;};
            } foreach units _x;
            if ((count units _x) == 0) then
            { 
                ["AIGroups",_x] call FuMS_fnc_HC_Util_HC_RemoveObject;
                deletegroup _x;          
            };
        }foreach _groups;
    };
//};
_msnStatus
