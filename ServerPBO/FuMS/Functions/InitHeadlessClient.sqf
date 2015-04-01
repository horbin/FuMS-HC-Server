//InitHeadlessClient.sqf
// Horbin
// 2/28/15
// Inputs: HC owner id
FuMS_GetShortName = compile preprocessFileLineNumbers "\FuMS\HC\Util\GetShortName.sqf"; 
private ["_hc","_owner","_shortName"];
_owner = _this select 0;
_hc = owner _owner;
_shortName = [_owner] call FuMS_GetShortName;

diag_log format ["##FuMsnInit: Global variables being handed off too HC %2 id:%1",_hc, _owner];
_hc publicVariableClient "FuMS_FPSMinimum";
waitUntil {  diag_fps > FuMS_FPSMinimum};
_hc publicVariableClient "FuMS_ServerData";
waitUntil {  diag_fps> FuMS_FPSMinimum};
_hc publicVariableClient "FuMS_ActiveThemes";	
waitUntil {  diag_fps> FuMS_FPSMinimum};
_hc publicVariableClient "FuMS_ActiveThemesHC";	    
waitUntil { diag_fps > FuMS_FPSMinimum};
_hc publicVariableClient "FuMS_BaseTHEMEDATA";
waitUntil { diag_fps > FuMS_FPSMinimum};
_hc publicVariableClient "FuMS_BaseLOOTDATA";
waitUntil {  diag_fps > FuMS_FPSMinimum};
_hc publicVariableClient "FuMS_BaseSOLDIERDATA";
waitUntil {  diag_fps > FuMS_FPSMinimum};
_hc publicVariableClient "FuMS_GlobalDataIndex";
waitUntil {  diag_fps > FuMS_FPSMinimum};
_hc publicVariableClient "FuMS_BaseListofMissions";// Array of ["Name", "string of preprocessed code"] at each theme index.
{ 
    waitUntil {  diag_fps > FuMS_FPSMinimum};
    _hc publicVariableClient (format ["%1",_x]);
}foreach FuMS_ListofGlobalItems;
{ 
    waitUntil {  diag_fps > FuMS_FPSMinimum};
    _hc publicVariableClient (format ["%1",_x]);    
}foreach FuMS_ListofGlobalGear;    

diag_log format ["##FuMsnInit: Starting transfer of  %2 Scripts to Headless Client <%1>.",_hc, count FuMS_HC_ScriptList];  
private ["_start","_startFPS","_curFps"];
    _start = time;
    //FuMS_FPSMinimum = 15;
    _startFPS = round (diag_fps * .3);
    { 
        
        waitUntil {_curFPS = diag_fps; _curFPS > FuMS_FPSMinimum};
        
        _codeString = missionNamespace getVariable _x;
        diag_log format ["##InitHeadlessClient: FPS:%3 ---transmitting %1 to HC:%2    :",_x,_hc, _curFPS];
        _hc PublicVariableClient _x;
    }foreach FuMS_HC_ScriptList;
    _hc PublicVariableClient  "FuMS_HC_ScriptList";
    
    if (count FuMS_HCIDs == 1) then
    {
        FuMS_HCIDs set [1,_hc];
        FuMS_HCThemeControlID = 1;
        FuMS_HCNames set [1, _shortName];
    }else
    {
        private ["_oldSlotFound"];
        _oldSlotFound = false;
        for [{_i=1},{_i< count FuMS_HCIDs},{_i=_i+1}] do
        {
            if (FuMS_HCIDs select _i == -1) then
            {
                FuMS_HCIDs set [_i,_hc];
                FuMS_HCThemeControlID = _i;
                FuMS_HCNames set [_i, _shortName];
                _oldSlotFound = true;
            };
        };
        if (!_oldSlotFound) then
        {
            FuMS_HCThemeControlID = count FuMS_HCIDs; // index is equal to size BEFORE it is added.
            FuMS_HCIDs pushback _hc;
            FuMS_HCNames pushback _shortName;
        };
    };
    _hc publicVariableClient "FuMS_HCThemeControlID";
    diag_log format ["##FuMsnInit: Script Transfer complete to Headless Client <%1> in %2 secs",_hc, time-_start];    
    
// Push HC info to all Admin clients
{
    _x publicVariableClient "FuMS_HCIDs";
    _x publicVariableClient "FuMS_HCNames";
}foreach FuMS_AdminIDs;

//FuMS_Server_Operational = true; // placed here also, due to random hang-ups by the HC. Seems it does not get the broadcast value during JIP....sometimes.
//publicVariable "FuMS_Server_Operational";





