//roaming.sqf
private ["_me","_initialPos","_randX","_randY","_randNX","_randNY","_negatX","_negatY","_finalPosX","_finalPosY","_finalPos","_randomPosture"];
	_me=_this select 0;
	_initialPos=_this select 1;
	_randX= random 50;
	_randY= random 50;
	_randNX= floor (random 2);
	_randNY= floor (random 2);
	_negatX=false;
	_negatY=false;
	_finalPosX= 0;
	_finalPosY= 0;
	//random Negative
	if(_randNX<=0.90)then{
		_negatX=true;
	}else{
		_negatX=false;
	};
	if(_randNY<=0.90)then{
		_negatY=true;
	}else{
		_negatY=false;
	};
	//
	if(_negatX)then{
		_finalPosX= -(_randX);
	}else{
		_finalPosX= _randX;
	};
	if(_negatY)then{
		_finalPosY= -(_randY);
	}else{
		_finalPosY= _randY;
	};
	_finalPos=[(_initialPos select 0)+_finalPosX,(_initialPos select 1)+_finalPosY,0];
	doStop _me;
	sleep 0.1;
	(_me)domove(_finalPos);
	sleep 0.1;
	_me setSpeedMode "LIMITED";
	_randomPosture = floor (random 5);
	if (_randomPosture==0)then{_me setUnitPosWeak "DOWN";};
	if (_randomPosture==1)then{_me setUnitPosWeak "Middle";};
	if (_randomPosture>=2)then{_me setUnitPosWeak "UP";};
    
    
