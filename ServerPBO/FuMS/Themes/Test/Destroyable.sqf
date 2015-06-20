//Destroyable.sqf
// Horbin
// 6/13/2015

[
 [
     "Destroyable", 200,"NONE", // Mission Title NOSPACES!, and encounter radius
     [100,125,0], // min, max, direction: offset values from the mission center for ALL other offsets to be defined.
     // placing values here will result in objects created by the mission being placed away from the actual encounter center
     // values here can be used to produce missions that are NOT actually located at the encounter center, as may be depicted by
     // a map indicator!!!!
     "StartExample", // Custom Start script.
     "EndExample"  // Custom End script.
 ],
["Destroyable Test","mil_objective","ELLIPSE","ColorRed","FDiagonal",200],    // Map Markers ["MapText", "SHAPE", "COLOR", "FILL", size];
   // type is "mil_objective"
[  
    [// NOTIFICATION Messages and Map display Control.
	false, "ALL",0, // Notify players via Radio Message, radio channel, range from encounter center (0=unlimited.
    false, // Notify players via global message
    true,// Show encounter area on the map
    0,    // Win delay: Time in seconds after a WIN before mission cleanup is performed
    0       // Lose delay: Time in seconds after a lose before mission cleanup is performed
          //NOTE: the above delay must occur before the mission is considered 'complete' by the mission manager control loop.
    ],
    // Spawn Mission Message
["Destroyables",
    "Destroyable objects",
    "Destroy the objects to win the mission!"
],
    
    // Mission Success Message
["Destroyed",
    "",
    "The disabled UGV was destroyed"
],
  
    // Mission Failure Message
["Failure",
    "Buildings Destroyed",
    "The generator and support buildings have been destroyed."
]

],
[  //  Loot Config:  Refer to LootData.sqf for specifcs
["CloneHunter" , [0,2] ], //[static loot, offset location] - spawns with the mission
["Random" , [5,5] ], // Win loot, offset location - spawns after mission success
["None" , [0,0] ]  // Failure loot, offset location - spawns on mission failure
],
[//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.
// ["Land_Device_disassembled_F",[-2,0],0,0],
// ["I_UGV_01_rcws_F",[0,5],0, [.5, 1, .5, .5,.5], "SMOKE_BIG"],

 ["M3Editor", [0,0], 777, 0,

   // paste your array of building objects here
 [
	["Land_Cargo_Tower_V1_No1_F",[7364,7098.37,4.57764e-005],120,[[0.866025,-0.5,0],[0,-0,1]],false],
	["Land_Cargo_Tower_V1_No2_F",[7365.19,7097.3,17.6671],300.366,[[-0.862814,0.505522,0],[0,0,1]],false],
	["Campfire_burning_F",[7323.76,7126.59,0],0,[[0,1,0],[0,0,1]],false],
	["Campfire_burning_F",[7321.68,7123.28,0],0,[[0,1,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[7323.48,7128.39,0],0,[[0,1,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[7320.47,7121.95,0],222.549,[[-0.676221,-0.736699,0],[-0,0,1]],false],
	["Land_CampingTable_F",[7327.75,7127.86,0],24.7277,[[0.418306,0.908306,0],[0,0,1]],false],
	["Land_DieselGroundPowerUnit_01_F",[7380.95,7040.27,4.57764e-005],33.4551,[[0.551283,0.834318,0],[0,0,1]],false],
	["Land_Wreck_Heli_Attack_01_F",[7437.54,6985.9,0],0,[[0,1,0],[0,0,1]],false],
	["Land_Wreck_Heli_Attack_01_F",[7276.35,6983.57,0],0,[[0,1,0],[0,0,1]],false],
	["Land_Wreck_HMMWV_F",[7407.42,7240.23,0],0,[[0,1,0],[0,0,1]],false]
  ]





   ],

	// Vehicle Name  | offset | rotation | Fuel, Ammo, DmgEngine, Dmg FuelTank, DmgHull
	["I_UGV_01_rcws_F",[0,5],   0,       [.5,   1,     0,         0,         0],"SMOKE_BIG"],
   ["I_UGV_01_rcws_F",[0,15],   0,       [.5,   1,     .5,         .5,         .5]],
   ["I_UGV_01_rcws_F",[5,5],   0,       [.5,   1,     .5,         .5,         .5]]

],
[ // AI GROUPS. Only options marked 'Def:' implemented.
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [6,"Sniper"]  ],   ["TowerGuard",[0,0],[0,0],[100,"Land_Cargo_Tower_V1_No2_F"]   ]],
   // [["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Diver"]                                         ],   ["BoxPatrol",[0,0],[0,0],[70] ]]
//[["ZOMBIE","CARELESS","RED","LINE"],   [  [10,"Zombie"]           ],     ["Zombie",[0,0],[0,0],[]     ]],
//[["RESISTANCE","COMBAT","RED","LINE"],[[3,"RaptorM"]],["Buildings",[0,0],[0,0],[70] ]], // 3 rifleman that will patrol all buildings within 70m for unlimited duration
// **End 'copy'******(see Patrol Options below for other AI behaviour)
// Example of a 3D map location. This loc is specific to ALTIS
//[["RESISTANCE","COMBAT","RED","LINE"],[[5,"RaptorF"]],["BoxPatrol",[0,0],[0,0],[70] ]]
//[["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"],[1,"LMG"] ],   ["Explore",[6,6],[0,0],[150]     ]],
  [["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"]           ],   ["Buildings",[0,0],[0,0],[150]     ]]
],
//Example: PatrolBehavior: ["BoxPatrol", [100,0], [0,0],0 ]  
// AI will spawn 100m east of encounter center, a 4 point patrol will be set up at 80% encounter radius. AI will move to this and start patrolling.
// spawnoffsetloc: [x,y] where x and y are offsets in meters from the encounter center.Sets the spawn location for the group.
// patroloffsetloc:[x,y] where x and y are offsets in meters from encounter center. Sets the center of the group's patrol zone,
//                     or where it should travel too before starting its patrol pattern.
// radius: in meters - used in establishing patrol geometry. If zero, then 80% of encounter radius will be used.
//###Patrol Options### 
//Def:   "Perimeter", spawnloc, patrolloc, radius: - 12 waypoints set at radius from loc, group goes from point to point
//Def:   "BoxPatrol", spawnloc, patrolloc, radius: - 4 waypoints set at radius from loc, group goes from point to point
//Def:  "Explore", spawnloc, patrolloc, radius: - 12 waypoints set up at radius from loc, group moves randomly from point to point
//Def:  "Guard", spawnloc, patrolloc, radius: - group patrols inside of buildings found within radius of loc.
//Def:  "Sentry", spawnloc, patrolloc radius: - group moves to nearest building and takes up station in highest points within the building
//     NOTE: if no buildings are located within 'radius' both Guard and Sentry will locate nearest buildings to the encounter and move there!
//  "Loiter", loc, radius: - group just hangs out, in an unaware mode in vicinity of loc-radius.
//  "Convoy", loc, data: group follows roads from startloc to stoploc, then loops back.
//  "XCountry", loc, data: group goes from startloc to stoploc, then loops back.

// Vehicles
[
                 
],
// Triggers and Event control.
//  There are 3 general states for a mission. Win, Lose, or Phase Change.
// In order to establish a WIN or LOSE, all Trigger specified below must be met within their specified grouping.
// Same evaluation is done with checking for Phase changes. 
// Phase Change Detail:
//	When a 'phase change occurs the appropriate additional mission will be launched.
//  Win/Lose logic for this encounter will suspend when phase change is launched. 
//  Triggers from a launched phase change will override triggers defined here.
//  If triggers in this mission are still desired, uncomment the "NO TRIGGERS" comment IN THE MISSION being launched by this mission"
// index 0:win, 1:lose, 2:phase1, 3:phase2, 4:phase3, 5:ignore triggers
[ // NOTE: side RESISTANCE for groups == side GUER for Triggers.
    [    //WIN Triggers and Controls
     // ["LowUnitCount", "EAST", 0, 0, [0,0]], // all enemies are dead:  side options "EAST","WEST","GUER","CIV","LOGIC","ANY"
      //["ProxPlayer", [0,0], 20, 1], // 1 player is within 20 meters of encounter center.
	//  ["Reinforce", 100, "Random"] // %chance when requested, Mission to run
    //  ["BodyCount",1]

	["DMGVehicles","0",1.0] // damage vehicle #1 to 100%
	
    ],
    [    //LOSE Triggers and Controls
//      ["HighUnitCount", "GUER",10,40,[0,0]] // 10 enemies get within 40m's of encounter center
    	["DMGBuildings","1,3-8",.5] // damage building #8 to 50%
    ],   
    [    //Phase01 Triggers and Controls
//      ["Detected",0,0]    //Launch mission if any group or vehicle detects a player
//        ["TIMER", 1500]   // Encounter fails after 1500 seconds (25 minutes)
    ],
    [    //Phase02 Triggers and Controls
    
    ],
    [    //Phase03 Triggers and Controls
    
    ],
    [    // NO TRIGGERS: Uncomment the line below to simply have this mission execute. Mission triggers from a mission that
          // launched this mission will continue to be observed.
    // Uncommenting this line will ignore all triggers defined above, and mission will pass neither a WIN or LOSE result.
    //   ["NO TRIGGERS"]
    ]
],
/*Trigger and Control options
//Triggers 'Def' indicates trigger currently implemented!
Def: ["ProxPlayer",range,offset, numPlayers] : TRUE when '#' players gets within 'range' of the position offset from encounter center
Def:  ["LowUnitCount", side, numAI, radius, offset]: TRUE when AI of 'side' drops below numAI inside 'radius' from 'offset' of encounter center
Def: ["HighUnitCount",side, numAI, radius, offset]: TRUE when AI of 'side' go above numAI inside 'radius' from 'offset' of encounter center
          High and Low count: If radius is zero, radius defaults to encounter radius +100m.
Def: ["Detected", groups, vehicles]; TRUE when player is detected by encounter AI. 'groups' and 'vehicles' are group and vehicle
         numbers that will conduct the detection. A value of zero will permit all groups. A value of -1 will be none.
          ["Detected",0,2]  This would trigger if any 'AI group' or vehicle group #2 detect a player.
		  ["Detected",-1, 1] This would trigger only if vehicle group #1 detects a player

// EH Controls
5 ["KillGroup",grp#]: triggers when specified group's AI are all killed.  grp# taken from the above array of groups, starting with '1'
6 ["KillVehicle",veh#]: triggers when specified vehicle is destroyed. veh# taken from the above array of vehicles
7 ["AccessObj",obj#]: triggers when specified veh# or staticLoot (id = 0) is accessed.

// Timer Controls
8 ["TIMER_Trig", time, one of the above controls]: enables one of the above Trigger or EH's 'time' seconds after encounter start.
9 ["TIMER", time]: triggers  'time' seconds after encounter start. (ie placed in LOSE block ["TIMER",600], encounter would end in failure after 10 minutes if WIN triggers are not met. 
10["Trig_TIMER", time, one of the above controls]: starts a timer after the associated Trigger/EH is activated. Upon completion status is set.
*/


// Phased Missions.
// Chaininig of missions is unlimited.
// Above triggers will 'suspend' when below phase starts. Phase launched will use its own triggers as specified in its mission script.
// If it is desired to continue to use the above Triggers instead of the 'launched mission's' triggers do the following:
//   uncomment the "NO TRIGGERS' line from the mission being launched.
// The below specified missions will be precompiled into the specified 'calls' when this script runs.
// The file needs to be located in the same folder as this mission launching them.
[
//    "TestPhase1",  //Phase01
//    "TestPhase2", //Phase02
//    "TestPhase3" //Phase03
]

];
