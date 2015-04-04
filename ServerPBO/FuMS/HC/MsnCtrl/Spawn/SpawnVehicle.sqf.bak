//SpawnVehicle.sqf
// Horbin
// 1/4/15
// INPUTS groupsdata array from Mission routine, Encounter center, mission size, array of groups from MissionInit.
// OUTPUTS list of groups and vehicles crated [_groups array, vehicle array]
private ["_convoy","_vehdat","_driverdat","_troopdat","_driverGroup","_crewcount","_troopGroups","_masterIndex",
"_numberTroops","_totalvehicles","_abort","_msg"];
private ["_vehicleData","_eCenter","_encounterSize","_groups","_returnval","_themeIndex","_missionName","_totalvehicles"];
_vehicleData = _this select 0;
_eCenter = _this select 1;
_encounterSize = _this select 2;
_groups = _this select 3;
_totalvehicles = _this select 4;
_themeIndex = _this select 5;
_missionName = _this select 6;
_returnval =[_groups, _totalvehicles];
_abort = false;
_msg = "";
if (isNil "_vehicleData") then {_abort=true;_msg="Convoy section was totaly blank. Format error. It must at least contain an empty array []";};
if (count _this != 7) then {_abort=true;_msg = format ["SpawnVehicle: Input variable error! Was expecting 7, received %1.",count _this];};
if (!_abort) then
{
    { 
        // Being of Convoy Creation!
        private ["_numVeh","_ebk","_vehType","_vehLoc","_vehLoot","_numDriverGroups","_driverBehaviour","_driverTypes","_driverOptions","_vehCrew",
        "_numTroopGroups","_troopBehaviour","_troopTypes","_troopOptions","_vehicles"];
        if (count _x != 3) exitWith {_abort=true;_msg="incorrect data format in one of the Convoy data blocks."};
        _convoy = _x;
        _vehdat = _convoy select 0; // vehicle definitions block
        _driverdat = _convoy select 1;  // driver def block
        _troopdat = _convoy select 2; // troop def block
        _vehicles = [];
        _vehType = [];
        _vehLoc = [];
        _vehLoot = [];
        _vehCrew = [];
        _driverBehaviour = [];
        _driverTypes = [];
        _driverOptions = [];
        _troopBehaviour = [];
        _troopTypes = [];
        _troopOptions = [];
        // Parse the Vehicle Data Block!
        if (isNil "_vehdat") exitWith {_abort=true; _msg = "Vehicle definition missing from 'Convoy' description, see TestMission01 for a good example.";};
        // driverdat and troopdat are acceptable if Nil.
        _numVeh = 0;
        _ebk= "Vehicle Data: Vehicle ";
        {
            if (count _x !=4) exitWith {_abort=true;_msg=format ["%2format error expecting 4 elements found %1",_x,_ebk];};
            _vehType set [ _numVeh, _x select 0];
            _vehLoc set [_numVeh, _x select 1];
            _vehCrew set [_numVeh, _x select 2];
            _vehLoot set [_numVeh, _x select 3];		
            if (isNil "_vehType" or isNil "_vehLoc" or isNil "_vehCrew" or isNil "_vehLoot") exitWith {_abort=true; _msg =format[ "%2data should be [ ""B_Truck_01_transport_EPOCH"",[-50,-610],[1,""Rifleman""],""None""] found %1",_x,_ebk];};
            if (TypeName (_vehType select _numVeh) != "STRING") exitWith {_abort = true; _msg =format[ "%2type should be a string not %1",(_vehType select _numVeh),_ebk];};
            if (TypeName (_vehLoc select _numVeh) != "ARRAY") exitWith	{_abort = true; _msg =format[ "%2spawn location should be an array not %1",(_vehLoc select _numVeh),_ebk];};
            if (TypeName (_vehCrew select _numVeh) != "ARRAY") exitWith	{_abort = true; _msg =format[ "%2crew should be an array [#,type] or [] not %1",(_vehCrew select _numVeh),_ebk];};
            if (TypeName (_vehCrew select _numVeh) == "ARRAY") then
            {
                
                if (count (_vehCrew select _numVeh) !=2 and count (_vehCrew select _numVeh) != 0 ) exitwith {_abort = true; _msg =format[ "%2crew should be an array [#,type] or [] not %1",(_vehCrew select _numVeh),_ebk];};
                if (count (_vehCrew select _numVeh) ==2) then
                {
                    if (TypeName ((_vehCrew select _numVeh) select 0) != "SCALAR" or TypeName ((_vehCrew select _numVeh) select 1) != "STRING") exitWith
                    {_abort = true; _msg =format[ "%2crew should be an array [#,type] or [] not %1",(_vehCrew select _numVeh),_ebk];};
                };
            };
            if (TypeName (_vehLoot select _numVeh) != "STRING") exitWith	{_abort = true; _msg =format[ "%2loot should be a text string or ""None"" not %1",(_vehLoot select _numVeh),_ebk];};
            // verify the vehicle is a valid class name -ToDo-		
            _numVeh = _numVeh + 1;				
        }foreach _vehdat;
        if (_abort) exitWith{};
        _numDriverGroups = 0;
        _ebk="Driver Data: Driver ";
        {
            if (count _x !=3) exitWith {_abort=true;_msg=format["%2format error expecting 3 elements found %1",_x,_ebk];};
            _driverBehaviour set [_numDriverGroups, _x select 0];
            _driverTypes set [_numDriverGroups, _x select 1]; // array of [[x,name],[x,name]]
            _driverOptions set [_numDriverGroups, _x select 2];
            if (isNil "_driverBehaviour" or isNil "_driverTypes" or isNil "_driverOptions") exitWith {_abort=true; _msg=format["%2data should be [[""RESISTANCE"",""COMBAT"",""RED"",""COLUMN""],[[3, ""Driver""]],[""Convoy"",[-75,-600],[0,-50],[""NORMAL"",true,true,true]]] found %1",_x,_ebk];};
            if (TypeName (_driverBehaviour select _numDriverGroups) != "ARRAY") exitWith {_abort=true;_msg=format["%2should be array of text strings, not %1",_x,_ebk];};
            if (TypeName (_drivertypes select _numDriverGroups) != "ARRAY") exitWith { _abort=true;_msg=format["%2types should be a array [[#,type],[#,type]], not %1",_x,_ebk];};
            if (TypeName (_driverOptions select _numDriverGroups) != "ARRAY") exitWith { _abort=true;_msg=format["%2options should be a array, not %1",_x,_ebk];};	
            _numDriverGroups = _numDriverGroups + 1;
        }foreach _driverdat;
        if (_abort) exitWith{};
        _numTroopGroups = 0;
        _ebk="Troop Data: Troops ";
        {
            //diag_log format ["##SpawnVehicle: _troopdat:%1",_x];
            if (count _x !=3) exitWith {_abort=true;_msg=format["%2format error expecting 3 elements found %1",_x,_ebk];};
            _troopBehaviour set [_numTroopGroups, _x select 0];
            _troopTypes set [_numTroopGroups, _x select 1];
            _troopOptions set [_numTroopGroups, _x select 2];
            if (isNil "_driverBehaviour" or isNil "_driverTypes" or isNil "_driverOptions") exitWith {_abort=true; _msg=format["%2data should be [[""RESISTANCE"",""COMBAT"",""RED"",""COLUMN""],[[3, ""Driver""]],[""Convoy"",[-75,-600],[0,-50],[""NORMAL"",true,true,true]]] found %1",_x,_ebk];};
            if (TypeName (_troopBehaviour select _numTroopGroups) != "ARRAY") exitWith {_abort=true;_msg=format["%2should be array of text strings, not %1",_x,_ebk];};
            if (TypeName (_trooptypes select _numTroopGroups) != "ARRAY") exitWith { _abort=true;_msg=format["%2types should be a array [[#,type],[#,type]], not %1",_x,_ebk];};
            if (TypeName (_troopOptions select _numTroopGroups) != "ARRAY") exitWith { _abort=true;_msg=format["%2options should be a array, not %1",_x,_ebk];};	
            _numTroopGroups = _numTroopGroups + 1;
        }foreach _troopdat;
        if (_abort) exitWith{};
        
        //Data format checks out! Time to make some vehicles.	
        private ["_vehicles","_drivers","_troops","_driverIndividual","_numdrivers","_i","_silentCheckIn"];
        _vehicles = [];			
        _drivers = [];
        _troops = [];
        _driverIndividual = []; //list of each individual driver's patrol logic.
        _numdrivers = 0;
        // find 'state' for each vehicle based upon driver's AI logic.
        for [{_i=0},{_i < _numDriverGroups},{_i=_i+1}] do
        {            
            private ["_curList","_ii","_logic"];          
            {
                // _x should be [#,name]
                if (TypeName _x != "ARRAY") exitWith {_abort=true;_msg=format["Driver Data: driver type format should be similar too [[2,""Driver""]] not %1",_driverTypes select _i];};                
                for [{_ii=_numdrivers},{_ii<(_x select 0)+_numdrivers},{_ii=_ii+1}] do
                {
                    _logic = (_driverOptions select _i);
                    _driverIndividual set [_ii, _logic];
                };
                _numdrivers = _numdrivers +( _x select 0);
            }foreach (_driverTypes select _i);
            if (_abort) exitWith {};
           // diag_log format ["##SpawnVehicle: List of drivers :%1",_driverIndividual];
        };
        if (_abort) exitWith{};
        
        for [{_i=0},{_i < _numVeh},{_i=_i+1}] do
        {
            private ["_mode","_pos","_data","_driver","_veh","_loot"];
            // create the vehicle
            //_overwater = surfaceIsWater _pos;
            _mode = "";
            _pos = [_eCenter, _vehLoc select _i] call FuMS_fnc_HC_MsnCtrl_Util_XPos;
            _driver = "none";
            if (_i < _numdrivers) then {_driver = _driverIndividual select _i;};
            _data = [_pos, _driver, _vehType select _i] call FuMS_fnc_HC_MsnCtrl_Util_GetSafeSpawnVehPos;	
            //diag_log format ["pos:%1, driver:%2, type:%3 data:%4",_pos, _driver, _vehType select _i,_data];
            _veh = [ _vehType select _i, _data select 0, [], 30 , _data select 1] call FuMS_fnc_HC_Util_HC_CreateVehicle;		
            // install its loot if any!
            _loot = toupper (_vehLoot select _i);
            if ( _loot != "NONE") then
            {
                [_loot, _veh, _themeIndex] call FuMS_fnc_HC_Loot_FillLoot;
            };
            _vehicles = _vehicles + [_veh];
        };
        // create and load up the drivers!        
        _silentCheckIn = (((FuMS_THEMEDATA select _themeIndex) select 3) select 0) select 1;
        //diag_log format ["##SpawnVehicle: _silentCheckIn: %1", _silentCheckIn];
        _driverGroup = [_driverdat, _eCenter, _encounterSize, _themeIndex,_silentCheckIn, _missionName] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnGroup;    
        //_driverGroup is a LIST of groups, even if it only contained 1 group. 
        _drivers=[];
        {
            _drivers = _drivers + units _x;
            _groups = _groups + [_x];
        }foreach _driverGroup;	
        for [{_i=0},{_i < count _drivers},{_i=_i+1}] do
        { 
            private ["_var"];
            (_drivers select _i) moveinDriver (_vehicles select _i);
            // need to update driver's spawn loc with the spawn loc of this vehicle!
            _var = (_drivers select _i) getVariable "FuMS_AILOGIC";
            _var set [2,getPos (_vehicles select _i)];
            (_drivers select _i) setVariable ["FuMS_AILOGIC",_var,false];
            if (! ( (_vehicles select _i) isKindOf "Air") ) then
			{
				//[_drivers select _i] execVM "HC\Encounters\AI_Logic\VehStuck.sqf";
				[_drivers select _i] spawn FuMS_fnc_HC_AI_Logic_VehStuck;
			};
        };              
        // create and load up the CREW!	
        for [{_i=0},{_i < count _vehCrew},{_i=_i+1}] do
        {
            private ["_crewData"]; 
            _crewData = _vehCrew select _i;  // this is an array of [#,name] pairs!!!!!
            if (!isNil "_crewData") then // vehicle has crew!
            {
                private["_turretsArray","_leader","_crewVeh","_ii"];
                if (count _crewData != 0) then
                {
                    _turretsArray =[_vehicles select _i] call FuMS_fnc_HC_Util_KKcommonTurrets;
                    //diag_log format ["##SPAWN Vehicles : %1 has %2 turrets", _x select 0, count _turretsArray]; 
                    _crewcount = _crewData select 0;
                    _leader = driver (_vehicles select _i);
                    _crewVeh = _vehicles select _i;
                    for [{_ii =0}, {_ii < _crewcount}, {_ii = _ii+1}] do
                    {
                        if ( count _turretsArray > 0 ) then  // a turret is avail!
                        {    
                            private ["_type","_crew"];
                            _type = _crewData select 1;					
                            _crew = [group _leader,_type, getPos _crewVeh, _themeIndex] call FuMS_fnc_HC_AI_SpawnSoldier;                   
                            _crew setVariable ["FuMS_AILOGIC", _leader getVariable "FuMS_AILOGIC", false];
                            _crew setVariable [ "FuMS_XFILL", _leader getVariable "FuMS_XFILL", false];   
                            _crew setVariable ["FuMS_MSNTAG", _leader getVariable "FuMS_MSNTAG", false];
                            [_crew] spawn FuMS_fnc_HC_AI_Logic_AIEvac;
                            //radio chatter only required for group leaders, so only requires init inside SpawnGroup                                                                
                            //_crew assignAsGunner _veh;
                            //_crew moveInTurret [_veh, (_turretsArray select 0)];
                            _crew moveInAny (_crewVeh);
                            _turretsArray = _turretsArray - [_turretsArray select 0];
                        }else
                        {
                            //no turrents left for the crew!
                            diag_log format ["##SpawnVehicle: NON-FATAL ERROR: Index:%1/%2 excess crew defined for %3. Vehicle is Full!",_themeIndex,_missionName,_crewVeh];			
                        };                   
                    };
                };
            };
        }foreach _vehCrew;
        
        // Add Troops
        //   diag_log format ["##Spawn Vehicle : _troopdat:%1",_troopdat];  
        //Obtain the list of troops to be added to the list of vehicles
        _troops = [];
        _troopGroups =  [_troopdat, _eCenter, _encounterSize, _themeIndex, true, _missionName] call FuMS_fnc_HC_MsnCtrl_Spawn_SpawnGroup;  // all troops are silent checkin
        {
            _groups = _groups + [_x]; // add the troop groups to the list to be returned by this script.
            {
                _troops = _troops + [_x]; // add each unit within the group for cargo placement!
            }foreach units _x;       
        }foreach _troopGroups;    
        private ["_done","_activeVehicle","_totalCargo"];
        _done = false;
        _totalCargo = 0;
        _masterIndex = 0;
        _numberTroops = count _troops;
        //    diag_log format ["Spawn Vehicle: _numberTroops:%1  for _troops:%2",_numberTroops, _troops]; 
        //    diag_log format ["Spawn Vehicle: adding troops to %1 vehicles",count _vehicles];
        {
            private ["_i","_numCargo","_numCommander","_numDriver","_numGunner","_turretsArray"];
            _numCargo = _x emptyPositions "Cargo";
            _totalCargo = _totalCargo + _numCargo;
            // _numCommander = _x emptyPositions "Commander";
            // _numDriver = _x emptyPositions "Driver";
            // _numGunner = _x emptyPositions "Gunner";
            //   diag_log format ["Spawn Vehicle: Cargo:%1 CMD:%2 Driver:%3 Gunner:%4:%5",_numCargo, _numCommander, _numDriver, _numGunner, _x];      
            // Fill vehicle's cargo
            for [{_i = 0}, {_i < _numCargo},{ _i=_i+1}] do
            {
                if (_masterIndex == _numberTroops) then {_i=_numCargo;}
                else
                {
                    //diag_log format ["Spawn Vehicle: Adding %1 to %2",_troops select _masterIndex, _x];
                    //(_troops select _masterIndex) assignAsCargo _x;
                    (_troops select _masterIndex) moveInCargo _x;                    
                    _masterIndex = _masterIndex + 1;
                };
            };        
            _totalvehicles = _totalvehicles + [_x];
        } foreach _vehicles;
        if (_numberTroops > _totalCargo) then {diag_log format ["##SpawnVehicle: NON-FATAL ERROR: Index:%1/%2 excess cargo defined %3 men left w/o transport. Vehicle is Full!",_themeIndex,_missionName,_totalCargo-_numberTroops];};				
    }foreach _vehicleData;
};
if (_abort) then
{
    diag_log format ["-------------------------------------------------------------------------------------"];
    diag_log format ["----------------            Fulcrum Mission System                    -----------------"];
    diag_log format ["-------------------------------------------------------------------------------------"];
    diag_log format ["##FuMsnInit: ERROR in Fulcrum Mission Data!"];
    diag_log format ["    Recommend verifying data in \FuMS\Themes\%1\%2.sqf on your server!",((FuMS_THEMEDATA select _themeIndex) select 0) select 0   ,_missionName];        
    diag_log format ["             -ABORT- -ABORT- -FORMAT ERROR- -ABORT- -ABORT-"];   
    diag_log format ["                           Vehicle Creation for this mission offline....."];
    diag_log format ["REASON: %1",_msg];
    diag_log format ["  Check your HC's .rpt file for other possible details!"];
    diag_log format ["-------------------------------------------------------------------------------------"];
    diag_log format ["-------------------------------------------------------------------------------------"];        
};
_returnval = [_groups, _totalvehicles];
_returnval
