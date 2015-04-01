//INF_fnc_NextSound.sqf
// This gets passed to each player's client to drive zombie sounds.
diag_log format ["##INF_fnc_nextSound: PVEH added."];

"FuMS_ZombieNoise" addPublicVariableEventHandler
{
    private ["_zombie", "_type"];
    _data = _this select 1;
    _type = _data select 0;
    _zombie = _data select 1;
  //  diag_log format ["##INF_fnc_nextSound: %1 making %2 sound",_zombie, _type];
    
    // what is the actual mission path?????? 
    
   // _zombie setObjectTexture [0,format["mpmissions\__CUR_MP.%1\HC\Zombies\demon.jpg",worldName]];
   // _zombie setface "infected1_head_co.paa";
    //_zombie setface "zombieface";
    // _zombie setObjectTextureGlobal [0, "infected1_musc_co.paa"];
    
    if (isNil "counterSoundIdle") then {
        counterSoundIdle = 1;
        counterSoundPunch = 1;
        counterSoundHurt = 1;
    };
    
    if (_type == "idle") then {
        [_zombie,player] say3D ("zidle" + str(counterSoundIdle));
        if (counterSoundIdle == 5) then {
            counterSoundIdle = 1;
        } else {
            counterSoundIdle = counterSoundIdle + 1;
        };
    };
    if (_type == "hurt") then {
        [_zombie,player] say3D ("zhurt" + str(counterSoundHurt));
        if (counterSoundHurt == 3) then {
            counterSoundHurt = 1;
        } else {
            counterSoundHurt = counterSoundHurt + 1;
        };
    };
    if (_type == "punch") then {
        [_zombie,player] say3D ("zpunch" + str(counterSoundPunch));
        if (counterSoundPunch == 4) then {
            counterSoundPunch = 1;
        } else {
            counterSoundPunch = counterSoundPunch + 1;
        };
    };
};