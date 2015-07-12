//Small3.sqf
// Horbin
// 1/11/15
// Based upon drsubo Mission Scripts

[
["Gang", 75], // Mission Title NOSPACES!, and encounter radius
["Gang","mil_objective","ELLIPSE","ColorOrange","FDiagonal",75],    
   
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
    "A Gang Of Looter's Has Been Spotted!",
    "A Small Gang Was Spotted",
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
 // ["CamoNet_INDP_open_F",[0,0],0,0]  //type, offset, rotation, presist flag
	 
],
[ // AI GROUPS. Only options marked 'Def:' implemented.
[["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"HUNTER"]           ],     ["BUILDINGS",[6,-6],[0,0],[75]     ]],
[["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"HUNTER"]           ],     ["BUILDINGS",[-6,6],[0,0],[75]     ]],
[["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"LMG"]              ],     ["EXPLORE",   [0,0],[0,1], [50]      ]],
[["RESISTANCE","COMBAT","RED","LINE"],   [  [2,"SNIPER"]           ],     ["SENTRY",   [0,0],[1,0], [50]      ]]

],

 // Vehicles
[
                 
],            

[
	[
      //Define all the triggers this mission will be using
	  // Trigger names must be unique within each mission.
	  // NOTE: "FuMS_KillMe" is a reserved trigger word. Do not use!!!
	  // NOTE: "OK" is a reserved trigger. Do not define it here.
	  //  "OK" can be used in the actions section to force an action to occur at mission start!	 
	  ["PROX",["ProxPlayer",[0,0],100,1]  ],
	  ["LUCNT",["LowUnitCount","GUER",1,0,[0,0]]  ],
//	  ["HUCNT",["HighUnitCount","GUER",6,0,[0,0]] ],
//	  ["Detect",["Detected","ALL","ALL"] ],
//	  ["BodyCount",["BodyCount",9] ]
	  ["Timer",["TIMER", 3000] ]
	  //                            offset      radius    time(s)  Name
//	  ["Zuppa", ["ZuppaCapture",[ [ [-100,-100], 50,         90,  "Point 1" ],
 //                               [ [100,100],   50,         90,  "Point 2" ]   ]]  ],
//       ["VehDmg1", ["DmgVehicles", "1",0.8]  ],
//       ["BldgDmg1",["DmgBuildings","2,3,7",1.0]  ]
	  
	],
	[
	  // Define what actions should occur when above trigger logics evaluate to true
	   // Note: a comma between two logics is interpreted as "AND"
	  [["WIN"],["LUCNT","PROX"    ]],  // 
	//  [["CHILD","Help_Helo",[0,0]],["OK"      ]],  // 
	// [["Reinforce","Help_Vehicle","Trig4"]], 
	  [["LOSE"],["TIMER"]   ],
      [["END"],["LUCNT","PROX"     ]]  
	]      
]

];
