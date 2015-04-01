//init.sqf
// Horbin
// 3/14/15
//Zombies created in a group that is "CARELESS","LIMITED","EAST"
// Type is "A3L_Zombie" or "A3L_SECRET"
// zombie groups: 
//     -infected - wondering around
//		-infectedattacker - group that is engaged with a player
// FuMS_RoamingZombieGroup
// FuMS_AttackingZombieGroup
//_militaryCloth=["A3L_Zombie","A3L_SECRET"]; // Uniforms

//FuMS_fnc_HC_Zombie_Logic_Roam;
//FuMS_fnc_HC_Zombie_Logic_Investigating;
//FuMS_fnc_HC_Zombie_Logic_Roaming;
//FuMS_fnc_HC_Zombie_Logic_ZNearestTarget;
//FuMS_fnc_HC_Zombie_Logic_Contact;
//FuMS_fnc_HC_Zombie_Logic_Attack;
//FuMS_fnc_HC_Zombie_Logic_Roam;

FuMS_RoamingZombieGroup = createGroup east;
FuMS_RoamingZombieGroup setCombatMode "CARELESS";
FuMS_RoamingZombieGroup setSpeedMode "LIMITED";
diag_log format ["##Zombies/init.sqf Zombie Groups initialized.....!"];
FuMS_AttackingZombieGroup = createGroup east;
FuMS_AttackingZombieGroup setCombatMode "CARELESS";
FuMS_AttackingZombieGroup setSpeedMode "FULL";
