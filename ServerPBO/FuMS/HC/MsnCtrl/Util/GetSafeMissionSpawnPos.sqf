 //GetSafeMissionSpawnPos.sqf
 // Horbin
 // 4/2/2015
 // Inputs: mission data, themeIndex, 
// Mission file settings that affect _pos determination:
//  "NONE" - no checking for water/land proximity is made
// "LAND" - mission is a land mission, will attempt to place entire 'encounter radius' in land
// "WATER" - mission is a water mission, will attempt to place entire 'encounter radius' in water
private ["_minRange","_waterMode","_terrainGradient","_shoreMode","_encounterRadius","_missionData","_themeIndex","_MAXATTEMPTS",
                "_pos","_locType","_attempts","_folksHome","_playerList","_plotPoleList","_missionName","_goodPos"];
_missionData = _this select 0;
_themeIndex = _this select 1;
_missionName = _this select 2;

_MAXATTEMPTS = 15;  // number of attempts conducted before settling on a possible poor location.
 
// Basic random location generation
_minRange = 0;
_waterMode = 0; // 0=no, 1=either, 2=water only
_terrainGradient = 2; // 10=mountains, 4= fairly hilly, 1=flat
_shoreMode = 0; // 0=either, 1= shore only

// uncomment to force 'random' encounters to cluster for testing!
                   // FuMS_MapCenter = [23525, 19325];
                   // FuMS_MapRange = 200;
                    _pos = [FuMS_MapCenter, _minRange, FuMS_MapRange, _minRange, _waterMode, _terrainGradient, 
                    _shoreMode, FuMS_BlackList, FuMS_Defaultpos] call BIS_fnc_findSafePos;   

// determine if it should be a land or water position from the mission file
//diag_log format ["##GetSafeMissionSpawnPos: _missionData:%1",_missionData];

_locType = toupper ((_missionData select 0) select 2);
_encounterRadius = (_missionData select 0) select 1;

