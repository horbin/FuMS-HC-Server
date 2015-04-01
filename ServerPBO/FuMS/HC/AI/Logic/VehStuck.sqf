//VehStuck.sqf
// Horbin
// 1/25/15
// Inputs: Unit
// Spawns a process that watches the position of the unit. If the unit is a driver, then 
// the vehicle will get deleted. All ai in the vehicle will be left to do whatever logic/waypoints they 
// were assigned too.
// VehStuck = true if it remains within same 2m area for 150 seconds.
//****Spawn Stuck Vehicle Code for driver ******
private ["_unit","_lastPos","_stationary"];
_unit = _this select 0;
_stationary = 0;
if (!isNil "_unit") then
{
    _lastPos = getPos _unit;
  //  diag_log format ["##VehStuck: Initialized for %1", _unit];   
    sleep 10; // wait 10 seconds before starting to check to allow for init/placement.
    while {alive _unit and !(vehicle _unit == _unit)} do // vehicle _unit == _unit => on foot
    {
        private ["_unitPos"];
        sleep 15;  // only need to run this every 15sec or so, not performance based.
        _unitPos = getPos _unit;
        _unitPos set [2,0]; // 2d distance checking!
        if( _unit distance _lastPos< 3) then // veh has been in same proximity for at least 15 seconds!
        {
            private ["_var"];
            _var = _unit getVariable "FuMS_XFILL";
            if (!isNil "_var") then
            {
                if (_var select 2 != "HOLD") then // not doing an evacuation, so must be stuck!
                {
                    _stationary =_stationary +1;
                    //diag_log format ["##VehStuck: %2: %1 is stuck! Getting ready to delete!", vehicle _unit, _stationary];
                };
            };
        }
        else 
        {
            _stationary =0;
            _lastPos = getPos _unit;
            _lastPos set [2,0]; // 2d distance check
        };
        if (_stationary > 4) then
        { 
            diag_log format ["##VehStuck: %1 being destroyed because it was stuck!",vehicle _unit];
            deleteVehicle (vehicle _unit);
        }else
        {
            if (! canMove (vehicle _unit)) then
            {
                // order all units in the vehicle to leave.
                {
                    unassignVehicle _x;
                }foreach assignedCargo (vehicle _unit);
                {
                    unassignVehicle _x
                }foreach units (vehicle _unit);              
            };
        };
    }; 
} else {diag_log format ["##VehStuck : ERROR attempt to initialize with no driver defined!"];};
