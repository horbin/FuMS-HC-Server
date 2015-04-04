//ZNearestTarget.sqf
private ["_me","_finalTarget","_playerList","_targetList","_playerNear","_nearestPlayers","_seenPlayers",
"_totalP","_dist","_seen","_total","_round","_spotted","_target"];
	_me=_this ;
	_finalTarget=[];
	_playerList=[];
	_targetList = _me nearEntities [["Man"], 75];
//diag_log format ["##ZNearestTarget: List of ""Car"" and ""Man"": %1",_targetList];
	{
		  ///if (isPlayer _x && (alive _x) ) then { _playerList = _playerList + [_x] };		//List BLUFOR players only
		if ((alive _x )) then 
        {
            if (isPlayer _x or side _x == resistance) then
            {
            _playerList = _playerList + [_x];
            };
        }; // needs further checking for 'side' for AI
	} forEach _targetList;
	_playerNear=false;
	_nearestPlayers =[];
	_seenPlayers =[];
	_spotted=false;
//    diag_log format ["##ZNearestTarget %1 found %2",_me, _playerList];
	_totalP= count _playerList;
	if (_totalP==0)then{
		_finalTarget=[];
	}else{
		{
			_dist = _me distance _x;
			if (_dist < 75) then { 
				_nearestPlayers = _nearestPlayers + [_x];
				_playerNear=true;
			};   
		} foreach _playerList;
        
           FuMS_ZombieTransform = _playerList;
            publicVariableServer "FuMS_ZombieTransform";
        
		if (_playerNear) then {
			{
				_target= _x;
       //         diag_log format ["##ZNearestTarget  %1 running 'Contact', located player %2",_me,_x];
				_seen=[_me,_target]call FuMS_fnc_HC_Zombies_Logic_Contact;
				if (_seen) then { _seenPlayers = _seenPlayers + [_x]};
				//_spotted=true;
			} forEach _nearestPlayers;
			_total= count _seenPlayers;
			
			if (_total==0)then{
				_finalTarget=[];
			}else{
				_round = floor (random (_total-1));
				_finalTarget= [_seenPlayers select _round];
        //        diag_log format ["##ZNearestTarget: %1 targeted from list of seen players %2",_finalTarget, _seenPlayers];
				if (!(alive _target))then
				{
					_finalTarget=[];
				};
			};
		};
	};
	_finalTarget;