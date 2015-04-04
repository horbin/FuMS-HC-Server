//HC_Player_Init.sqf
// Horbin
// 12/23/14
// Init file run by all players, HC's, and the server.
diag_log format ["FuMS initializing for player:%1",player];

"FuMS_GlobalHint" addPublicVariableEventHandler
{
    private ["_GHint"];
    _GHint = _this select 1;
    hint parseText format["%1", _GHint];
};

"FuMS_TEMPVEHICLE" addPublicVariableEventHandler
{
    //    diag_log format ["#####%1 entered a tempary vehicle!",player];
    systemChat "FuMS:Warning! This vehicle will disappear on server restart!";
};

"FuMS_AIONLYVEHICLE" addPublicVariableEventHandler
{
    systemChat "FuMS: Some odd technical incompatibility prevents you from interfacing with this vehicle!";
};

FuMS_RadioMsgQue = [];

"FuMS_RADIOCHATTER" addPublicVariableEventHandler
{
    _rscLayer = "radioChatterBar" call BIS_fnc_rscLayer;
    _msg = format ["%1",_this select 1];
    FuMS_RadioMsgQue = FuMS_RadioMsgQue + [_msg];
    if (count FuMS_RadioMsgQue == 11) then
    {
        FuMS_RadioMsgQue = FuMS_RadioMsgQue - [FuMS_RadioMsgQue select 0];
    };     
    _rscLayer cutRsc["radioChatterBar","PLAIN",1,false];
    _data = "";
    for [{_i=0},{_i<count FuMS_RadioMsgQue},{_i=_i+1}] do
    {
        _line = format ["%1\n",FuMS_RadioMsgQue select _i];
        _data = format ["%1%2",_data,_line];
    };
    ((uiNamespace getVariable "radioChatterBar")displayCtrl 1010) ctrlSetText _data;
    _rscLayer cutFadeOut 20;					   
};  

//Admin Controls Menu! 
waitUntil {!isNil "FuMS_AdminControlsEnabled"};
if (FuMS_AdminControlsEnabled) then
{  
	waitUntil{!isNull (uiNameSpace getVariable ["EPOCH_loadingScreen", displayNull])};
	waitUntil{isNull (uiNameSpace getVariable "EPOCH_loadingScreen")};
	sleep 10; // something odd with Khalili or no player name, but valid 'player' function return. Pause to allow final initialization.
	while { isNil "FuMS_PlayerAuthenticated"} do
	{
		FuMS_GetPlayerIndex = player;
	publicVariableServer "FuMS_GetPlayerIndex";
		diag_log format ["##PlayerInit: %1 waiting for authentication.", FuMS_GetPlayerIndex];
		sleep 3;
	};	
	if (!isNil "FuMS_fnc_Menu_StartMenu") then {[player] spawn compile FuMS_fnc_Menu_StartMenu;};
	diag_log format ["##PlayerInit: FuMS Admin Menu = %1",(!isNil "FuMS_fnc_Menu_StartMenu")];
};