if (isNil "_locType") then { _locType = "NONE";};
switch (_locType) do
{
    case "LAND":
    {
        _waterMode = 0;
        _shoreMode = 0;
    };
    case "WATER":
    {
        _waterMode = 2;
    };
};
_goodPos = false;
_attempts = _MAXATTEMPTS;
while {_attempts > 0 and !_goodPos} do
{
      _pos = [FuMS_MapCenter, _minRange, FuMS_MapRange, _minRange, _waterMode, _terrainGradient, 
                    _shoreMode, FuMS_BlackList, FuMS_Defaultpos] call BIS_fnc_findSafePos;   
    
    // search the encounter radius for live players.
    _folksHome = false;
    _playersNear = _pos nearEntities _encounterRadius;
    {
        if (isPlayer _x and alive _x) exitWith {_folksHome=true;diag_log format ["##GetSafeMissionSpawnPos: Player :%1 within range of mission spawn %2",_x,_pos];};
    }foreach _playersNear;
    // search for overlapping encounters
    {
        private ["_dist"];       
        // if distance between centers of two encounters are less than the sum of their radii they overlap.
        _dist = _pos distance (_x select 0);
        if (_dist < (_encounterRadius + (_x select 1) )   ) exitWith {_folksHome=true;diag_log format ["##GetSafeMissionSpawnPos: Another mission: %1 too close.",_x select 2];};
    }foreach FuMS_MissionTerritory; // [_eCenter, _radius, "ThemeMissionname"]
    if (!_folksHome) then
    {
        if (_waterMode == 0) then
        {
            // check that the pos passes PlotPole safetey.
          //  diag_log format ["##GetSafeMissionSpawnPos: ""LAND"" Checking for plot poles within %1m of %2",_encounterRadius, _pos];
            _folksHome = false;
            _plotPoleList = nearestObjects [_pos, ["PlotPole_EPOCH"], _encounterRadius];
            if (count _plotPoleList != 0 ) then // find a plot pole, check for players at home or base raiding.
            {
                diag_log format ["##GetSafeMissionSpawnPos: Plotpoles located:%1",_plotPoleList];           
                {
                    _playerList = _x nearEntities ["Man",_encounterRadius];
                    diag_log format ["##GetSafeMissionSpawnPos: Players located:%1",_playerList];   
                    if (count _playerList > 0) exitwith {_folksHome = true;}; // plot pole, but  players home!
                }foreach _plotPoleList;           
            };
            if (!_folksHome) then // No one home, position is good wrt PlotPole and players.
            {
                // check in cardinal directions and 3rds for land.
                private ["_xx","_yy","_rad","_isSafe","_i","_rng"];
                _xx = _pos select 0;
                _yy = _pos select 1;
                _rad = _encounterRadius / 3;
                _isSafe = true;
                for [{_i=1},{_i < 4},{_i=_i+1}] do
                {        
                    _rng = _i * _rad;
                    if (surfaceIsWater [_xx+_rng, _yy]) exitwith {_isSafe = false;};
                    if (surfaceIsWater [_xx-_rng, _yy]) exitwith {_isSafe = false;};
                    if (surfaceIsWater [_xx, _yy+_rng]) exitwith {_isSafe = false;};
                    if (surfaceIsWater [_xx, _yy-_rng]) exitwith {_isSafe = false;};
                };
                if (!_isSafe) then {diag_log format ["##GetSafeMissionSpawnPos: %1 not good, water found %2m's away",_pos,_rng];};
                if (_isSafe) exitWith {_goodPos = true;};
            };    
        };    
        if (_waterMode == 2) then
        {
            // check that the pos passes PlotPole safetey....no promise someone didn't build a water base!
            //diag_log format ["##GetSafeMissionSpawnPos: ""WATER"" Checking for plot poles within %1m of %2",_encounterRadius, _pos];
            _folksHome = false;
            _plotPoleList = nearestObjects [_pos, ["PlotPole_EPOCH"], _encounterRadius];
            if (count _plotPoleList != 0 ) then // find a plot pole, check for players at home or base raiding.
            {
                diag_log format ["##GetSafeMissionSpawnPos: Plotpoles located:%1",_plotPoleList];           
                {
                    _playerList = _x nearEntities ["Man",_encounterRadius];
                    diag_log format ["##GetSafeMissionSpawnPos: Players located:%1",_playerList];   
                    if (count _playerList > 0) exitwith {_folksHome = true;}; // plot pole, but  players home!
                }foreach _plotPoleList;           
            };
            if (!_folksHome) then // No one home, position is good wrt PlotPole and players.
            {
                // check in cardinal directions and 3rds for land.
                private ["_xx","_yy","_rad","_isSafe","_i","_rng"];
                _xx = _pos select 0;
                _yy = _pos select 1;
                _rad = _encounterRadius / 3;
                _isSafe = true;
                for [{_i=0},{_i < 3},{_i=_i+1}] do
                {        
                    _rng = _i * _rad;
                    if (!surfaceIsWater [_xx+_rng, _yy]) exitwith {_isSafe = false;};
                    if (!surfaceIsWater [_xx-_rng, _yy]) exitwith {_isSafe = false;};
                    if (!surfaceIsWater [_xx, _yy+_rng]) exitwith {_isSafe = false;};
                    if (!surfaceIsWater [_xx, _yy-_rng]) exitwith {_isSafe = false;};
                };
                if (!_isSafe) then {diag_log format ["##GetSafeMissionSpawnPos: %1 not good, land found %2m's away",_pos,_rng];};
                if (_isSafe) exitWith {_goodPos = true;};
            };    
        };   
    };
    _attempts = _attempts - 1;
};
if (!_goodPos) then { diag_log format ["##GetSafeMissionSpawnPos: No good position found for %1 after %2 attempts. Using location:%3",_missionName,_MAXATTEMPTS,_pos];}
else {diag_log format ["##GetSafeMissionSpawnPos: Good position %2 found with %1 attempts remaining.",_attempts,_pos];};
_pos					
/*
                //generate random safe location
                _locationRestriction = toupper (_dataFromServer select 0 ) select 2;
                _encounterRadius = (_dataFromServer select 0) select 1;
                if ( _locationRestriction == "WATER") then{_waterMode = 2; } 
                else {_waterMode = 0; };
                //                 _waterMode = 0;// 0=not in water, 1=either, 2=in water
                _minRange = 0;               
                _terrainGradient = 2;  //10 is mountainous, 4 is pretty damn hilly too.
                _shoreMode = 0; // 0= either, 1=on shore	  
                                   
                _attempts = 15;
                while {_attempts > 0} do
                {    
                    // uncomment to force 'random' encounters to cluster for testing!
                   // FuMS_MapCenter = [23525, 19325];
                   // FuMS_MapRange = 200;
                    _pos = [FuMS_MapCenter, _minRange, FuMS_MapRange, _minRange, _waterMode, _terrainGradient, 
                    _shoreMode, FuMS_BlackList, FuMS_Defaultpos] call BIS_fnc_findSafePos;                
                    _plotPoleList = nearestObjects [_pos, ["PlotPole_EPOCH"], 200];
                    if (count _plotPoleList != 0 ) then // find a plot pole, check for players at home or base raiding.
                    {
                        diag_log format ["##ControlLoop: Plotpoles located:%1",_plotPoleList];
                        _folksHome = false;
                        {
                            _playerList = _x nearEntities ["Man",200];
                            diag_log format ["##ControlLoop: Players located:%1",_playerList];   
                            if (count _playerList > 0) exitwith {_folksHome = true;}; // plot pole, but no players home!
                        }foreach _plotPoleList;
                        if (!_folksHome) then {_attempts=-1;};//no one home, position is good!
                    }
                    else
                    {
                        //_attempts=-1;
                        // location is good for plot poles and players. 
                        // perform a radius/3 incremental scan in 4 cardinal directions.
                        // if all points match _locationRestriction then pos is good.
                        _radius = _encounterRadius / 3;
                        _xx = _pos select 0;
                        _yy = _pos select 1;
                        _isSafe = true;
                        if (_locationRestriction == "LAND") then
                        {
                            for [{_rStep = 1},{_rStep < 4},{_rStep=_rStep+1}] do
                            {
                                if (surfaceIsWater [_xx+_rstep*_radius, _yy]) exitwith {_isSafe = false;};
                                if (surfaceIsWater [_xx-_rstep*_radius, _yy]) exitwith {_isSafe = false;};
                                if (surfaceIsWater [_xx, _yy+_rstep*_radius]) exitwith {_isSafe = false;};
                                if (surfaceIsWater [_xx, _yy-_rstep*_radius]) exitwith {_isSafe = false;};
                            };
                        };
                         if (_locationRestriction == "WATER") then
                        {
                            for [{_rStep = 1},{_rStep < 4},{_rStep=_rStep+1}] do
                            {
                                if (!surfaceIsWater [_xx+_rstep*_radius, _yy]) exitwith {_isSafe = false;};
                                if (!surfaceIsWater [_xx-_rstep*_radius, _yy]) exitwith {_isSafe = false;};
                                if (!surfaceIsWater [_xx, _yy+_rstep*_radius]) exitwith {_isSafe = false;};
                                if (!surfaceIsWater [_xx, _yy-_rstep*_radius]) exitwith {_isSafe = false;};
                            };
                        };      
                        if (!_isSafe) then {  _attempts = _attempts -1;}
                        else {_attempts = -1;};
                    }; // no plot poles, and good location restrictions               
                };
                if (_attempts == 0) then
                {
                     diag_log format ["##ControlLoop: Unable to find good position for %1/%2, spawning near players: %3!!", _missionTheme, _activeMission, _playerList];
                };
*/
                