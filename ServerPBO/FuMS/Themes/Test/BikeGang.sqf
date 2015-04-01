//BikeGang.sqf
// Horbin
// 1/20/15
// Be cautious when editing data.

[
["BikeGang", 300], // Mission Title NOSPACES!, and encounter radius
["Bike Gang","mil_dot","ELLIPSE","ColorYellow","FDiagonal",200],    // Map Markers ["MapText", "SHAPE", "COLOR", "FILL", size];
[  
    [// NOTIFICATION Messages and Map display Control.
	true, "ALL", 0, // Notify players via Radio Message, radio channel, range from encounter center (0=unlimited.
    false, // Notify players via global message
    true,// Show encounter area on the map
    30,    // Win delay: Time in seconds after a WIN before mission cleanup is performed
    10       // Lose delay: Time in seconds after a lose before mission cleanup is performed
          //NOTE: the above delay must occur before the mission is considered 'complete' by the mission manager control loop.
    ],
    // Spawn Mission Message 
    ["",  // title line
     "", // title line, do not remove these!
     "A roving band of clone hunters have entered the area." //description/radio message.
	],  
    // Mission Success Message
    ["Mission Success",
     "",
     "The bikers been destroyed!"
	], 
    // Mission Failure Message
    ["Mission Failure!",
    "",
    "The bikers have escaped to harass another region!"
	] 
],
[  //  Loot Config:  Refer to LootData.sqf for specifics
["Random" , [0,0] ], //[static loot, offset location] - spawns with the mission
   // static loot will also spawn if 'NO TRIGGERS' is enabled.
["Random" , [0,0] ], // Win loot, offset location - spawns after mission success
["None" , [0,0] ]  // Failure loot, offset location - spawns on mission failure
],
[//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.
  
],
[ // AI GROUPS. Only options marked 'Def:' implemented.
 //  [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[2,"Rifleman"],[2,"Hunter"]  ],   ["BoxPatrol",[0,75],[0,0],[0]   ]],
 //   [["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"]                                         ],   ["Sentry",[-20,10],[0,0],[70] ]],
 //  [["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"Hunter"]                                              ],   ["Guard",[6,6],[0,0],[30]     ]]
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
    [         // Vehicle                     Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
           [  "C_Quadbike_01_EPOCH"          ,[-50,1000],[],        "None"      ], 
           [  "C_Quadbike_01_EPOCH"          ,[-50,1000],[],     "None"      ], 
           [  "C_Quadbike_01_EPOCH"          ,[-50,1000],[],     "None"      ]
		//   [  "C_Quadbike_01_EPOCH"          ,[-50,-600],[1,"Rifleman"],     "None"      ], 
		 //  [  "C_Quadbike_01_EPOCH"          ,[-50,-600],[1,"Rifleman"],     "None"      ], 
         //  [  "C_Quadbike_01_EPOCH"          ,[-50,-600],[ 1, "Rifleman"],     "Truck01"]   
                 // If driver-less vehicles are desired, place them at the bottom of the list. 
				 // Troops WILL be placed into 'driver-less' vehicles if the other vehicles are full!!!
      ],
      [  
          // "Convoy": spawn at -500,-500, drop off cargo at -50,-50, then return to base. (ie 'Convoy' logic behaviour)
           // Drivers                                                          # and type  |         Patrol     |    spawn   | dest       | 'Patrol' options
          [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [3, "Driver"]  ],   ["Convoy",[-50,1000],[0,-15],["NORMAL",true,false,true]   ]]
         // proceed to 0,-15, drop off troops, then return to spawn location and despawn!
      ],
      // Troops : These are distributed across all vehicles in this convoy.                                                         
     [      //  Troop behaviour and side options                        # and type of Troops                               Patrol logic |  spawn     |dest |'Patrol' options
         [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[2,"Rifleman"]  ],   ["BoxPatrol",[-50,1000],[0,0],[100]   ]]
        // [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[2,"Rifleman"] ],   ["BoxPatrol",[-70,-600],[50,0],[50]   ]],
        // [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[3,"Rifleman"]  ],   ["BoxPatrol",[-70,-600],[-50,0],[50]   ]]
            // 'dest' for troops is where they will go to perform their 'Patrol Logic' once the disembark the convoy IF their vehicle's driver group is using the 'Convoy' patrol logic.
            // otherwise troops will remain in vehicle unless it is engaged. Once vehicle destroyed, Troops will move onto their 'Patrol Logic'.
     ]
   ],
      [  // Convoy #2                     
    [         // Vehicle                     Offset         Crew (only 1 type!)   Cargo
		     [  "C_Quadbike_01_EPOCH"         ,[-50,1000],[],        "None"      ], 
           [  "C_Quadbike_01_EPOCH"          ,[-50,1000],[],     "None"      ], 
           [  "C_Quadbike_01_EPOCH"          ,[-50,1000],[],     "None"      ]
//		   [  "C_Quadbike_01_EPOCH"          ,[-50,-600],[1,"Rifleman"],     "None"      ], 
//		   [  "C_Quadbike_01_EPOCH"          ,[-50,-600],[1,"Rifleman"],     "None"      ], 
 //          [  "C_Quadbike_01_EPOCH"          ,[-50,-600],[ 1, "Rifleman"],     "Truck01"]   
                 // If driver-less vehicles are desired, place them at the bottom of the list. 
				 // Troops WILL be placed into 'driver-less' vehicles if the other vehicles are full!!!
      ],
      [                 
           // Drivers                                                          # and type  |         Patrol     |    spawn   | dest       | 'Patrol' options
          [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [3, "Driver"]  ],   ["Convoy",[-50,1000],[-50,50],["NORMAL",false,false,false]   ]]
            // proceed to -50,50, drop off troops, then begin a box patrol, not staying to roads.
      ],
      // Troops : These are distributed across all vehicles in this convoy.                                                         
     [      //  Troop behaviour and side options                        # and type of Troops                               Patrol logic |  spawn     |dest |'Patrol' options
        [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[2,"Rifleman"]  ],   ["BoxPatrol",[-500,1000],[20,0],[100]   ]]
 //     [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[5,"Rifleman"]     ],   ["BoxPatrol",[-600,-200],[20,20],[0]   ]]
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
      ["LowUnitCount", "GUER", 3, 0, [0,0]], // all enemies are dead:  side options "EAST","WEST","GUER","CIV","LOGIC","ANY"
       ["ProxPlayer", [0,0], 50, 1], // 1 player is within 100 meters of encounter center.
	   ["Reinforce", 25, "Random"], // %chance when requested, Mission to run
	   ["Timer", 600] // 10minutes must pass prior to being able to complete the mission (to allow bikes to get there!!!
	   // Note Reinforce trigger will not impact win/loss logic.
    ],
    [    //LOSE Triggers and Controls
//      ["HighUnitCount", "GUER",10,40,[0,0]] // 10 enemies get within 40m's of encounter center
           //["Timer",180]  // mission ends after 3 minutes if not completed
    ],   
    [    //Phase01 Triggers and Controls
//        ["Timer", 180]  // Mission Ends in 180 seconds
      ["Detected",0,0]    //Launch mission if any group or vehicle detects a player
      //   ["ProxPlayer", [0,0], 100, 1] // 1 player is within 100 meters of encounter center.
    ],
    [    //Phase02 Triggers and Controls
		["Timer", 180]
    ],
    [    //Phase03 Triggers and Controls
		["ProxPlayer", [0,0], 50, 1]
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
Def: ["Reinforce", chance, "MsnName"]: Sets up reinforcement logic in the event AI calls for help via RadioChatter
      This trigger has no impact on 'win' conditions. If reinforcement ability is desired, ensure this trigger
	  is included in the mission, as well as any 'phased' missions.

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
    "NukeDevice",  //Phase01
    "TestPhase2", //Phase02
    "TestMission01Enemy" //Phase03
]



];

