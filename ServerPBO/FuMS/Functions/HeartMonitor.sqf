// HeartMonitor.sqf
// Horbin
// 2/28/15

// Needs to occur LAST after all other server initialization!
//Launch HC cleanup process.
// This script watches for an HC disconnect
// When identified, server will cleanup objects that where controlled by the HC
// Use included HC_CreateGroup, HC_CreateVehicle, etc functions on the HC to ensure cleanup!
FuMS_HC_DataCleanup	= compile preprocessFileLineNumbers "\FuMS\Functions\HC_DataCleanup.sqf"; 
FuMS_InitHeadlessClient = compile preprocessFileLineNumbers "\FuMS\Functions\InitHeadlessClient.sqf";

private ["_hcID","_owner"];
_owner = _this select 0;
_hcID = owner _owner;

[_owner, _hcID] spawn
{
    private ["_prefix","_hcID","_pulse","_status","_owner","_dead","_ownerName"];
    _prefix = "FuMS_HC_isAlive";
    _owner = _this select 0;
    _hcID = _this select 1;
    //_hcIDtest = owner _owner;
    _ownerName = format ["%1",_owner]; // convert it to text, so when it goes dead, we still know its name!    
    // HC object will be transfered to server. It will continue to excist UNTIL it totally disconnects!
    _pulse = format ["%1%2",_prefix, _hcID];
    _dead = false;
    if (isNull _owner) then
    {
        diag_log format ["<FuMS> HeartMonitor: _owner is Null! Attempting to locate lost HC object!"];
    };
    if (_hcID == 0) exitWith
    {
        FuMS_ServerIsClean = true;
        diag_log format ["<FuMS> HeartMonitor: Server ID 0 detected as source heartbeat, not valid. exiting heartbeat monitor for id:0"];
    };
    missionNamespace setVariable [_pulse, false];  // set false to start.
    
    // now wait for the 1st heartbeat. This one is sent AFTER the HC finishes all of its initializations!
    waituntil
    {
        uiSleep 2;
        diag_log format ["<FuMS> HeartMonitor: Waiting for HC:%1 initialization to finalize with signature %2",_ownerName, _pulse];
        _status = missionNamespace getVariable _pulse;
        _status
    };
    
    FuMS_ServerIsClean = true;   
    // HC should be complete with loading and init, so free server up to receive other HC connections.
    while {!_dead} do
    {                    
      //  waitUntil {!isNil "HC_isAlive00"};
        missionNamespace setVariable [_pulse, false];
        uiSleep 4;
        //Wait for 2secs, if value still FALSE, listen for a 2nd heartbeat.  
        _status = missionNamespace getVariable _pulse;
        if (!_status) then // listening for 2nd heart beat
        {
            diag_log format ["<FuMS> HeartMonitor: %1: 1st Heart beat missed!!%2",_ownerName,_pulse];    
            uiSleep 4;           
            //Wait 2secs, if value still FALSE, listen for a 3rd heart beat.
            _status = missionNamespace getVariable _pulse;
            if (!_status) then //listening for the 3rd heart beat.
            {
                diag_log format ["<FuMS> HeartMonitor:%1: 2nd Heart beat missed!!%2",_ownerName,_pulse];       
                uiSleep 4;       
                _status = missionNamespace getVariable _pulse;   
                if (!_status) then // HC_HAL is very likely disconnected.                            
                {
                    private ["_start","_waitonHC","_status"];
                    _start = time;
                    diag_log format ["<FuMS> HeartMonitor:%3:%1: Disconnect detected. Preparing to clean up the Mess!!!!%2",_ownerName,_pulse,_hcID];                                        
                    // wait here for one of two conditions
                   _waitonHC = true;
                    while {_waitonHC} do
                    {
                        // 1) _status becomes true = HC has recovered, just lagged out, so resume behavior.
                        _status = missionNamespace getVariable _pulse;
                        if (_status) then
                        {
                            _waitonHC = false;
                            diag_log format ["<FuMS> HeartMonitor:%3:%1: Disconnect recovered!!!!%2",_ownerName,_pulse,_hcID];                                        
                        }; // HC recovered, so resume monitoring it!
                        if (isNull _owner) then
                        {
                            // 2) _owner becomes NULL-object = HC is disconnected
                            // ASSERT: ALL objects now owned by server, and not 'in limbo'
                            FuMS_ServerIsClean = false;
                            publicVariable "FuMS_ServerIsClean";
                            [_hcID] call FuMS_HC_DataCleanup;                   
                            diag_log format ["<FuMS> HeartMonitor: HC:%1: Complete in %3 secs!%2",_ownerName,_pulse, time-_start];  
                            missionNamespace setVariable [_pulse, nil];                    
                            _dead = true;
                            _waitonHC = false;                            
                        };
                        uisleep 4;
                    };
                };
                // End of cleanup
            };
            // End of 3rd heartbeat
        };
        // End of 2nd heartbeat
    };
    //End of 1st heartbeat
    diag_log format ["<FuMS> HeartMonitor: Has ended for %3:%1:%2",_ownerName,_pulse,_hcID];
    FuMS_ServerIsClean = true;
};

