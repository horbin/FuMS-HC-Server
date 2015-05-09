//LogicBomb.sqf
// Horbin
// 1/4/15
//INPUTS: missionData, TriggerData, MsnObjects
//OUTPUTS: "WIN" or "LOSE" or "NO TRIGGERS"
// Data passed into this script.
//ProxPlayer = compile preprocessFileLineNumbers "HC\Encounters\LogicBomb\ProxPlayer.sqf";
//UnitCount = compile preprocessFileLineNumbers "HC\Encounters\LogicBomb\UnitCount.sqf";
//Detect = compile preprocessFileLineNumbers "HC\Encounters\LogicBomb\Detect.sqf";
//Timer = compile preprocessFileLineNumbers "HC\Encounters\LogicBomb\Timer.sqf";
//GetBodyCount = compile preprocessFileLineNumbers "HC\Encounters\LogicBomb\BodyCount.sqf";
//PullData = compile preprocessFileLineNumbers "HC\Encounters\Functions\PullData.sqf";
//AllDeadorGone = compile preprocessFileLineNumbers "HC\Encounters\LogicBomb\AllDeadorGone.sqf";
//HCDEBUG = "LOGICBOMB";
HCDEBUG = " ";
private ["_triggerData","_eCenter","_encounterSize","_groups","_vehicles","_missionTheme","_instanceTriggers","_curMission",
"_triggerArray", "_i","_msnStatus","_missionData","_phaseData","_phase01","_msnObjects","_themeIndex","_buildingData",
"_groups","_vehicles","_boxes","_phase02","_phase03","_buildings",
"_reinforcements","_reinforceMsn"];

_missionData = _this select 0;
_triggerData = _this select 1;
_msnObjects = _this select 2;

_missionTheme = _missionData select 0;
_eCenter = _missionData select 1;
_encounterSize = _missionData select 2;
_phaseData = _missionData select 3;
_themeIndex = _missionData select 4;
_curMission = _missionData select 5;

_buildingData = _msnObjects select 0;
_buildings = _msnObjects select 1;
_groups = _msnObjects select 2;
_vehicles = _msnObjects select 3;
_boxes = _msnObjects select 4;

if (count _phaseData >0 ) then {_phase01 =  _phaseData select 0;};
if (count _phaseData >1) then {_phase02 =  _phaseData select 1;};
if (count _phaseData >2 ) then {_phase03 = _phaseData select 2;};
//diag_log format ["##Logic Bomb: phase01: %1",_phase01];
private ["_state","_proxPlayer","_lowUnitCount","_highUnitCount","_detected", "_stateMax","_timer","_bodyCount","_allDeadorGone","_zupaCapture"];
// nul out all positions so 'select' does not fire a zero divisor exception!
_proxPlayer = [ [],[],[],[],[] ];  //[pos, range, numplayers]
_lowUnitCount = [ [],[],[],[],[] ];//[trigger, numAI]
_highUnitCount = [ [],[],[],[],[] ];//[trigger, numAI]
_detected = [ [],[],[],[],[] ]; //[group, vehicle]
_timer = [ [],[],[],[],[] ]; //[expireTime]
_bodyCount = [ [],[],[],[],[] ]; //[numberAI]
_allDeadorGone=[ [],[],[],[],[] ]; //[nothing]
_zupaCapture =[ [],[],[],[],[] ]; //[pos, radius, time, mission name]
_triggerArray= [_proxPlayer, _lowUnitCount, _highUnitCount, _detected, _timer, _bodyCount, _allDeadorGone, _zupaCapture];  
_instanceTriggers = []; // used for end of mission cleanup of triggers.

_stateMax = [0,0,0,0,0]; // 5 states, win/lose/p1,p2,p3

