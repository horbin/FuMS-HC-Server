//Small2.sqf
// Horbin
// 1/11/15
// Based upon drsubo Mission Scripts

[
["HostilePatrol", 75], // Mission Title NOSPACES!, and encounter radius
["Hostile Patrol","mil_objective","ELLIPSE","ColorOrange","FDiagonal",75],    
   
[  
    [// NOTIFICATION Messages and Map display Control.
	true, 1, 0,
    true, // Notify players via global message
    true,// Show encounter area on the map
    300,    // Win delay: Time in seconds after a WIN before mission cleanup is performed
    30       // Lose delay: Time in seconds after a lose before mission cleanup is performed
          //NOTE: the above delay must occur before the mission is considered 'complete' by the mission manager control loop.
    ],
    // Spawn Mission Message
[
    "A Hostile Patrol Has Been Spotted!",
    "A Small Patrol Was Spotted",
    "You have our permission to confiscate any property you find as payment for eliminating the threat!."
],
    
    // Mission Success Message
["Mission Success",
    "HostilePatrol",
    "The Hostile's have been destroyed."
],
  
    // Mission Failure Message
["Mission Failure!",
    "HostilePatrol",
    "The Hostile's have escaped."
] 
],
[  //  Loot Config:  Refer to LootData.sqf for specifcs
["None" , [18,-9] ], //[static loot, offset location] - spawns with the mission
["RANDOM" , [0,0] ], // Win loot, offset location - spawns after mission success
["None" , [-7,0] ]  // Failure loot, offset location - spawns on mission failure
],
[//BUILDINGS: persist = 1: building deleted at event completion, 1= building remains until server reset.
  //["CamoNet_INDP_open_F",[0,0],0,0]  //type, offset, rotation, presist flag
	 
],
[ // AI GROUPS. Only options marked 'Def:' implemented.
[["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"HUNTER"]           ],     ["BUILDINGS",[6,-6],[0,0],[50]     ]],
[["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"HUNTER"]           ],     ["BUILDINGS",[-6,6],[0,0],[50]     ]],
[["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"LMG"]              ],     ["EXPLORE",   [0,0],[0,1], [50]      ]],
[["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"SNIPER"]           ],     ["SENTRY",   [0,0],[1,0], [50]      ]]

],

 // Vehicles
[
                 
],            

[ // NOTE: side RESISTANCE for groups == side GUER for Triggers.
    [    //WIN Triggers and Controls
      ["LowUnitCount", "GUER", 2, 100, [0,0]], // 3 or fewer enemies within 500m	
      ["ProxPlayer", [0,0], 50, 1] // 1 player is within 100 meters of encounter center.
      //["BodyCount", 20],
      //["Reinforce", 75, "Random"]
    ],
    [    //LOSE Triggers and Controls
      ["TIMER", 3000]   // Encounter fails after 1500 seconds (25 minutes)
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