/*
[_owner] spawn
{
    private["_owner","_hcID"];
    _owner = _this select 0;
    while {true} do
    {
        _hcID = owner _owner;
        diag_log format ["<FuMS> HeartMonitor: HC object watch %1:%2",_owner,_hcID];
        sleep 3;
    };
};
*/
//setup EH to detect transfer of ownership of actual HC object too server. This will ALSO imply a disconnect!
// code does not appear to execute consistently........
//  it appears that shortly after HC connection the '_owner' object becomes NULL. Maybe it is EPOCH doing something with the HC object
//  mechanism of using _hcID with the heart beat appears to be working ok now that the _hcID is passed to the 'heart monitor' spawn loop.
/*
_owner addEventHandler ["Local",
{
    private ["_owner","_isLocal"];
    _owner = _this select 0;
    _isLocal = _this select 1;
    diag_log format ["<FuMS> HeartMonitor: HC Locality change: _owner:%1 _isLocal:%2",_owner,_isLocal];
    _allAI = [];
    {
        if (! (isplayer _x)) then {_allAI = _allAI + [_x]};
    }foreach allUnits;
    diag_log format ["<FuMS> HeartMonitor: HC Locality change: %1 AI found.",count _allAI];
    {
        diag_log format ["<FuMS> HeartMonitor: HC Locality change: deleting AI %1",_x];
        deleteVehicle _x;
    }foreach _allAI;
}];
*/
diag_log format ["<FuMS> HeartMonitor: Server-HC Heart Monitor Slot #%1 initialized for %2", _hcID, _owner];

[_owner ] call FuMS_InitHeadlessClient;
//waitUntil {ScriptDone _handle};
FuMS_ServerIsClean = false;
FuMS_ServerInitData = true;
_hcID publicVariableClient "FuMS_ServerInitData";    // once received by HC, it will start FuMS control loops.

diag_log format ["<FuMS> HeartMonitor: HC started! Starting HeartBeat monitor for slot#%1 : %2", _hcID, _owner];










/*
[_owner] spawn
{
    private ["_prefix","_hcID","_pulse","_owner","_start", "_ownerName"];
    _prefix = "FuMS_HC_isAlive";
    _owner = _this select 0;
    _hcID = owner _owner;
   _ownerName = format ["%1",_owner]; // convert it to text, so when it goes dead, we still know its name!    
    _pulse = format ["%1%2",_prefix, _hcID];
 //   _isInited = format ["%1%2_init"];  
    _genderExpireTime = time+180;    
    waitUntil
    {
        diag_log format ["##HeartMonitor: Waiting on Gender for %1",_owner];
        sleep 3;
        typeOf _owner == "Epoch_Male_F" or typeOf _owner == "Epoch_Female_F" or (time > _genderExpireTime)
    };
    if (time > _genderExpiretime) then {diag_log format ["##HeartMonitor: Gender assignment timeout! No GenderAssigned for %1",_ownerName];};
    while{alive _owner}do
    {
      //  diag_log format ["##HeartMonitor: isalive: %2 typeOf: %1",typeof _owner, alive _owner];
        sleep 3;
    };
    _start = time;
    diag_log format ["##HeartMonitor:%1: Disconnect detected. Cleaning up the Mess!!!!%2",_ownerName,_pulse];  
    // Cleanup AI Groups
    FuMS_ServerIsClean = false;
    [_hcID] call FuMS_HC_DataCleanup;                   
    diag_log format ["HC:%1: Complete in %3 secs!%2",_ownerName,_pulse, time-_start];  
    missionNamespace setVariable [_pulse, nil];
    FuMS_ServerIsClean = true;       
    diag_log format ["##HeartMonitor: Has ended for %1:%2",_ownerName,_pulse];
};
*/

