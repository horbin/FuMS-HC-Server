//MissionTriggerConfig.sqf
// Horbin
// 3/4/15
private ["_triggers","_abort","_prefix","_dat2","_state","_states","_msg","_foundTrigger","_trigName"];
_triggers = _this select 0;
_abort = false;
_prefix = "Trigger Data:";
_state = 0;
_states = ["Win","Lose","Phase01","Phase02","Phase03","NO TRIGGER"];
_msg = "";
_foundTrigger = false;
FuMS_FileError = "";
while {true} do
{
	if (isNil "_triggers") exitwith {_abort=true; FuMS_FileError = format ["%1 no data found",_prefix];};
	if ([_triggers,6] call FuMS_fnc_HC_Val_Util_CheckArray) exitwith{_abort=true; FuMS_FileError = format ["%1 should be array of 6 elements. Found %2",_prefix, _triggers];};
	{
	  _msg = format ["%1%2 state:",_prefix, _states select _state];
      if (TypeName _x != "ARRAY") exitWith {_abort=true;FuMS_FileError = format ["%1 is not an array. Found %2",_msg,_x];};
	  {
		if (TypeName _x != "ARRAY") exitWith {_abort=true;FuMS_FileError = format ["%1 has a trigger that is not an array. Found %2",_msg,_x];};
		_trigName = _x select 0;
		if (TypeName _trigName != "STRING")exitWith {_abort=true;FuMS_FileError = format ["%1 trigger's 1st paramater must be a string. Found %2",_msg,_trigName];};
		switch (toupper _trigName) do
		{
			case "LOWUNITCOUNT":
			{	//string (east,west,guer,civ,logic,resistance) num, num, location]
				_foundTrigger = true;
				if (count _x != 5) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""%2"",side, numAI, radius, [loc]] Found %3",_msg,_trigName,_x];};
				_dat2=_x select 1;
				_dat2 = toupper _dat2;
				if (TypeName (_x select 1) != "STRING") exitWith{_abort=true;FuMS_FileError = format ["%1:%2 Side should be West,East,Guer, or Civ. Found %3",_msg,_trigName,_x select 1];};
				if (_dat2 !="EAST" and _dat2 !="WEST" and _dat2 !="GUER" and _dat2!= "CIV" and _dat2 != "LOGIC" and _dat2 != "CIVILIAN" and _dat2 != "RESISTANCE")
				 exitwith{_abort=true;FuMS_FileError = format ["%1:%2 Side should be West,East,Guer, or Civ. Found %3",_msg,_trigName,_dat2];};
				if (TypeName (_x select 2) != "SCALAR") exitwith{_abort=true;FuMS_FileError = format ["%1:%2 Number of AI should be a number. Found %3",_msg,_trigName,_x select 2];};
				if (TypeName (_x select 3) != "SCALAR")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 radius should be a number. Found %3",_msg,_trigName,_x select 3];};
				if ([_x select 4] call FuMS_fnc_HC_Val_Util_VerifyLocation) exitwith {_abort=true;FuMS_FileError = format ["%1:%2 %4 Found %3",_msg,_trigName,_x select 4, FuMS_FileError];};				
			};
			case "PROXPLAYER":
			{  // location, num, num
				_foundTrigger = true;
				if (count _x != 4) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""PROXPLAYER"", [loc], radius, numplayers]. Found %3",_msg,_trigName,_x];};
				if ([_x select 1] call FuMS_fnc_HC_Val_Util_VerifyLocation) exitwith {_abort=true;FuMS_FileError = format ["%1:%2 %4 Found %3",_msg,_trigName,_x select 2, FuMS_FileError];};				
				if (TypeName (_x select 2) != "SCALAR")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 radius should be a number. Found %3",_msg,_trigName,_x select 2];};
				if (TypeName (_x select 3) != "SCALAR")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 number AI should be a number. Found %3",_msg,_trigName,_x select 3];};
			};
			case "REINFORCE":
			{ // num, string
				_foundTrigger = true;
				if (_state != 0) exitwith {_abort=true;FuMS_FileError=format ["%1:%2 Must only be in the Win state. It was found in the %3 state",_msg, _trigName, _states select _state];};
				if (count _x != 3) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""%2"", Chance(1-100),""Mission to Run""]. Found %3",_msg,_trigName,_x];};
				if (TypeName (_x select 1) != "SCALAR")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 Chance should be 1-100. Found %3",_msg,_trigName,_x select 1];};			
				if (TypeName (_x select 2) != "STRING")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 Mission should be a string. Found %3",_msg,_trigName,_x select 2];};
			};
			case "BODYCOUNT":
			{ // num
			if (count _x != 2) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""%2"", numAI]. Found %3",_msg,_trigName,_x];};
			if (TypeName (_x select 1) != "SCALAR")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 Number AI should be a number. Found %3",_msg,_trigName,_x select 1];};			
			};
			case "HIGHUNITCOUNT":
			{ // same as lowunitcount
				_foundTrigger = true;
				if (count _x != 5) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""%2"",side, numAI, radius, [loc]] Found %3",_msg,_trigName,_x];};
				_dat2=_x select 1;
				_dat2 = toupper _dat2;
				if (TypeName (_x select 1) != "STRING")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 Side should be West,East,Guer, or Civ. Found %3",_msg,_trigName,_x select 1];};
				if (_dat2 !="EAST" and _dat2 !="WEST" and _dat2 !="GUER" and _dat2!= "CIV" and _dat2 != "LOGIC" and _dat2 != "CIVILIAN" and _dat2 != "RESISTANCE")
				 exitwith{_abort=true;FuMS_FileError = format ["%1:%2 Side should be West,East,Guer, or Civ. Found %3",_msg,_trigName,_dat2];};
				if (TypeName (_x select 2) != "SCALAR") exitwith{_abort=true;FuMS_FileError = format ["%1:%2 Number of AI should be a number. Found %3",_msg,_trigName,_x select 2];};
				if (TypeName (_x select 3) != "SCALAR")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 radius should be a number. Found %3",_msg,_trigName,_x select 3];};
				if ([_x select 4] call FuMS_fnc_HC_Val_Util_VerifyLocation) exitwith {_abort=true;FuMS_FileError = format ["%1:%2 %4 Found %3",_msg,_trigName,_x select 4, FuMS_FileError];};				
			};
			case "TIMER":
			{ // num
				_foundTrigger=true;
				if (count _x != 2) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""%2"", time in seconds]. Found %3",_msg,_trigName,_x];};
				if (TypeName (_x select 1) != "SCALAR")exitwith {_abort=true;FuMS_FileError = format ["%1:%2 time(in seconds) should be a number. Found %3",_msg,_trigName,_x select 1];};			
			};
			case "DETECTED":
			{  // num, num
			_foundTrigger=true;
				if (count _x != 3) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""%2"", group#, vehicle#]. Found %3",_msg,_trigName,_x];};
				if (TypeName (_x select 1) != "SCALAR") exitwith {_abort=true;FuMS_FileError = format ["%1:%2 group# should be a number. Found %3",_msg,_trigName,_x select 1];};							
				if (TypeName (_x select 2) != "SCALAR") exitwith {_abort=true;FuMS_FileError = format ["%1:%2 vehicle# should be a number. Found %3",_msg,_trigName,_x select 2];};			
			};
			case "NO TRIGGERS":
			{  // nothing else
				if (_state != 5)exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should only be in the NOTRIGGER state. Found in %3 state",_msg,_trigName,_states select _state];};
				if (count _x != 1) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""%2""]. Found %3",_msg,_trigName,_x];};
				if (_foundTrigger) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 Other triggers found in this mission. Ensure they are commented out, because they will be ignored when NO TRIGGERS is selected!",_msg,_trigName];};
			};
            	case "ALLDEADORGONE":
			{  // nothing else
				_foundTrigger = true;
				if (count _x != 1) exitWith {_abort=true;FuMS_FileError = format ["%1:%2 should be [""%2""]. Found %3",_msg,_trigName,_x];};			
			};
			default {_abort=true; FuMS_FileError = format ["%1 invalid Trigger name. Found %2",_msg,_trigName];};
		};
		if (_abort) exitWith{};
	  }foreach _x;
	  if (_abort) exitWith{};
      _state = _state + 1;
	}foreach _triggers;
	if(true)exitwith{};
};
_abort;