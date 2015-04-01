//ValidateAILogic.sqf
// Horbin
// 2/17/15
//
// Inputs: group of units
// Outputs: true or false
// Checks info contained in FuMS_LOGIC, FuMS_XFILL, FuMS_MSNTAG for validity, returns true if no errors found.
private ["_group","_aiLogic","_msnTag","_aiProgram","_aiOptions","_msnName","_themeName","_leader", "_validData","_option","_trueCount"];

_group = _this select 0;
_leader = leader _group;
_aiLogic = _leader getVariable "FuMS_AILOGIC";
//_xFill = _unit getVariable "FuMS_XFILL";
_msnTag = _leader getVariable "FuMS_MSNTAG";

_aiProgram = _aiLogic select 0;
_aiOptions = _aiLogic select 4;
_msnName = _msnTag select 1;
_themeName = _msnTag select 0;

_validData = false;
_aiProgram = toupper _aiProgram;
switch (_aiProgram) do
{
	case "BUILDINGS":
	{
		if (count _aiOptions == 1) then
		{
			if (TypeName (_aiOptions select 0) == "SCALAR") then {_validData = true;};
		};
	};
	case "EXPLORE":
	{
		if (count _aiOptions == 1) then
		{
			if (TypeName (_aiOptions select 0) == "SCALAR") then {_validData = true;};
		};
	};
	case "BOXPATROL":
	{
		if (count _aiOptions == 1) then
		{
			if (TypeName (_aiOptions select 0) == "SCALAR") then {_validData = true;};
		};
	};
	case "SENTRY":
	{
		if (count _aiOptions == 1) then
		{
			if (TypeName (_aiOptions select 0) == "SCALAR") then {_validData = true;};
		};
	};
	case "CONVOY":
	{
		if (count _aiOptions == 5 or count _aiOptions == 4) then
        {
            _option = _aiOptions select 0;
            _trueCount = count _aiOptions;
            _option = toupper _option;
            if (_option == "LIMITED" or _option=="NORMAL" or _option=="FULL") then {_trueCount = _trueCount - 1;};
           
            if (TypeName (_aiOptions select 1) == "BOOL") then {_trueCount = _trueCount - 1;};
          
            if (TypeName (_aiOptions select 2) == "BOOL") then {_trueCount = _trueCount - 1;};
           
            if (TypeName (_aiOptions select 3) == "BOOL") then {_trueCount = _trueCount - 1;};
           
            _option = _aiOptions select 4;
            if (!isNil "_option") then
            {
                 _option = toupper _option;
                if (_option == "XFILL") then {_trueCount = _trueCount - 1;};
            };
            if (_trueCount == 0) then {_validData = true;};
           // diag_log format ["##ValidateAILogic: Convoy: #options:%1 _trueCount:%2",count _aiOptions, _trueCount];
            //diag_log format ["##%1 %2 %3 %4 %5", (_aiOptions select 0),TypeName(_aiOptions select 1), TypeName(_aiOptions select 2), TypeName(_aiOptions select 3), TypeName(_aiOptions select 4)];
        };		
    };
    case "PARADROP":
    {
        if (count _aiOptions == 4) then
        {
            _option = _aiOptions select 0;
            _trueCount = count _aiOptions;
            _option = toupper _option;
            if (_option == "LIMITED" or _option=="NORMAL" or _option=="FULL") then {_trueCount = _trueCount - 1;};
            if (TypeName (_aiOptions select 1) == "SCALAR") then {_trueCount = _trueCount - 1;};
            if (TypeName (_aiOptions select 2) == "BOOL") then {_trueCount = _trueCount - 1;};
            if (TypeName (_aiOptions select 3) == "BOOL") then {_trueCount = _trueCount - 1;};
			if (_trueCount == 0) then {_validData = true;};
		};		
	};
	case "PATROLROUTE":
	{
		if (count _aiOptions == 7 or count _aiOptions == 6) then
		{
			_option = _aiOptions select 0;
			_trueCount = count _aiOptions;
            _option = toupper _option;
            if (_option == "CARELESS" or _option=="SAFE" or _option=="AWARE" or _option=="COMBAT" or _option=="STEALTH") then {_trueCount = _trueCount - 1;};
           
            _option = _aiOptions select 1;
            _option = toupper _option;
            if (_option == "LIMITED" or _option=="NORMAL" or _option=="FULL") then {_trueCount = _trueCount - 1;};
           
            if (TypeName (_aiOptions select 2) == "ARRAY") then {_trueCount = _trueCount - 1;};
            
            if (TypeName (_aiOptions select 3) == "BOOL") then {_trueCount = _trueCount - 1;};
           
            if (TypeName (_aiOptions select 4) == "BOOL") then {_trueCount = _trueCount - 1;};
           
            if (TypeName (_aiOptions select 5) == "BOOL") then {_trueCount = _trueCount - 1;};			
           
            _option = _aiOptions select 6;
			if (!isNil "_option") then
			{
				if (TypeName _option == "SCALAR") then {_trueCount = _trueCount - 1;};
			};
			if (_trueCount == 0) then {_validData = true;};
            //diag_log format ["..#6:%1",_trueCount];
           // diag_log format ["##ValidateAILogic: PATROLROUTE: #options:%1 _trueCount:%2",count _aiOptions, _trueCount];
           // diag_log format ["##%1 %2 %3 %4 %5 %6 %7", (_aiOptions select 0),(_aiOptions select 1), TypeName(_aiOptions select 2), TypeName(_aiOptions select 3), TypeName(_aiOptions select 4), TypeName(_aiOptions select 5), TypeName(_aiOptions select 6)];
		};		
	};
};
if (!_validData) then
{
	
			diag_log format ["-------------------------------------------------------------------------------------"];
            diag_log format ["----------------            Fulcrum Mission System                    -----------------"];
            diag_log format ["-------------------------------------------------------------------------------------"];
            diag_log format ["##ValidateAILogic: ERROR in Fulcrum Mission Data."];
            diag_log format ["    Recommend verifying data in file %1/%2 on your server!",_themeName, _msnName];        
            diag_log format ["                                        -FORMAT ERROR- "];   
            diag_log format ["                            AI Logic initialization aborted for %1",_aiProgram];
            diag_log format ["REASON: Improper data format and/or types in %1", _aiOptions];
            diag_log format ["  AI group being stripped of its gear. Mission file needs corrected!"];
            diag_log format ["-------------------------------------------------------------------------------------"];  

			{
				removeHeadgear _x;
				removeVest _x;
				removeAllWeapons _x;
                  removeBackpack _x;
				_x unassignItem "NVG_EPOCH";
				_x removeItem "NVG_EPOCH";
				_x unassignItem "Binocular";
				_x removeItem "Binocular";
				_x unassignItem "Rangefinder";
				_x removeItem "Rangefinder";
				_x removeweapon "ItemGPS";
				_x removeweapon "ItemWatch";
				_x removeweapon "EpochRadio0";
				_x removeweapon "ItemCompass";
				_x removeweapon "ItemMap";
			}foreach units _group;
};
_validData




