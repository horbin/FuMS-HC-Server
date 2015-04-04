//AllDeadorGone.sqf
// Horbin
// 2/14/15
// INPUTS: [themeIndex], state
// OUTPUT: 1 if evaluation is positive
private ["_result","_dataarray"];
_dataarray = _this select 0;
_result = 0;
if (count _dataarray == 1) then
{
    private ["_themeIndex","_list","_var"];
    _result = 1;
    _themeIndex = _dataarray select 0;
	
	// find all the AI objects on the map.
    //"I_Soldier_EPOCH"
  //  diag_log format ["##AllDeadorGone: MapCenter:%1  MapRange:%2",MapCenter, MapRange];
//	_list = MapCenter nearEntities MapRange;
    _list = allUnits;
    //diag_log format ["##AllDeadorGone:Theme:%2    # soldiers found: %1", count _list, _themeIndex];
	// for each AI object, look for the XFILL variable
	{
	// if XFILL select 0 == "themeIndex" => result = 0;	
		_var = _x getVariable "FuMS_XFILL";
		if (!isNil "_var") then
		{
           // diag_log format ["##AllDeadorGone: Unit: %2 _var:%1",_var,_x];
			if (_var select 0 == _themeIndex) then {_result = 0;};
		}
	}foreach _list
};
//diag_log format ["##AllDeadorGone: result:%1",_result];
_result