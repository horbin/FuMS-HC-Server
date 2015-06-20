// init.sqf
// Horbin
// 2/7/15
//
// Server side init for FuMS.pbo addon
if (!isServer) exitWith {};
private ["_handle"];
FuMS_Version = "v1.5g";
publicVariable "FuMS_Version";
FuMS_HCIDs = [];
FuMS_HCNames = [];
FuMS_HCIDs set [0,0]; // set the 1st slot to be the actual server's ID.
FuMS_HCNames set [0, "SERVER"];
FuMS_AdminListofMissions = []; //Full list of all missions on the server. [themeIndex, themeName, missionName] format.
FuMS_isStable = true; // set to false in LoadCommonData if critical errors are found.

//FuMS_ServerFuMSEnable = true; // will be set in LoadCommonData.sqf

/*
//stacked event handler to capture disconnects of HC's.
["FuMS_HC_DC", "onPlayerDisconnected",
{
    // vars _id and _name, and _uid are set
    diag_log format ["<FuMS> Init.sqf: Player Disconnect: _id:%1 _name:%2 _uid:%3",_id, _name,_uid];
}] call BIS_fnc_addStackedEventHandler;

["FuMS_HC_MDC","HandleDisconnect",
{
    private ["_owner","_hcID"];
    _owner = _this select 0;
    _hcID = _this select 1;
    diag_log format ["<FuMS> Init.sqf: HandleDisconnect MissionEH Disconnect: _owner:%1 _hcID:%2",_owner,_hcID]; 
}] call BIS_fnc_addStackedEventHandler;
*/
/*
addMissionEventHandler ["HandleDisconnect",
{
    private ["_owner","_hcID"];
    _owner = _this select 0;
    _hcID = _this select 1;
    diag_log format ["<FuMS> Init.sqf: HandleDisconnect MissionEH Disconnect: _owner:%1 _hcID:%2",_owner,_hcID]; 
}];
*/

_handle = [] execVM "\FuMS\Functions\LoadCommonData.sqf";
waitUntil {ScriptDone _handle};

if (!FuMS_isStable) exitwith
{
    diag_log format ["************************************************************************"];
    diag_log format ["###Fulcrum Mission System Critical Error!"];
    diag_log format ["### %1  System is OFFLINE",FuMS_Version];
    diag_log format ["************************************************************************"];

}; // if critical error, exit and initialize no further for FuMS.


// Preprocess all HC files and prepare variables for transfer of HC files to HC's as they connect
_handle = [] execVM "\FuMS\HC\LoadScriptsForHCv2.sqf";
waitUntil {ScriptDone _handle};

_handle = [] execVM "\FuMS\Functions\PVEH.sqf";
waitUntil {ScriptDone _handle};


_handle = [] execVM "\FuMS\Menus\init.sqf";
waitUntil {ScriptDone _handle};

//Code to start and initialize FuMS ON the SERVER!
if (FuMS_ServerFuMSEnable) then
{
    FuMS_HCThemeControlID = 0;
    FuMS_ThemeControlID = 0;
    FuMS_HC_SlotNumber = 0;    
    
    diag_log format ["<FuMS:%2> Init: Script List size = %1",count FuMS_HC_ScriptList,FuMS_Version];
    {        
        private ["_code"];
      _code = compile (missionNamespace getVariable _x);
	// find and replace _str_ with _fnc_
	_ary = toArray _x;
	_string = "FuMS_fnc_";
	for [{_i=9},{_i< count _ary},{_i=_i+1}]do {_string = format ["%1%2",_string,toString [_ary select _i]];};	
	diag_log format ["<FuMS:%3> Init: Compiling %1  into %2",_x,_string, FuMS_Version];
	missionNamespace setVariable [_string, _code];	
    }foreach FuMS_HC_ScriptList;

    [] call FuMS_fnc_HC_FuMSNInit;
};

diag_log format ["<FuMS:%1> Init: Passing Zombie sound scripts to all players"];
publicVariable "FuMS_str_HC_Zombies_INF_fnc_nextSound";


FuMS_ServerIsClean = true;
publicVariable "FuMS_ServerIsClean";
diag_log format ["<FuMS:%1> Init.sqf:  Server side FuMS initialized and operational.",FuMS_Version];
FuMS_Server_Operational = true;
publicVariable "FuMS_Server_Operational";


