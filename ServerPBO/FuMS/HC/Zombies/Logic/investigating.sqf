//investigating.sqf
private ["_asleep","_me","_target","_targetPos"];
		_asleep= random 1;
		sleep _asleep;
		_me = _this select 0;
		_target = _this select 1;
		_me removeAllEventHandlers "firedNear";
		_targetPos = getposATL _target;
		if(surfaceIsWater _targetPos) then
		{
			_targetPos = getposASL _target;
		};
		_me domove _targetPos;
//		[[_me,"hurt"], "FuMS_INF_fnc_NextSound"] call BIS_fnc_MP;
        [_me, "hurt"] call FuMS_fnc_HC_Zombies_Logic_Znoise;
		sleep 15;        
		_me addEventHandler ["firedNear",
		{
     //       diag_log format ["##Investigating:  %1 heard noise from %2",_me, _target];
			if ((str (_this select 4)) in ["muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG"]) exitwith {};
			[_this select 0, _this select 1] spawn FuMS_fnc_HC_Zombies_Logic_Investigating;
        }];