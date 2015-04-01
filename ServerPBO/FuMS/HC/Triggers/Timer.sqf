//Timer.sqf
//Horbin
// 1/11/15
//INPUTS: [expiration time, state]
//OUTPUTS: 1 if time has expired.
private ["_expirationTime","_result","_data"];
_data = _this select 0;
_result = 0;
//diag_log format ["*Timer.sqf called with %1",_data];
if (count _data > 0) then
{
    _expirationTime = _data select 0;
    //diag_log format ["##Timer :  expire at:%1  current:%2",_expirationTime, time];
    if ( (time) > _expirationTime) then{_result = 1;};
};
_result