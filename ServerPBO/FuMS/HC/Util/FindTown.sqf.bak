//FindTown.sqf
// Horbin
//2/9/15
//INPUTS: town name (string)
//OUTPUTS: location of the town (array) or map center if town not found. 
private ["_town","_townloc","_name","_mapCenter", "_found"];
_town = _this select 0;
_mapCenter =(FuMS_ServerData select 0) select 0; 
_townloc = _mapCenter;
_found = false;
{
    _name = (text _x);
    if (_town == _name) then{_townloc = locationPosition _x;_found=true;};
}foreach (FuMS_VillageList+FuMS_CityList+FuMS_CapitalList); 
if (!_found) then {diag_log format ["##FindTown: ERROR: %1 town not found!",_town];};
_townloc
