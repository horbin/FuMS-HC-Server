//VerifyMission.sqf
// Horbin
// 3/3/15
//Input string of mission code
// Output status of [abort code, error message]
private ["_msnCode","_abort","_sec","_data2","_typecheck","_i","_data3","_data2"];
_msnCode = _this select 0;
_abort = false;
FuMS_FileError = "";

while {true} do
{
    if (isNil "_msnCode") exitWith {_abort=true; FuMS_FileError = "No mission code found!";};
    if (TypeName _msnCode != "ARRAY") exitWith {_abort=true; FuMS_FileError = "Format error in mission code.";};
    if (count _msnCode != 10 and count _msnCode != 9) exitWith {_abort=true; FuMS_FileError = format ["Expected 9 or 10 sections. Found %1",count _msnCode];};
    //Mission Area
    _sec = "Mission Area Setup:";
    _data2 = _msnCode select 0;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
    if (count _data2 != 2) exitWith {_abort=true; FuMS_FileError = format ["%1 expected 2 entries. Found %2",_sec, _data2];};
    if (TypeName (_data2 select 0) != "STRING") exitWith {_abort=true; FuMS_FileError = format ["%1 Mission name not a text string. Found %2",_sec, _data2 select 0];};
    if (TypeName (_data2 select 1) != "SCALAR") exitWith {_abort=true; FuMS_FileError = format ["%1 Mission radius should be a number. Found %2",_sec, _data2 select 1];};    // Notification Configuration
    // Map marker configuration
    _sec = "Map Marker Config:";
    _data2 = _msnCode select 1;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
    if (count _data2 != 6) exitWith {_abort=true; FuMS_FileError = format ["%1 expected 6 entries. Found %2",_sec, _data2];};
    _typecheck = ["STRING","STRING","STRING","STRING","STRING","SCALAR"];
    for [{_i=0},{_i < 6},{_i=_i+1}] do
    {
        if (TypeName (_data2 select _i) != _typecheck select _i) exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is of type %3. Found %2",_sec, _data2 select _i, _typecheck select _i];};   
    };
    if (_abort) exitWith{};
    _sec = "Notification Messages:";
    _data2 = _msnCode select 2;
    if ([_data2,4] call FuMS_fnc_HC_Val_Util_CheckArray) exitWith {_abort=true; FuMS_FileError = format ["%1 Notification Messages: format error.",_sec];}; 
    //***Notification Options:
    _sec = format ["%1Options:",_sec];
    _data3 = _data2 select 0;
     if (TypeName _data3 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data3];};
    if (count _data3 != 7) exitWith {_abort=true; FuMS_FileError = format ["%1 expected 7 entries. Found %2",_sec, _data3];};
      _typecheck = ["BOOL","STRING","SCALAR","BOOL","BOOL","SCALAR","SCALAR"];
    for [{_i=0},{_i < 7},{_i=_i+1}] do
    {
        if (_i == 1) then
        {
            if (TypeName (_data3 select _i) == "STRING" or TypeName (_data3 select _i) == "SCALAR") then {_i=_i+1;};
        };
        if (TypeName (_data3 select _i) != _typecheck select _i) exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is of type %4. Found %2",_sec, _data3 select _i, _typecheck select _i];};         
    }; 
    _sec = "Map Marker Config:Spawn Message:";
    _data3 = _data2 select 1;
    _typecheck = ["STRING","STRING","STRING"];
    for [{_i=0},{_i < 3},{_i=_i+1}] do
    {    
        private ["_var"];
        _var = _data3 select _i;
        if (!isNil "_var") then
        {
            if (TypeName _var != _typecheck select _i) exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is of type %4. Found %2",_sec, _data3 select _i, _typecheck select _i];};         
        };
    };   
    _sec = "Map Marker Config:Win Message:";
    _data3 = _data2 select 2;
       for [{_i=0},{_i < 3},{_i=_i+1}] do
    {     
        private["_var"];
        _var = _data3 select _i;
        if (!isNil "_var") then
        {
            if (TypeName _var != _typecheck select _i) exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is of type %4. Found %2",_sec, _data3 select _i, _typecheck select _i];};         
        };
    };      
    _sec = "Map Marker Config:Lose Message:";
    _data3 = _data2 select 3;
      for [{_i=0},{_i < 3},{_i=_i+1}] do
    {       
        private ["_var"];
        _var = _data3 select _i;
        if (!isNil "_var") then
        {
            if (TypeName _var != _typecheck select _i) exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is of type %4. Found %2",_sec, _data3 select _i, _typecheck select _i];};         
        };
    };    
    // Loot Configuration
	   _sec = "Loot Configuration:";
  //  diag_log format ["##VerifyMission: %1 start.",_sec];
    _data2 = _msnCode select 3;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};    
    if ([_data2] call FuMS_fnc_HC_Val_Msn_MissionLootConfig) exitwith {_abort=true;};
      
    // Building Configuration
	_sec = "Building Configuration:";
  //     diag_log format ["##VerifyMission: %1 start.",_sec];
	 _data2 = _msnCode select 4;
	 if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
	if ([_data2] call FuMS_fnc_HC_Val_Msn_MissionBuildingConfig) exitwith {_abort=true;};
   
    //Group Configuration
      _sec = "Group Configuration:";
 //       diag_log format ["##VerifyMission: %1 start.",_sec];
    _data2 = _msnCode select 5;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
    if ([_data2] call FuMS_fnc_HC_Val_Msn_GroupConfiguration) exitwith {_abort=true;};
   
    //Vehicle Configuration
      _sec = "Vehicle Configuration:";
 //      diag_log format ["##VerifyMission: %1 start.",_sec];
    _data2 = _msnCode select 6;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
  //  if (count _data2 != 3) exitWith {_abort=true; FuMS_FileError = format ["%1 expected 3 entries. Found %2",_sec, _data2];};
    if ([_data2] call FuMS_fnc_HC_Val_Msn_MissionVehicleConfiguration) exitWith {_abort=true;};
   
    //Trigger Configuration
      _sec = "Trigger Configuration:";
 //      diag_log format ["##VerifyMission: %1 start.",_sec];
    _data2 = _msnCode select 7;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
    if (count _data2 != 6) exitWith {_abort=true; FuMS_FileError = format ["%1 expected 6 entries. Found %2",_sec, _data2];};
    if ([_data2] call FuMS_fnc_HC_Val_Msn_MissionTriggerConfig) exitWith {_abort=true;};
    
   
    //Phased Missions
      _sec = "Phased Missions:";
 //      diag_log format ["##VerifyMission: %1 start.",_sec];
    _data2 = _msnCode select 8;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
    if (count _data2 > 3 ) exitWith {_abort=true; FuMS_FileError = format ["%1 expected no more than 3 entries. Found %2",_sec, _data2];};
    {
        if (TypeName _x != "STRING" and TypeName _x !="ARRAY" ) exitWith {_abort=true; FuMS_FileError = format ["%1 Phase file name should be a string or [""String"",[location]] array. Found %2",_sec, _x];};
        if (TypeName _x == "ARRAY") then
        {
            if (count _x != 2)exitWith {_abort=true; FuMS_FileError = format ["%1 Phase file name should be a string or [""String"",[location]] array. Found %2",_sec, _x];};
            if (TypeName (_x select 0) != "STRING")exitWith {_abort=true; FuMS_FileError = format ["%1 Phase file name should be a string or [""String"",[location]] array. Found %2",_sec, _x];};
            if ([_x select 1] call FuMS_fnc_HC_Val_Util_VerifyLocation) exitWith {_abort=true; FuMS_FileError = format ["%1%3 Found %2",_sec, _x select 1,FuMS_FileError];};
        };
    }foreach _data2;
  
    // Airborne Vehicle config.  
    if (count _msnCode >9 ) then
    {
        _sec = "Aircraft Configuration:";
 //          diag_log format ["##VerifyMission: %1 start.",_sec];
        _data2 = _msnCode select 9;
        if (TypeName _data2 != "ARRAY") exitWith {_abort=true; FuMS_FileError = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
        //  if (count _data2 != 3) exitWith {_abort=true; FuMS_FileError = format ["%1 expected 3 entries. Found %2",_sec, _data2];};
        if ([_data2] call FuMS_fnc_HC_Val_Msn_MissionVehicleConfiguration) exitWith {_abort=true;};
    };
    if (true) exitWith {};  
};
//diag_log format ["##VerifyMission: Exiting script."];
_abort






