//WaterMission.sqf
// Horbin
// 2/26/15
// Based upon drsubo Mission Scripts

[
["WaterMission", 100], // Mission Title NOSPACES!, and encounter radius
["Ship Wreck","c_ship","ELLIPSE","ColorBlue","FDiagonal",200],    // Map Markers ["MapText", "SHAPE", "COLOR", "FILL", size];
   // type is "mil_objective"
[  
    [// NOTIFICATION Messages and Map display Control.
	true, "ALL",0, // Notify players via Radio Message, radio channel, range from encounter center (0=unlimited.
    true, // Notify players via global message
    true,// Show encounter area on the map
    0,    // Win delay: Time in seconds after a WIN before mission cleanup is performed
    0       // Lose delay: Time in seconds after a lose before mission cleanup is performed
          //NOTE: the above delay must occur before the mission is considered 'complete' by the mission manager control loop.
    ],
    // Spawn Mission Message
["Ship Wreck",
    "a vessel has sunk!",
    "Humans have crashed a boat near the shore!"
],
    
    // Mission Success Message
["Mission Success",
    "",
    "The wreck has been salvaged."
],
  
    // Mission Failure Message
["Mission Failure!",
    "",
    "The wreck has vanished into the depths."
] 
],
[  //  Loot Config:  Refer to LootData.sqf for specifcs
["None" , [18,-9] ], //[static loot, offset location] - spawns with the mission
["RANDOM" , [0,0] ], // Win loot, offset location - spawns after mission success
["None" , [0,0] ]  // Failure loot, offset location - spawns on mission failure
],
[//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.
    ["Land_UWreck_FishingBoat_F",[0,0],0,0]   //type, offset, rotation, presist flag
],
[ // AI GROUPS. Only options marked 'Def:' implemented.
//   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[2,"Rifleman"],[2,"Hunter"]  ],   ["BoxPatrol",[0,75],[0,0],[0]   ]],
//    [["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"]                                         ],   ["Guard",[-20,10],[0,0],[70] ]],
[["EAST","COMBAT","RED","LINE"],   [  [3,"Diver"]           ],     ["BoxPatrol",[0,0],[0,0],[25]     ]],
[["EAST","COMBAT","RED","LINE"],   [  [3,"Diver"]           ],     ["BoxPatrol",[0,0],[0,0],[15]     ]],
[["EAST","COMBAT","RED","LINE"],   [  [3,"Diver"]           ],     ["BoxPatrol",[0,0],[0,0],[5]     ]]
//[["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"],[1,"LMG"] ],   ["Explore",[6,6],[0,0],[150]     ]],
//[["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"]           ],   ["BoxPatrol",[-6,-6],[0,0],[0]     ]]
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
 [  // Convoy #1    
    // Spawns 3 vehicles 600m south of encounter center. These 3 will move as a convoy and contain 3 groups of mixed troops.
    // These troops will be dropped off just south of encounter center, then the convoy will return to their spawn location and despawn.
 [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
   //[  "B_SDV_01_F",                    [0,10],[5,"Diver"],        "Truck01"      ], 
     [  "B_Boat_Armed_01_minigun_F"           ,[10,0],[5,"Rifleman"],     "Truck01"      ], 
     [  "B_Boat_Transport_01_F"           ,[0,0], [3,"Rifleman"],     "Truck01"      ]
   //[  "C_Offroad_01_EPOCH"           ,[13300,14600,0],[ 0, ""          ],       "Truck01"]   
                 // If driver-less vehicles are desired, place them at the bottom of the list. 
				 // Troops WILL be placed into 'driver-less' vehicles if the other vehicles are full!!!
    ],[  
    // Drivers                                                         # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [2, "Driver"]  ],   ["BoxPatrol",[0,0],[0,0],[50]   ]]
  ],[   
     // Troops : These are distributed across all vehicles in this convoy. These lines are identical to the lines in the group section.
     //  Troop behaviour and side options                        # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
  //  [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[1,"Rifleman"]],["BoxPatrol",[-70,-600],[0,0],[0]]],
  //  [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[2,"Rifleman"]],["BoxPatrol",[-70,-600],[50,0],[50]]],
  //  [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[1,"Rifleman"]],["BoxPatrol",[-70,-600],[-50,0],[50]]]
   // 'dest' for troops is where they will go to perform their 'Patrol Logic' once the disembark the convoy IF their vehicle's driver group is using the 'Convoy' patrol logic.
   // otherwise troops will remain in vehicle unless it is engaged. Once vehicle destroyed, Troops will move onto their 'Patrol Logic'.
     ]
   ]
		  
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
 //     ["LowUnitCount", "GUER", 0, 0, [0,0]], // all enemies are dead:  side options "EAST","WEST","GUER","CIV","LOGIC","ANY"
      ["ProxPlayer", [0,0], 80, 1], // 1 player is within 20 meters of encounter center.
	  //["Reinforce", 100, "Random"] // %chance when requested, Mission to run
	  ["BodyCount", 7]
    ],
    [    //LOSE Triggers and Controls
//      ["HighUnitCount", "GUER",10,40,[0,0]] // 10 enemies get within 40m's of encounter center
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


