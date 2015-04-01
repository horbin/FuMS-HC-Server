//SetSpecialNameandLocation.sqf
// Horbin
// 3/1/15
// Inputs: current selected mission position
//			mission info array containing mission name and/or special location 
//			mission override name
// Outputs: position and override name for the encounter
// if a position is included with the mission file name, use this FIXED position for the encounter!
//  and remove any 'location' related name
private ["_pos","_mission","_missionNameOverride"];
_pos = _this select 0;
_mission = _this select 1;
_missionNameOverride = _this select 2;
//diag_log format ["##SetSpecialNameandLocation: _mission:%1",_mission];
if (TypeName _mission == "ARRAY") then
{
    if (count _mission > 1) then
    {                              
        if (TypeName (_mission select 1) == "ARRAY") then
        {
            _pos = _mission select 1;
            _missionNameOverride = "";
        };
        if (TypeName (_mission select 1) == "STRING") then
        {        
            // add individual city names if present!
            {
                private ["_name","_curMissionLocationName"];
                
                _name = (text _x);                        
                if ( ( _mission select 1) == _name) then
                {
                    _pos = locationPosition _x;
                    _missionNameOverride = _name;
                };
            }foreach FuMS_DefinedMapLocations;  
        };
    } ;
};
[_pos, _missionNameOverride]              