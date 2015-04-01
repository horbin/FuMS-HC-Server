//HC_Init.sqf
// Horbin
// 12/23/14 - mod 3/2/15
private ["_HCname","_i"];
if (hasInterface or isServer) exitWith{};

waitUntil{!isNull (uiNameSpace getVariable ["EPOCH_loadingScreen", displayNull])};
waitUntil{isNull (uiNameSpace getVariable "EPOCH_loadingScreen")};

_HCname = profileName;
for [{_i=0}, {_i < 50}, { _i = _i +1}] do
{
    diag_log format ["##############################################"];   
    if (_i == 26) then {diag_log format ["##Headless Client %1 connected with profile %2##",player,_HCname];};
};
waitUntil {time >0};
waitUntil {!isNil "FuMS_Server_Operational"};
waitUntil {FuMS_Server_Operational};

FuMS_GetHCIndex = player;
FuMS_HC_SlotNumber = -1;
waitUntil
{
    publicVariableServer "FuMS_GetHCIndex";
    sleep 3; // give the server time to respond and init, so we dont spam it!!!!
    //diag_log format ["##HC_Init:   GetHCIndex:%1  FuMS_HC_SlotNumber:%2",FuMS_GetHCIndex, FuMS_HC_SlotNumber];
    (FuMS_HC_SlotNumber >= 0) 
};

waitUntil 
{
    sleep 5;
    diag_log format ["##HC_INIT: Waiting on Server to initialize."]; 
    (!isNil "FuMS_ServerInitData" or !isNil "FuMS_HC_ScriptList")
};
//waitUntil {FuMS_ServerInitData}; // Server has completed loading all configuration data, and has passed it via PVClient calls.
sleep 5;
diag_log format ["##HC_INIT: Script List size = %1",count FuMS_HC_ScriptList];
{ 
    private ["_code"];
	
    _code = compile (missionNamespace getVariable _x);
	// find and replace _str_ with _fnc_
	//Compiling FuMS_fnc_HC_Zombies_i
	//convert to array, change elements 456 from str to fnc
	_ary = toArray _x;
	_string = "FuMS_fnc_";
	for [{_i=9},{_i< count _ary},{_i=_i+1}]do {_string = format ["%1%2",_string,toString [_ary select _i]];};	
	diag_log format ["##HC_Init: Compiling %1  into %2",_x,_string];
	missionNamespace setVariable [_string, _code];
	if (!isServer) then {_x=[];}; // free up memmory by removing code 'strings' if this is not the server.
}foreach FuMS_HC_ScriptList;

diag_log format ["##HC_Init: Starting FuMS!"];
[] spawn FuMS_fnc_HC_FuMsnInit;

