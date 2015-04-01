//HasAdminAccess.sqf
// Horbin
// 3/7/15
// Input : 'player'

private ["_enable","_pUID","_pData","_dataUID","_player"];
_player = _this select 0;
_enable = false;
_pUID = getPlayerUID _player;
_pData = [_player] call FuMS_GetUserData;
diag_log format ["##HasAdminAceess: %1",_pData];
// right now if you are in the FuMS_Users list you will be granted admin access!!!!
if (!isNil "_pData") then
{
    if (count _pData != 4) then {diag_log format ["##HasAdminAccess: Error in AdminData.sqf. Found %1",_pData];}
    else
    {
        _dataUID = _pData select 1;
        if (_pUID == _dataUID) then {_enable=true;};
    };
};
_enable