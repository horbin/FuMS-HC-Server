//Attack.sqf
private ["_me","_imHere","_isInVehicle","_targetPos","_distance","_asleep","_myTarget","_initialPos","_nextTarget","_target"];
	_me=_this select 0;
	_myTarget= _this select 1;
	_initialPos=_this select 2;
	_imHere=false;
	_me joinAsSilent [FuMS_AttackingZombieGroup, 1];
	missionNamespace setVariable [format ["%1_nextTarget",_me], _myTarget];
	while{(alive _me)and(count _myTarget != 0)}do
	{
		_nextTarget = missionNamespace getVariable format ["%1_nextTarget",_me];
		if ((str _nextTarget) != (str _myTarget)) then
		{
			_myTarget= _nextTarget;
		};
		_target= _myTarget select 0;
        /*
		if(!(vehicle _target isKindOf "man"))then
		{
			_isInVehicle=missionNamespace getVariable format ["%1_playerIn", _target];
			if(!(_isInVehicle select 0))then
			{
				_target=_isInVehicle select 1;
			};
		};
        */
		_targetPos = getposATL _target;
		if(surfaceIsWater _targetPos) then
		{
			_targetPos = getposASL _target;
		};
		_distance=(_targetPos distance _me);
		(_me)doMove(_targetPos);
		_me setSpeedMode "FULL";
		if((_distance<=20)and(!_imHere))then
		{
			_imHere=true;
			//[_me, "idle"] spawn INF_fnc_NextSound;
//			[[_me,"idle"], "FuMS_INF_fnc_NextSound"] call BIS_fnc_MP;
            [_me,"idle"] call FuMS_fnc_HC_Zombies_Logic_Znoise;
		};
		if(_distance<=2.5)then
		{	
			if ((alive _me) and (alive _target))then
			{
				_me switchMove "AwopPercMstpSgthWnonDnon_throw";
				sleep 0.2;
				_target setDamage (damage _target + 0.34);
				//[_me, "punch"] spawn INF_fnc_NextSound;
			//	[[_me,"punch"], "FuMS_INF_fnc_NextSound"] call BIS_fnc_MP;
                  [_me,"punch"] call FuMS_fnc_HC_Zombies_Logic_Znoise;
				sleep 2;
			};
		};
		if(!alive _target)then
		{
			sleep 2;
			_myTarget= _me call FuMS_fnc_HC_Zombies_Logic_ZNearestTarget;
		};
		if(_distance>100)then
		{
      //      diag_log format ["##Attack: %1 :: players outside 100m, looking for more",_me];
			_myTarget=_me call FuMS_fnc_HC_Zombies_Logic_ZNearestTarget;
		};
		
		_asleep= 1+(random 1);
		sleep _asleep;
	};
	if(!alive _me)then
	{
		_me removeAllEventHandlers "hit";
		sleep 120;
		deleteVehicle _me;
	}else{
 // diag_log format ["##Attack: %1 :: done attacking, reverting to Roam",_me];      
		[_me,_initialPos] spawn FuMS_fnc_HC_Zombies_Logic_Roam;
	};
    
    
    
    