//Znoise.sqf
private ["_zombie","_sound","_players"];
_zombie = _this select 0;
_sound = _this select 1;
_players = [];
// zombies can be heard at a distance of 100m.  So find all players and put them in a list.
{
        if (isPlayer _x and (_x distance _zombie < 100)) then 
        {
            _players = _players +[_x];
        };   
}foreach playableUnits;

//diag_log format ["##Znoise : %3 is pushing %1 sound to %2",_sound, _players, _zombie];
if (isServer) then
{
    [[_sound, _zombie, _players]] spawn FuMS_ZombieNoise_Server;
}
else
{
    FuMS_ZombieNoise = [_sound, _zombie, _players];
    publicVariableServer "FuMS_ZombieNoise";
};