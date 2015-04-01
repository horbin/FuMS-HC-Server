// FindNearestRoad = // if no roads found within 2500m the original position is returned!
// Horbin
// 2/24/15
// Inputs: position
// Outputs position on the nearest road within 2500m of 'position'

    private ["_stepdistance","_nearRoads","_pos","_return"];
    _pos = _this select 0;
    _stepdistance = 10;
    _nearRoads = [];  
    while {count _nearRoads == 0} do // while no road segemetns found, continue searching out further!
    {
        _nearRoads = _pos nearRoads _stepdistance;
        _stepdistance = _stepdistance + _stepdistance;
		if (_stepdistance > 2500) exitWith {diag_log format ["##FindNeareastRoad: Unable to find a road near near position %1",_pos];};
    };
    _return = _nearRoads select 0;
    _pos = getPos _return;
    _pos
