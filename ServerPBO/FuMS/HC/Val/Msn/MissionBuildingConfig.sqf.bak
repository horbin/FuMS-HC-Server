//MissionBuildingConfig.sqf
// Horbin
// 3/4/15
private ["_buildings","_abort","_prefix"];
_buildings = _this select 0;
_abort = false;
_prefix = "Building Data:";
FuMS_FileError = "";
while {true} do
{
	if (isNil "_buildings") exitwith {_abort=true; FuMS_FileError = format ["%1 no data found",_prefix];};
	if (TypeName _buildings != "ARRAY") exitwith{_abort=true; FuMS_FileError = format ["%1 should be an array. Found %2",_prefix, _buildings];};
	{
		//count 4 = building => string name, location, rotation, persist flag
		// count 4 = vehicle => string name, location, rotation, array of 5
		if ([_x, 4] call FuMS_fnc_HC_Val_Util_CheckArray) exitWith {_abort=true;FuMS_FileError = format ["%1 should be array size 4. Found %2",_prefix, _x];};
		if (TypeName (_x select 0) != "STRING") exitwith {_abort=true;FuMS_FileError = format ["%1 Name should be a string. Found %2",_prefix, _x select 0];};
		if ([_x select 1] call FuMS_fnc_HC_Val_Util_VerifyLocation) exitwith {_abort=true;FuMS_FileError = format ["%1 . Found %2",FuMS_FileError, _x select 1];};
		if (TypeName (_x select 2) != "SCALAR") exitwith {_abort=true;FuMS_FileError = format ["%1 Rotation should be a number. Found %2",_prefix, _x select 2];};
		if (TypeName (_x select 3) != "SCALAR" and TypeName (_x select 3) != "ARRAY") exitwith {_abort=true;FuMS_FileError = format ["%1:Persist Flag should be number, or vehicle damage array of 5 elements. Found %2",_prefix, _x select 3];};
		if (TypeName (_x select 3) == "ARRAY") then
		{
			if (count (_x select 3) != 5)  exitwith {_abort=true;FuMS_FileError = format ["%1 Vehicle dmg array should be 5 elements. Found %2",_prefix, _x select 3];};
			{
				if (TypeName _x != "SCALAR")  exitwith {_abort=true;FuMS_FileError = format ["%1 Vehicle dmg elements should be numbers form 0.0-1.0. Found %2",_prefix, _x];};
			}foreach (_x select 3);
		};
		if (_abort) exitWith{};
	}foreach _buildings;
	if(true)exitwith{};
};
_abort;