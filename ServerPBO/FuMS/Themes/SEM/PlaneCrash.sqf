//PlaneCrash.sqf
// Horbin
// 1/11/15
// Based upon drsubo Mission Scripts

[
["PlaneCrash", 100], // Mission Title NOSPACES!, and encounter radius
["Aircraft Crash","mil_objective","ELLIPSE","Colorgreen","FDiagonal",200],    // Map Markers ["MapText", "SHAPE", "COLOR", "FILL", size];
   // type is "mil_objective"
[  
    [// NOTIFICATION Messages and Map display Control.
	true, 1, 0,
    true, // Notify players via global message
    true,// Show encounter area on the map
    30,    // Win delay: Time in seconds after a WIN before mission cleanup is performed
    30       // Lose delay: Time in seconds after a lose before mission cleanup is performed
          //NOTE: the above delay must occur before the mission is considered 'complete' by the mission manager control loop.
    ],
    // Spawn Mission Message
[
    "Aircraft Crash!",
    "",
    "A supply plane has crashed with surviving bandits!."
],
    
    // Mission Success Message
["Mission Success",
    "",
    "The bandits have been destroyed."
],
  
    // Mission Failure Message
["Mission Failure!",
    "",
    "The bandits have escaped."
] 
],
[  //  Loot Config:  Refer to LootData.sqf for specifcs
["None" , [18,-9] ], //[static loot, offset location] - spawns with the mission
["RANDOM" , [-5,0] ], // Win loot, offset location - spawns after mission success
["None" , [0,0] ]  // Failure loot, offset location - spawns on mission failure
],
[//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.
    ["Land_UWreck_MV22_F",[6,6],0,0]   //type, offset, rotation, presist flag
],
[ // AI GROUPS. Only options marked 'Def:' implemented.

[["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Sniper"]           ],     ["Explore",[6,-6],[0,0],[0]     ]],
[["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"],[1,"LMG"] ],   ["Explore",[6,6],[0,0],[0]     ]],
[["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Rifleman"]           ],   ["BoxPatrol",[-6,-6],[0,0],[0]     ]]
],

// Vehicles
[
                 
],
// Triggers and Event control.
[ // NOTE: side RESISTANCE for groups == side GUER for Triggers.
    [    //WIN Triggers and Controls
      //["LowUnitCount", "GUER", 0, 0, [0,0]], // all enemies are dead:  side options "EAST","WEST","GUER","CIV","LOGIC","ANY"
      ["ProxPlayer", [0,0], 100, 1], // 1 player is within 100 meters of encounter center.
      ["BodyCount", 7],
      ["Reinforce", 25, "Random"]
    ],
    [    //LOSE Triggers and Controls
//      ["HighUnitCount", "GUER",10,40,[0,0]] // 10 enemies get within 40m's of encounter center
  //   ["TIMER", 1500]   // Encounter fails after 1500 seconds (25 minutes)
    ],   
    [    //Phase01 Triggers and Controls
//      ["Detected",0,0]    //Launch mission if any group or vehicle detects a player
       
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

[
//    "TestPhase1",  //Phase01
//    "TestPhase2", //Phase02
//    "TestPhase3" //Phase03
]

];
