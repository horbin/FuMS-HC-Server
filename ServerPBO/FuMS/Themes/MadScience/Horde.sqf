//NukeDevice.sqf
// Horbin
// 1/11/15
// Based upon drsubo Mission Scripts

[
["Zombies", 200], // Mission Title NOSPACES!, and encounter radius
["Zombies","mil_objective","ELLIPSE","ColorRed","FDiagonal",200],    // Map Markers ["MapText", "SHAPE", "COLOR", "FILL", size];
   // type is "mil_objective"
[  
    [// NOTIFICATION Messages and Map display Control.
	false, "ALL",0, // Notify players via Radio Message, radio channel, range from encounter center (0=unlimited.
    false, // Notify players via global message
    false,// Show encounter area on the map
    0,    // Win delay: Time in seconds after a WIN before mission cleanup is performed
    0       // Lose delay: Time in seconds after a lose before mission cleanup is performed
          //NOTE: the above delay must occur before the mission is considered 'complete' by the mission manager control loop.
    ],
    // Spawn Mission Message
["Mission",
    "",
    ""
],
    
    // Mission Success Message
["Mission Success",
    "",
    ""
],
  
    // Mission Failure Message
["Mission Failure!",
    "",
    ""
] 
],
[  //  Loot Config:  Refer to LootData.sqf for specifcs
["None" , [18,-9] ], //[static loot, offset location] - spawns with the mission
["None" , [5,5] ], // Win loot, offset location - spawns after mission success
["None" , [0,0] ]  // Failure loot, offset location - spawns on mission failure
],
[//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.
//    ["Land_Device_disassembled_F",[0,0],0,0]   //type, offset, rotation, presist flag
],
[ // AI GROUPS. Only options marked 'Def:' implemented.
//   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[2,"Rifleman"],[2,"Hunter"]  ],   ["BoxPatrol",[0,75],[0,0],[0]   ]],
//    [["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"]                                         ],   ["Guard",[-20,10],[0,0],[70] ]],
[["ZOMBIE","CARELESS","RED","LINE"],   [  [5,"Zombie"]           ],     ["Zombie",[50,-50],[50,-50],[]     ]],
[["ZOMBIE","CARELESS","RED","LINE"],   [  [5,"Zombie"]           ],     ["Zombie",[50,50],[50,50],[]     ]],
[["ZOMBIE","CARELESS","RED","LINE"],   [  [5,"Zombie"]           ],     ["Zombie",[-50,-50],[-50,-50],[]     ]],
[["ZOMBIE","CARELESS","RED","LINE"],   [  [5,"Zombie"]           ],     ["Zombie",[-50,50],[-50,50],[]     ]]
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
      ["LowUnitCount", "EAST", 0, 0, [0,0]] // all enemies are dead:  side options "EAST","WEST","GUER","CIV","LOGIC","ANY"
     // ["ProxPlayer", [0,0], 20, 1] // 1 player is within 20 meters of encounter center.
	//  ["Reinforce", 100, "Random"] // %chance when requested, Mission to run
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
