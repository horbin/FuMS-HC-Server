private ["_me","_initialPos","_target","_frozen"];

_me=_this select 0;
_initialPos=_this select 1;
_me joinAsSilent [FuMS_RoamingZombieGroup, 1];
_target=[];
_frozen = false;

//diag_log format ["##Roam: firedNear' EH should have been added."];

_me addEventHandler ["firedNear",
{
  //  diag_log format ["##Roam: %1 has heard a sound from %2",_this select 0, _this select 1];
    if ((str (_this select 4)) in ["muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG"]) exitwith {};
    [_this select 0, _this select 1] spawn FuMS_fnc_HC_Zombies_Logic_Investigating;
}];


while{(alive _me)&& (count _target == 0)}do
{	
    if(unitReady _me)then
    {
//        diag_log format ["##Roam: %1 starting to do Roaming",_me];
        [_me,_initialPos] spawn FuMS_fnc_HC_Zombies_Logic_Roaming;
    };
    sleep 1;
//    diag_log format ["##Roam: %1 Looking for players",_me];
    _target= _me call FuMS_fnc_HC_Zombies_Logic_ZNearestTarget;
    sleep 2;
};
if(!alive _me)then
{
    _me removeAllEventHandlers "hit";
    sleep 120;
    deleteVehicle _me;
}else{
    _me removeAllEventHandlers "firedNear";
//    diag_log format ["##Roam: %1 starting to attack %2",_me, _target];
    [_me,_target,_initialPos] spawn FuMS_fnc_HC_Zombies_Logic_Attack;
};




    
    
    