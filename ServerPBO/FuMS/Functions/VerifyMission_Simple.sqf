//VerifyMission_Simple.sqf
// Horbin
// 3/1/15
// Inputs: mission file data array
// Performs simplistic check on data. Enough checking is done to ensure safe extraction of phase mission names and reinforcement mission names
// This routine is just in support of BuildThemeMissionList. Full mission data verification is offloaded to the HC's and accomplished by another function.
private ["_data", "_abort","_msg","_fileNameReinforce","_phase01","_phase02","_phase03","_filePhase","_fileList"];
_data = _this select 0;
_msg = "";
_abort = false;
_fileNameReinforce = "";
_filePhase=[];
_phase01 = false;
_phase02 = false;
_phase03 = false;
while {true} do
{
    private ["_sec","_data2","_data3","_name"];
    if (isNil "_data") exitWith {_abort=true; _msg = "No mission data passed!";};
    if (TypeName _data != "ARRAY") exitWith {_abort=true; _msg = format ["data passed is not an ARRAY. Found %1",_data];};
    if (count _data != 10 and count _data != 9) exitWith {_abort=true; _msg = format ["Expected 9 or 10 sections. Found %1",count _data];};
    _sec = "Mission Area Setup:";
    _data2 = _data select 0;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; _msg = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
    if (count _data2 != 2) exitWith {_abort=true; _msg = format ["%1 expected 2 entries. Found %2",_sec, _data2];};
    if (TypeName (_data2 select 0) != "STRING") exitWith {_abort=true; _msg = format ["%1 Mission name not a text string. Found %2",_sec, _data2 select 0];};
    _name = _data2 select 0;
    _data2 = _data select 7; // Trigger section:
    _sec = format ["%1:Trigger Section:",_name];
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; _msg = format ["%1 data passed is not an ARRAY. Found %2",_sec, _data2];};
    if (count _data2 != 6) exitWith {_abort=true; _msg = format ["%1 expected 6 entries. Found %2",_sec, _data2];};
    if (count (_data2 select 5) != 0) exitWith {}; //NO TRIGGERS defined so no phases, no reinforcements possible.
    if (count (_data2 select 2) != 0) then {_phase01 = true;};
    if (count (_data2 select 3) != 0) then {_phase02 = true;};
    if (count (_data2 select 4) != 0) then {_phase03 = true;};
    _data3 = _data2 select 0; // win section;
    if (TypeName _data3 != "ARRAY") exitWith {_abort=true; _msg = format ["%1 Win triggers passed is not an ARRAY. Found %2",_sec, _data3];};
    {
        if (TypeName _x != "ARRAY") exitWith {_abort=true; _msg = format ["%1 Error in Trigger definitions. Found %2",_sec, _x];};
        if (TypeName (_x select 0) != "STRING") exitWith {_abort=true; _msg = format ["%1 Error in Trigger definition Name. Found %2",_sec, _x];};
        if (toupper (_x select 0) == "REINFORCE") then
        {
            if (count _x != 3)exitWith {_abort=true; _msg = format ["%1 Error in Reinforce definition. Found %2",_sec, _x];};
            _fileNameReinforce = _x select 2;
        };
    }foreach _data3;
    if (_abort) exitWith{};
    if (!_phase01 and !_phase02 and !_phase03) exitWith{}; // no phase triggers, so don't need to check their mission files.
    _sec = format ["%1: Phase Missions:",_name];
    _data2 = _data select 8;
    if (TypeName _data2 != "ARRAY") exitWith {_abort=true; _msg = format ["%1 section is not an ARRAY. Found %2",_sec, _data2];};
    if (count _data2 > 0 and _phase01) then {_filePhase set [0,_data2 select 0];};
    if (count _data2 > 1 and _phase02) then {_filePhase set [1,_data2 select 1];};
    if (count _data2 > 2 and _phase03) then {_filePhase set [2,_data2 select 2];};
    {
        _name = _x;
        if (!isNil "_name") then
        {
            if (TypeName _name == "ARRAY") then {_name = _name select 0;};
            if (TypeName _name != "STRING") exitWith {_abort=true; _msg = format ["%1 phase file name not a string. Found %2",_sec, _x];};			
        };
    }foreach _filePhase;	
    if (true) exitWith{};
};
_fileList = ["","","",""];
if (count _fileNameReinforce > 0) then {_fileList set [0,_fileNameReinforce];};
if (count _filePhase>0) then { _fileList set[ 1, _filePhase select 0];};
if (count _filePhase >1) then { _fileList set[2, _filePhase select 1];};
if (count _filePhase >2) then { _fileList set[3,_filePhase select 2];};
[_abort, _msg, _fileList] 


