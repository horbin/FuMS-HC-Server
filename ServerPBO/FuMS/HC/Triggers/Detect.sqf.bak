//Detect.sqf
// Horbin
// 1/4/15
// INPUTS: array [grpAction, vehicleAction], array groups, array vehicles, state
// OUTPUS: 1 based upon if a member in the groups or vehicles array detects a player
//  grpAction = 0 - all units in the array are checked for detecting players
//  grpAction =-1 - no units in the array are checked.
//  grpAction = X - only units in that specific group are checked.
private ["_data","_state","_grpDet","_vehDet","_isDetected","_searcher","_result","_groups","_vehicles"];
_data = _this select 0;
_result = 0;
if (count _data == 2) then
{
    _groups = _this select 1;
    _vehicles = _this select 2;
    _state = _this select 3;
    _grpDet = _data select 0;
    _vehDet = _data select 1;
    _isDetected = false;
    //diag_log format ["###Trigger Watch:State:%1 Detected: Group:%2, Vehicle:%3", _state, _grpDet, _vehDet];
   // diag_log format ["###Trigger Watch: _groups:%1",_groups];
    if (_grpDet > -1) then
    {
        if (_grpDet == 99) then
        {
            {
             //   diag_log format ["###Trigger Watch: _units:%1", units _x];
                {
                    if (! isNull(_x findNearestEnemy _x)) then
                    {
                        _isDetected = true;  
                    };
                }foreach units _x;
            }foreach _groups;
        }
        else
        {
            {
                if (! isNull(_x findNearestEnemy _x)) then
                {
                    _isDetected = true;  
                };       
            }foreach units (_groups select _grpDet);
        };
    };
    if (_vehDet > -1) then
    {
        if (_vehDet == 99) then
        {
            {
                if (! isNull(_x findNearestEnemy _x)) then
                {
                    _isDetected = true;  
                };      
            }foreach _vehicles;
        }
        else
        {
            _searcher = _vehicles select _vehDet;
            if (! isNull(_searcher findNearestEnemy _searcher)) then
            {
                _isDetected = true;  
            };        
        };
    };
    if (_isDetected) then {_result = 1;};
};
_result