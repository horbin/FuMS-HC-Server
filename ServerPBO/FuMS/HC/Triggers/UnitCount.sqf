//UnitCount.sqf
// Horbin
// 1/4/15
// INPUTS: [array containing a trigger, and an ai limit], state
// OUTPUT: 1 if evaluation is positive
// if state = 1 then returns 1 if less than num ai within trigger evaluation radius
// if state = 2 then returns 1 if greater than num ai wihtin trigger evaluation radius
private ["_result","_data","_dt","_numAI","_dtlist1","_equality"];
_data = _this select 0;
_result = 0;
if (count _data == 2) then
{
    //_state = _this select 1;
    _equality = _this select 2;
    _dtlist1 = [];          
    _dt = _data select 0;
    _numAI = _data select 1;
    if (! isNil "_dt") then
    {
        _dtlist1 =+ list _dt;
        if (! isNil "_dtlist1") then
        {
            if (_equality =="LOW") then
            {
                //If the trigger returns less or equal to  _numAI in the area!
                //diag_log format ["###Trigger Watch:State:%2 LowUnitCount: _dtlist1:%1", count _dtlist1, _state];
                if (count _dtlist1 <= _numAI) then {_result =1;};        
            } else
            {
                if (_equality == "HIGH") then
                {
                    //If the trigger returns greater than or equal to  _numAI in the area!
                    //diag_log format ["###Trigger Watch:State:%2 HighUnitCount: _dtlist1:%1", count _dtlist1, _state];
                    if (count _dtlist1 >= _numAI) then {_result =1;};    
                };
            }
        };
    };
};
_result