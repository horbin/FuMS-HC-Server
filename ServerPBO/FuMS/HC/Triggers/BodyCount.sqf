//BodyCount.sqf
// Horbin
// 1/26/15
// INPUTS: [numAI, themeIndex], state
// OUTPUT: 1 if evaluation is positive
private ["_result","_data","_numAI","_themeIndex"];
_data = _this select 0;
_result = 0;
if (count _data == 2) then
{
    _numAI = _data select 0;
    _themeIndex = _data select 1;
    if (FuMS_BodyCount select _themeIndex > _numAI) then { _result = 1;};
};
_result