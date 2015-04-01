//TestFunction.sqf
// Horbin
// 1/21/15
// 

[
["RaidTown", 200], // Mission Title NOSPACES!, and encounter radius
["Town","mil_objective","ELLIPSE","ColorRed","FDiagonal",200],    // Map Markers ["MapText", "SHAPE", "COLOR", "FILL", size];
   // type is "mil_objective"
[  
    [// NOTIFICATION Messages and Map display Control.
	true, "ALL",0, // Notify players via Radio Message, radio channel, range from encounter center (0=unlimited.
    true, // Notify players via global message
    true,// Show encounter area on the map
    120,    // Win delay: Time in seconds after a WIN before mission cleanup is performed
    30       // Lose delay: Time in seconds after a lose before mission cleanup is performed
          //NOTE: the above delay must occur before the mission is considered 'complete' by the mission manager control loop.
    ],
    // Spawn Mission Message
["Town Raid",
    "A city is being looted by humans",
    "A city is being invaded by humans!"
],
    
    // Mission Success Message
["Mission Success",
    "Look for their loot in the center of town!",
    "The loot collected has been captured by clones!"
],
  
    // Mission Failure Message
["Mission Failure!",
    "",
    "We have escaped with the resources."
] 
],
[  //  Loot Config:  Refer to LootData.sqf for specifcs
["None" , [0,0] ], //[static loot, offset location] - spawns with the mission
["TownLoot" , [0,0] ], // Win loot, offset location - spawns after mission success
["None" , [0,0] ]  // Failure loot, offset location - spawns on mission failure
],
[//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.

],
[ // AI GROUPS. Only options marked 'Def:' implemented.

],

// Vehicles
[
    [  // Convoy #1    South
 [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
   [  "B_Truck_01_transport_EPOCH",[0,-600],[2,"Rifleman"],        "Truck01"      ] 
    ],[  
    // Drivers                                                         # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["Convoy",[0,-600],[0,-100],["NORMAL",true,true, true]   ]]
  ],[   
     // Troops : These are distributed across all vehicles in this convoy.                                                         
     //  Troop behaviour and side options                        # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
      [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"] ,[5, "Rifleman"]],["Buildings",[0,-600],[0,-50],[100]]] // [timer, radius]
  //    [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"] ,[5, "Rifleman"]],["Explore",[0,-600],[0,-50],[2400,100]]] // [timer, radius]
     ]
   ],
     [  // Convoy #2    North
 [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
   [  "B_Truck_01_transport_EPOCH",[0,600],[2,"Rifleman"],        "Truck01"      ] 
    ],[  
    // Drivers                                                         # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["Convoy",[0,600],[0,100],["NORMAL",true,true, true]   ]]
  ],[   
     // Troops : These are distributed across all vehicles in this convoy.                                                         
     //  Troop behaviour and side options                        # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
      [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"] ,[5, "Rifleman"]],["Buildings",[0,600],[0,50],[100]]] // [timer, radius]
//      [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"] ,[5, "Rifleman"]],["Explore",[0,-600],[0,-50],[2400,100]]] // [timer, radius]
     ]
   ],
     [  // Convoy #3  East
 [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
   [  "B_Truck_01_transport_EPOCH",[600,0],[2,"Rifleman"],        "Truck01"      ] 
    ],[  
    // Drivers                                                         # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["Convoy",[600,0],[100,0],["NORMAL",true,true, true]   ]]
  ],[   
     // Troops : These are distributed across all vehicles in this convoy.                                                         
     //  Troop behaviour and side options                        # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
      [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"] ,[5, "Rifleman"]],["Buildings",[600,0],[50,0],[100]]] // [timer, radius]
//      [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"] ,[5, "Rifleman"]],["Explore",[0,-600],[0,-50],[2400,100]]] // [timer, radius]
     ]
   ],
     [  // Convoy #4    West
 [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
   [  "B_Truck_01_transport_EPOCH",[-600,0],[2,"Rifleman"],        "Truck01"      ] 
    ],[  
    // Drivers                                                         # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["Convoy",[-600,0],[-100,0],["NORMAL",true,true, true]   ]]
  ],[   
     // Troops : These are distributed across all vehicles in this convoy.                                                         
     //  Troop behaviour and side options                        # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
      [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"] ,[5, "Rifleman"]],["Buildings",[-600,0],[-50,0],[100]]] // [timer, radius]
//      [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"] ,[5, "Rifleman"]],["Explore",[0,-600],[0,-50],[2400,100]]] // [timer, radius]
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
      ["LowUnitCount", "GUER", 3, 300, [0,0]], // 3 or fewer enemies within 500m
      ["ProxPlayer", [0,0], 150, 1], // 1 player is within 150 meters of encounter center.
	  ["TIMER", 600], // prevents victory until at least 10 minutes into encounter
       ["BodyCount",20] // at least 20 enemy must be killed by players.
//	  ["Reinforce", 100, "Random"] // %chance when requested, Mission to run

    ],
    [    //LOSE Triggers and Controls
//      ["HighUnitCount", "GUER",10,40,[0,0]] // 10 enemies get within 40m's of encounter center
        ["TIMER",3000] // mission ends after 50 minutes
//          ["TIMER", 1200]//mission ends in 20 minutes.
    ],   
    [    //Phase01 Triggers and Controls
//      ["Detected",0,0]    //Launch mission if any group or vehicle detects a player
        ["TIMER", 2400]   // transition to phase mission after 40 minutes - evac team approaches town.
    ],
    [    //Phase02 Triggers and Controls
    
    ],
    [    //Phase03 Triggers and Controls
    
    ],
    [    // NO TRIGGERS: Uncomment the line below to simply have this mission execute. Mission triggers from a mission that
          // launched this mission will continue to be observed.
    // Uncommenting this line will ignore all triggers defined above, and mission will pass neither a WIN or LOSE result.
       //["NO TRIGGERS"]
    ]
],
// Phased Missions.
// Chaininig of missions is unlimited.
// Above triggers will 'suspend' when below phase starts. Phase launched will use its own triggers as specified in its mission script.
// If it is desired to continue to use the above Triggers instead of the 'launched mission's' triggers do the following:
//   uncomment the "NO TRIGGERS' line from the mission being launched.
// The below specified missions will be precompiled into the specified 'calls' when this script runs.
// The file needs to be located in the same folder as this mission launching them.
[
    "EvacTown" //Phase01
//    "TestPhase2", //Phase02
//    "TestPhase3" //Phase03
]

];
