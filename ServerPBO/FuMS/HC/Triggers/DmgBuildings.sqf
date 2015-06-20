//DmgBuildings.sqf
// Horbin
// 6/3/15
// INPUTS: ["Which Buildings", %amount to damage, _themeIndex], list of buildings, state
// OUTPUT: 1 if evaluation is positive
private ["_result","_data","_amountDamage","_buildings","_list","_counter"];
_data = _this select 0;
_result = 0;

// test _data, if it does not contain the proper number of fields, do nothing and return FALSE!
if (count _data == 3) then
{
    _buildings = _this select 1;
    //_whichBuildings = _data select 0; // "ALL","1-4","2,3,4","5"
    _amountDamage = _data select 1;
    _list = _data select 2;
    
    // find which buildings should be checked
    //    store index to which in an array
    //_list = [_whichBuildings, count _buildings] call FuMS_fnc_HC_MsnCtrl_Util_GetIndexers;
    // _list is an array of numbers that represent an index reference in the _buildings array
    //diag_log format ["<FuMS> Triggers:DmgBuildings: Following being watched: indexers:%1",_list];
    //diag_log format ["<FuMS> Triggers:DmgBuildings: In list of :%1",_buildings];
    // loop through the array, reference index _buildings
    _counter = 0;
    {
        private ["_damage"];
        _damage = getDammage (_buildings select _x);
      //  diag_log format ["<FuMS> Triggers:DmgBuildings: Index:%5 count:%1 Dmg:%2(%3) %4",_counter,_damage,_amountDamage,_buildings select _x,_x];
        if (_damage >= _amountDamage) then { _counter = _counter + 1;};
    }foreach _list;
    //  check if getDamage is 0 = healthy  1=totally destroyed
    //   if damage is above _amountDamage then increment counter
    
    // if counter == count array of references then all are 'destroyed'
    //    set _result to 1
    if (_counter == count _list) then {_result = 1;};
};
_result