_reinforcements = 0;
_reinforceMsn = "";
// win, lose, phase01, phase02, and phase03
_state = 0;
if (count (_triggerData select 5) == 0)  then // NO TRIGGERS is commented out.
// triggerData 0:win, 1:lose, 2:phase1, 3:phase2, 4:phase3, 5:notriggers
// If 'NO TRIGGERS' skip trigger initialization!
{
    {
        private ["_curState"];
        switch (_state) do
        {
            case 0: {_curState = "WIN";};
            case 1: {_curState = "LOSE";};
            case 2: {_curState = "Phase01";};
            case 3: {_curState = "Phase02";};
            case 4: {_curState = "Phase03";};
        };        
       // diag_log format ["##Trigger Set:State:%1 :: %2 initializing", _state,_x];
        {
            private ["_trigName"];
            _trigName = _x select 0;
            // change _trigName to all CAPS
            _trigName = toUpper _trigName;
            switch (_trigName) do
            {
                case "PROXPLAYER":
                {
                    private ["_range","_offset","_dt","_numPlayers","_pos"];
                    _range = _x select 2;
                    _offset = _x select 1;
                    _numPlayers = _x select 3;
                    _pos = [_eCenter, _offset] call FuMS_fnc_HC_MsnCtrl_Util_XPos;
                   // diag_log format ["##Trigger Set: ProxPlayer State:%3 %1:%2",_pos, _range, _state];
                    _proxPlayer  set [_state, [_pos, _range, _numPlayers]];
                    _stateMax set [_state, (_stateMax select _state) + 1];
                };
                case "LOWUNITCOUNT":
                {
                    private ["_side","_numAI","_radius","_offset","_dt","_pos"];
                    _side = _x select 1;
                    _numAI = _x select 2;
                    _radius = _x select 3;
                    _offset = _x select 4;
                    _pos = [_eCenter, _offset] call FuMS_fnc_HC_MsnCtrl_Util_XPos;
                    if (_radius == 0) then { _radius = _encounterSize;};
                 //   diag_log format ["##Trigger Set: LowUnitCount State:%1 #AI%2 Pos:%3 Radius:%4",_state, _numAI, _pos, _radius];
                    _dt = createTrigger ["EmptyDetector", _pos];
                    _instanceTriggers = _instanceTriggers +[_dt];
                    _dt setTriggerArea [ _radius, _radius,0,false];
                    // PRESENT vs, NOT PRESENT so trigger will count AI to enable compare to _numAI in status loop.
                    _dt setTriggerActivation [_side, "PRESENT", false];
                    _lowUnitCount set [_state, [_dt, _numAI] ];
                    _stateMax set [_state, (_stateMax select _state) + 1];
                };
                case "HIGHUNITCOUNT"://"HighUnitCount", "GUER",10,40,[0,0]]
                {
                    private ["_side","_numAI","_radius","_offset","_dt","_pos"];
                    _side = _x select 1;
                    _numAI = _x select 2;
                    _radius = _x select 3;
                    _offset = _x select 4;
                    _pos = [_eCenter, _offset] call FuMS_fnc_HC_MsnCtrl_Util_XPos;
                    if (_radius == 0) then { _radius = _encounterSize;};
                    //diag_log format ["##Trigger Set: HighUnitCount State:%1 #AI%2 Pos:%3 Radius:%4",_state, _numAI, _pos, _radius];
                    //                    _dt = createTrigger ["EmptyDetector", _pos];
                    _highUnitCount set [_state, [createTrigger["EmptyDetector",_pos], _numAI] ];
                    _dt = (_highUnitCount select _state) select 0;
                    _instanceTriggers=_instanceTriggers + [_dt];
                    _dt setTriggerArea [ _radius, _radius,0,false];
                    _dt setTriggerActivation [_side, "PRESENT", false];
                    _stateMax set [_state, (_stateMax select _state) + 1];
                };
                case "DETECTED": //["Detected", groups, vehicles]
                {
                    private ["_grpDet","_vehDet"];
                    _grpDet = _x select 1;
                    _vehDet = _x select 2;
                    //diag_log format ["##Trigger Set: Detected State:%3 Groups:%1 Vehicles:%2",_grpDet, _vehDet, _state];
                    _detected  set [_state, [_grpDet, _vehDet]];
                    _stateMax set [_state, (_stateMax select _state) + 1];     
                };
                case "TIMER": // [ExpireTime] - time from when this initializes that timer expires
                {
                    private ["_elapsedTime","_expireTime"];
                    _elapsedTime = _x select 1;
                    _expireTime = time + _elapsedTime;
                    //diag_log format ["##Logic Bomb: time:%1 elapsed:%2 exipre:%3",time, _elapsedTime, _expiretime];
                    _timer  set [_state, [_expireTime]];
                    _stateMax set [_state, (_stateMax select _state) + 1];     
                };
                case "REINFORCE": // should only appear in 'win' section, so no specific 'state' handling required.
                {
                    _reinforcements = _x select 1;
                    _reinforceMsn = _x select 2;
                };
                case "BODYCOUNT":
                {
                    private ["_numAI"];
                    _numAI = _x select 1;
                    _bodyCount set [_state, [_numAI, _themeIndex]];
                    _stateMax set [_state, (_stateMax select _state) + 1];
                    FuMS_BodyCount set [_themeIndex, 0]; // common counter for all states!
                };
                case "ALLDEADORGONE":
                {
                    _allDeadorGone set [_state, [_themeIndex]];
                    _stateMax set [_state,(_stateMax select _state) + 1];
                };
                case "ZUPACAPTURE":
                {
                    private ["_arrayOfData"];
                    _arrayOfData = _x select 1;
                    [_arrayOfData, _themeIndex, _curMission,_eCenter] call FuMS_fnc_HC_Triggers_ZuppaCapture;
                  //  FuMS_Trigger_ZupaCapture set [_themeIndex,false];
                   // FuMS_Trigger_ZupaCapture set [_themeIndex, false];
                    _zupaCapture set [_state, [_arrayOfData, _themeIndex, _curMission]];
                    _stateMax set [_state,(_stateMax select _state) + 1];
                };
            };      
        }forEach _x; // step through each Trigger/EH option based upon the above 'cases'   
        // each State will have an associated array. The array is index off the case# of _trigName.
        // Example:  'state' select 2 would reference "HighUnitCount"
        _state = _state + 1;
    }forEach _triggerData;    
    // pass to server, so if HC disconnects the triggers don't run 'stale' on the server!!!!
    ["Triggers",_instanceTriggers] call FuMS_fnc_HC_Util_HC_AddObject;   
    //Troubleshooting Data Process.
    if (HCDEBUG=="LOGICBOMB") then
    {
    diag_log format ["##LogicBomb:_1:%2#######################",_themeIndex, _curMission];
    diag_log format ["######################################################"];
    diag_log format ["_proxPlayer: %1", _proxPlayer];
    diag_log format ["_lowUnitcount: %1", _lowUnitCount];
    diag_log format ["_highUnitcount: %1", _highUnitCount];
    diag_log format ["_detected: %1", _detected];
    diag_log format ["_timer: %1", _timer];
    diag_log format ["_bodyCount: %1", _bodyCount];
        diag_log format ["_allDeadorGone: %1", _allDeadorGone];
    diag_log format ["Reinforcements: %1 chance, missionFile:%2", _reinforcements, _reinforceMsn];
    diag_log format ["_stateMax: %1",_stateMax];
    diag_log format ["######################################################"];
    diag_log format ["######################################################"];
    };
};
// for any state that had no triggers set its max to something that would never be reached.
for [{_i=0},{_i < 5},{_i = _i+1}] do
{
    if ((_stateMax select _i) == 0)  then { _stateMax set [_i, -1];};
};
//diag_log format ["##LogicBomb: _stateMax:%1  entering logic loop", _stateMax];
if (count (_triggerData select 5) == 0)  then // NO TRIGGERS is commented out so logic loop desired!
{
    // Babysit the Triggers now!!!!
    // _phasXRan is flag variable. If '1' it implies the associated PhaseX change has occured.
    //   used to prevent repeative spawning of linked events.
    //  follow on mission can be set up to return a value that resets this flag to permit phase to occur again.
    private ["_missionKillIndex"];
    _msnStatus = "RUNNING";
    //_phase01Status = "NA";
  // _phase02Status = "NA";
  // _phase03Status = "NA";
    
    _missionKillIndex = count FuMS_ActiveMissions;
    FuMS_ActiveMissions = FuMS_ActiveMissions + [ [_missionKillIndex, format ["%1:%2", _curMission,_missionTheme]] ];  
    missionNameSpace setVariable [format["FuMS_AdminActiveMissionList%1",FuMS_ThemeControlID],FuMS_ActiveMissions];
    FuMS_AdminUpdateData = [FuMS_ThemeControlID, "AdminActiveMissionList",FuMS_ActiveMissions];
    publicVariableServer "FuMS_AdminUpdateData";

    while {_msnStatus != "WIN" and _msnStatus !="LOSE" and _msnStatus != "KILL"} do
    {
        private ["_curState","_i","_dt","_dtlist0","_dtlist1","_data","_numAI","_triggerCount","_nearFolks","_range","_endMission"];     
        FuMS_ActiveMissions = missionNameSpace getVariable format ["FuMS_AdminActiveMissionList%1",FuMS_ThemeControlID];
        _endMission = (FuMS_ActiveMissions select _missionKillIndex) select 1;
        if (!isNil "_endMission") then {if (_endMission == "KILL") exitWith {_msnStatus = "KILL";};};
        
        _dtlist1 = [];
        for [{_i=0},{_i < 5},{_i = _i+1}] do // go through each of the states checking status of their triggers
        {
            _triggerCount = 0;  // reset count as each State is checked!
            if (_stateMax select _i > 0 ) then // There are some triggers for this state.
            {
                //******************************
                //_proxPlayer [pos, range, numPlayers] 
                _triggerCount = _triggerCount + ([(_triggerArray select 0) select _i,_i] call FuMS_fnc_HC_Triggers_ProxPlayer);               
                //***********************************
                //_lowUnitCount [trigger, numAI]
                _triggerCount = _triggerCount + ([(_triggerArray select 1) select _i,_i,"LOW"] call FuMS_fnc_HC_Triggers_UnitCount);
                //***********************************
                //_highUnitCount [trigger, numAI] 
                _triggerCount = _triggerCount + ([(_triggerArray select 2) select _i,_i,"HIGH"] call FuMS_fnc_HC_Triggers_UnitCount);
                //*************************************
                // _detected [group, vehicle]
                _triggerCount = _triggerCount + ([(_triggerArray select 3) select _i,_groups, _vehicles, _i] call FuMS_fnc_HC_Triggers_Detect);
                //**************************************
                // _timer [expirationTime]
                _triggerCount = _triggerCount  + ([(_triggerArray select 4) select _i, _i] call FuMS_fnc_HC_Triggers_Timer);
                //***************************************
                // _bodyCount [numAI, range]
                _triggerCount = _triggerCount + ( [(_triggerArray select 5) select _i, _i] call FuMS_fnc_HC_Triggers_BodyCount);
                // _allDeadorGone [themeIndex]
                _triggerCount = _triggerCount + ( [(_triggerArray select 6) select _i, _i] call FuMS_fnc_HC_Triggers_AllDeadorGone);
                //  _zupaCapture set [_state, [_pos, _radius, _capTime, _curMission ]];
              //  diag_log format ["<FuMS:%1> LogicBomb:ThemeIndex:%3 FuMS_Trigger_ZupaCapture = %2",FuMS_Version,FuMS_Trigger_ZupaCapture,_themeIndex];
                _ZupaFlag = _zupaCapture select _i; // if this state has defined a zupacapture point trigger then check its status.
                if (!isNil "_ZupaFlag") then 
                {
                    if (FuMS_Trigger_ZupaCapture select _themeIndex) then { _triggerCount = _triggerCount + 1;} ;  
                };
            }; 
            if (_triggerCount == (_stateMax select _i) ) then
            {
                private ["_msnPhaseName","_msnPhaseLoc"];
                switch (_i) do
                {
                    case 0: {_msnStatus = "WIN";};
                    case 1: {_msnStatus = "LOSE";};
                    case 2: 
                    {
                        private ["_dataFromServer","_result","_missionNameOverride"];
                        if (isNil "_phase01") exitWith
                        {
                            diag_log format ["************************************************************"];
                            diag_log format ["##LogicBomb: ERROR: %1\%2.sqf! Phase trigger found w/o a phase mission to execute!", (((FuMS_THEMEDATA select _themeIndex) select 0) select 0), _curMission];
                            diag_log format ["************************************************************"];
                        };
                        private ["_waitPhase01","_phase01ID","_childData"];
                        // Now that the phase has been triggered, set this phases MaxTriggers so it will not continue to run.
                        _stateMax set [_i, -1];      
                        FuMS_PhaseMsnID = FuMS_PhaseMsnID + 1;
                        // retain the phaseID so the child's objects can be referenced by this mission after the child exits.
                        _phase01ID = FuMS_PhaseMsnID;
                        diag_log format ["************************************************************"];
                       diag_log format ["##LogicBomb: PHASE TRANSITION: %3: Starting %1:%2",_phase01ID, _phase01,_curMission];
                        diag_log format ["************************************************************"];    
                        if (typeName _phase01 == "ARRAY") then
                        {
                            _msnPhaseName = _phase01 select 0;                         
                        }else
                        {
                            _msnPhaseName = _phase01;                           
                        };
                         _msnPhaseLoc = _eCenter;                        
                        _result = [_msnPhaseLoc, _phase01, _curMission] call FuMS_fnc_HC_MsnCtrl_Util_SetSpecialNameandLocation;
                        _msnPhaseLoc = _result select 0;
                        _missionNameOverride = _result select 1;
                       // waitUntil {FuMS_OkToGetData};
                       // FuMS_OkToGetData = false;
                        _dataFromServer = [_themeIndex, _msnPhaseName] call FuMS_fnc_HC_MsnCtrl_Util_PullData;
                        //FuMS_OkToGetData = true;
                        diag_log format ["##LogicBomb:Phase01  Misssion Data from Server :%1",_dataFromServer];
                        if (!isNil "_dataFromServer") then
                        {
                            if (count _dataFromServer > 0) then
                            {
                                //_waitPhase01 = [_dataFromServer, [_msnPhaseLoc, _missionTheme, _themeIndex, _phase01ID, _curMission]] execVM "HC\Encounters\LogicBomb\MissionInit.sqf";                             
                                _waitPhase01 = [_dataFromServer, [_msnPhaseLoc, _missionTheme, _themeIndex, _phase01ID, _missionNameOverride]] spawn FuMS_fnc_HC_MsnCtrl_MissionInit;
                                // _waitPhase01 = [[_eCenter, _missionTheme, _themeIndex, _phase01ID,_curMission]] execVM _phase01;
                                waitUntil {scriptDone _waitPhase01};
                                diag_log format ["************************************************************"];
                                diag_log format ["##LogicBomb: PHASE TRANSITION COMPLETE: %3: Completed %1:%2",_phase01ID, _phase01,_curMission];
                                diag_log format ["************************************************************"];                        
                                // transfer all objects held by the child to this parent!
                                // HC values should be preserved, no need to update those values here!
                                // mission return format: (this is the data stored in PhaseMsn[_phase01ID])
                                // ["status",_buildings, _vehicles, _groups, _boxes]
                                _childData = FuMS_PhaseMsn select _phase01ID;
                              //  _phase01Status = _childData select 0;
                                _buildings = _buildings + (_childData select 2);
                                _buildingData = _buildingData + (_childData select 1);
                                if (count (_childData select 3) > 0) then {_groups = _groups + (_childData select 3);};
                                if (count (_childData select 4) > 0) then {_vehicles = _vehicles + (_childData select 4);};
                                // _boxes = _boxes + (_childData select 5);                        
                                //  diag_log format ["##LogicBomb: %2: after child-add: _buildingData:%1",_buildingData, _curMission];
                                // clear out the data. It is no longer needed.
                                FuMS_PhaseMsn set [_phase01ID, [] ];
                            }else
                            {
                                diag_log format ["************************************************************"];
                                diag_log format ["##LogicBomb: PHASE TRANSITION FAILED: Data Not found: %3: %1:%2",_phase01ID, _phase01,_curMission];
                                diag_log format ["************************************************************"];                        
                            };
                        };
                    };
                    case 3:
                    {
                        private ["_dataFromServer","_result","_missionNameOverride"];
                        if (isNil "_phase02") exitWith
                        {
                            diag_log format ["************************************************************"];
                            diag_log format ["##LogicBomb: ERROR: %1\%2.sqf! Phase trigger found w/o a phase mission to execute!", (((FuMS_THEMEDATA select _themeIndex) select 0) select 0), _curMission];
                            diag_log format ["************************************************************"];
                        };
                        private ["_waitPhase02","_phase02ID","_childData"];
                        // Now that the phase has been triggered, set this phases MaxTriggers so it will not continue to run.
                        _stateMax set [_i, -1];      
                        FuMS_PhaseMsnID = FuMS_PhaseMsnID + 1;
                        // retain the phaseID so the child's objects can be referenced by this mission after the child exits.
                        _phase02ID = FuMS_PhaseMsnID;
                        diag_log format ["************************************************************"];
                       diag_log format ["##LogicBomb: PHASE TRANSITION: %3: Starting %1:%2 at Index:%4",_phase02ID, _phase02,_curMission, _themeIndex];
                        diag_log format ["************************************************************"];   
                          if (typeName _phase02 == "ARRAY") then
                        {
                            _msnPhaseName = _phase02 select 0;                     
                        }else
                        {
                            _msnPhaseName = _phase02;                          
                        };
                         _msnPhaseLoc = _eCenter;                        
                        _result = [_msnPhaseLoc, _phase02, _curMission] call FuMS_fnc_HC_MsnCtrl_Util_SetSpecialNameandLocation;
                        _msnPhaseLoc = _result select 0;
                        _missionNameOverride = _result select 1;
                        // waitUntil {FuMS_OkToGetData};
                        //FuMS_OkToGetData = false;
                        _dataFromServer = [_themeIndex, _msnPhaseName] call FuMS_fnc_HC_MsnCtrl_Util_PullData;
                        //FuMS_OkToGetData = true;
                        diag_log format ["##LogicBomb:Phase02:  Misssion Data from Server :%1",_dataFromServer];
                        if (!isNil "_dataFromServer") then
                        {
                            if (count _dataFromServer > 0) then
                            {
                                _waitPhase02 = [_dataFromServer, [_msnPhaseLoc, _missionTheme, _themeIndex, _phase02ID, _missionNameOverride]] spawn FuMS_fnc_HC_MsnCtrl_MissionInit;
                                waitUntil {scriptDone _waitPhase02};
                                diag_log format ["************************************************************"];
                                diag_log format ["##LogicBomb: PHASE TRANSITION COMPLETE: %3: Completed %1:%2",_phase02ID, _phase02,_curMission];
                                diag_log format ["************************************************************"];
                                _childData = FuMS_PhaseMsn select _phase02ID;
                               // _phase02Status = _childData select 0;
                                _buildings = _buildings + (_childData select 2);
                                _buildingData = _buildingData + (_childData select 1);
                                if (count (_childData select 3) > 0) then {_groups = _groups + (_childData select 3);};
                                if (count (_childData select 4) > 0) then {_vehicles = _vehicles + (_childData select 4);};
                                FuMS_PhaseMsn set [_phase02ID, [] ];
                            }else
                            {
                                diag_log format ["************************************************************"];
                                diag_log format ["##LogicBomb: PHASE TRANSITION FAILED: Data Not found: %3: %1:%2",_phase02ID, _phase02,_curMission];
                                diag_log format ["************************************************************"];         
                            };
                        };
                    };
                    case 4:
                    {
                        private ["_dataFromServer","_result","_missionNameOverride"];
                        if (isNil "_phase03") exitWith
                        {
                            diag_log format ["************************************************************"];
                            diag_log format ["##LogicBomb: ERROR: %1\%2.sqf! Phase trigger found w/o a phase mission to execute!", (((FuMS_THEMEDATA select _themeIndex) select 0) select 0), _curMission];
                            diag_log format ["************************************************************"];
                        };
                        private ["_waitPhase03","_phase03ID","_childData"];
                        // Now that the phase has been triggered, set this phases MaxTriggers so it will not continue to run.
                        _stateMax set [_i, -1];      
                        FuMS_PhaseMsnID = FuMS_PhaseMsnID + 1;
                        // retain the phaseID so the child's objects can be referenced by this mission after the child exits.
                        _phase03ID = FuMS_PhaseMsnID;
                        diag_log format ["************************************************************"];
                       diag_log format ["##LogicBomb: PHASE TRANSITION: %3: Starting %1:%2",_phase03ID, _phase03,_curMission];
                        diag_log format ["************************************************************"];  
                          if (typeName _phase03 == "ARRAY") then
                        {
                            _msnPhaseName = _phase03 select 0;                         
                        }else
                        {
                            _msnPhaseName = _phase03;                         
                        };
                          _msnPhaseLoc = _eCenter;                        
                        _result = [_msnPhaseLoc, _phase03, _curMission] call FuMS_fnc_HC_MsnCtrl_Util_SetSpecialNameandLocation;
                        _msnPhaseLoc = _result select 0;
                        _missionNameOverride = _result select 1;
                         //waitUntil {FuMS_OkToGetData};
                        //FuMS_OkToGetData = false;
                        _dataFromServer = [_themeIndex, _msnPhaseName] call FuMS_fnc_HC_MsnCtrl_Util_PullData;
                        //FuMS_OkToGetData = true;
                        diag_log format ["##LogicBomb:Phase03:  Misssion Data from Server :%1",_dataFromServer];
                        if (!isNil "_dataFromServer") then
                        {
                            if (count _dataFromServer > 0) then
                            {
                                _waitPhase03 = [_dataFromServer, [_msnPhaseLoc, _missionTheme, _themeIndex, _phase03ID, _missionNameOverride]] spawn FuMS_fnc_HC_MsnCtrl_MissionInit;
                                waitUntil {scriptDone _waitPhase03};
                                diag_log format ["************************************************************"];
                                diag_log format ["##LogicBomb: PHASE TRANSITION COMPLETE: %3: Completed %1:%2",_phase03ID, _phase03,_curMission];
                                diag_log format ["************************************************************"];
                                _childData = FuMS_PhaseMsn select _phase03ID;
                               // _phase03Status = _childData select 0;
                                _buildings = _buildings + (_childData select 2);
                                _buildingData = _buildingData + (_childData select 1);
                                if (count (_childData select 3) > 0) then {_groups = _groups + (_childData select 3);};
                                if (count (_childData select 4) > 0) then {_vehicles = _vehicles + (_childData select 4);};
                                FuMS_PhaseMsn set [_phase03ID, [] ];
                            }else
                            {
                                diag_log format ["************************************************************"];
                                diag_log format ["##LogicBomb: PHASE TRANSITION FAILED: Data Not found: %3: %1:%2",_phase03ID, _phase03,_curMission];
                                diag_log format ["************************************************************"];                                       
                            };
                        };
                    };
                };
            };
            if (_reinforcements > 0) then  // if this mission supports reinforcements
            {      
               // diag_log format ["##LogicBomb: Reinforcements active."];
                if (count FuMS_RC_REINFORCEMENTS == 3) then // have reinforcements been requested from RadioChatter?
                {
                    private ["_helpCenter","_index","_callsign"];
                    _helpCenter = FuMS_RC_REINFORCEMENTS select 0;
                    _index = FuMS_RC_REINFORCEMENTS select 1;
                    _callsign = FuMS_RC_REINFORCEMENTS select 2;
                   // diag_log format ["##LogicBomb: Call Recieved from %1",_callsign];
                   // diag_log format ["##LogicBomb: %1==%2  %3==%4",_helpCenter, _eCenter, _index, _themeIndex];                    
                    if ((_helpCenter select 0 == _eCenter select 0) and 
                         (_index == _themeIndex) and 
                         (_helpCenter select 1== _eCenter select 1)) then   // Help called for on this encounter
                    {
                        private ["_waitPhase01","_phase01ID","_childData","_activeMission", "_chance","_dataFromServer"];
                        FuMS_RC_REINFORCEMENTS = [];                    
                        _chance = floor (random 100);
                        //make the roll
                        if (_chance < _reinforcements) then
                        {
                            private ["_reinfID","_waitreinf","_reinfstatus","_msn"];
                            FuMS_AI_RCV_MsgQue set [_index, [_callsign, "HELP"]];
                            FuMS_PhaseMsnID = FuMS_PhaseMsnID + 1;
                            // retain the phaseID so the child's objects can be referenced by this mission after the child exits.
                            _reinfID = FuMS_PhaseMsnID;
                            if (_reinforceMsn == "Random") then
                            {
                                _msn = ["Help_Ground","Help_Vehicle","Help_Helo"]call BIS_fnc_selectRandom;
                            } else {_msn = _reinforceMsn;};
                            //waitUntil {FuMS_OkToGetData};
                            //FuMS_OkToGetData = false;
                            _dataFromServer = [_themeIndex, _msn] call FuMS_fnc_HC_MsnCtrl_Util_PullData;
                           // FuMS_OkToGetData = true;
                            diag_log format ["##LogicBomb:Reinforcement:  Misssion Data from Server :%1",_dataFromServer];
                            if (!isNil "_dataFromServer") then
                            {
                                   if (count _dataFromServer > 0) then
                            {
                                _waitreinf = [_dataFromServer, [_eCenter, _missionTheme, _themeIndex, _reinfID, _curMission]] spawn FuMS_fnc_HC_MsnCtrl_MissionInit;
                                //  _activeMission = format ["HC\Encounters\%1\%2.sqf", _missionTheme, _msn];
                                // _waitreinf = [[_eCenter, _missionTheme, _themeIndex, _reinfID, _curMission]] execVM _activeMission ;
                                waitUntil {scriptDone _waitreinf};
                                // transfer all objects held by the child to this parent!
                                // mission return format: (this is the data stored in PhaseMsn[_phase01ID])
                                // ["status",_buildings, _vehicles, _groups, _boxes]
                                _childData = FuMS_PhaseMsn select _reinfID;
                                _reinfStatus = _childData select 0;
                                _buildings = _buildings + (_childData select 2);
                                _buildingData = _buildingData + (_childData select 1);
                                _groups = _groups + (_childData select 3);
                                _vehicles = _vehicles + (_childData select 4);
                                // _boxes = _boxes + (_childData select 5);
                                // clear out the data. It is no longer needed.
                                FuMS_PhaseMsn set [_reinfID, [] ]; 
                            }else
                            {
                                diag_log format ["************************************************************"];
                                diag_log format ["##LogicBomb: Reinforcements Failed: Data Not found:%1:",_curMission];
                                diag_log format ["************************************************************"];                                
                            };
                            };
                        };
                    };
                };
            };
        };  
        sleep 3;
    };
    FuMS_ActiveMissions set [_missionKillIndex, "COMPLETE"];
    missionNameSpace setVariable [format["FuMS_AdminActiveMissionList%1",FuMS_ThemeControlID],FuMS_ActiveMissions];
    FuMS_AdminUpdateData = [FuMS_ThemeControlID, "AdminActiveMissionList",FuMS_ActiveMissions];
    publicVariableServer "FuMS_AdminUpdateData";
    // Exiting mission, so make sure triggers are cleaned up!!!
    {
        ["Triggers",_x] call FuMS_fnc_HC_Util_HC_RemoveObject;
    } foreach _instanceTriggers;
}else 
{ 
    _msnStatus = "NO TRIGGERS";
};
diag_log format ["##LogicBomb: %1 %2 completed with status %3",_missionTheme, _curMission, _msnStatus];
[_msnStatus, _buildingData, _buildings, _groups, _vehicles, _boxes]




