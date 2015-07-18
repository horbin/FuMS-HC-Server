//PayPlayer.sqf
// Horbin
// 7/17/2015

//Inputs [amount, typepayment], player to be paid
private ["_data","_player"];
_data = _this select 0;
_player = _this select 1;
// _data is an array of ["FactionName",amount] pairs
//diag_log format ["<FuMS> PayPlayer: _data : %1",_data];
FuMS_PayPlayer = [_data, _player];
publicVariableServer "FuMS_PayPlayer";

// HC can track factions for new faction triggers here!

