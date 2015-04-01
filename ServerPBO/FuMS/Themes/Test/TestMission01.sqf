//TestMission01.sqf
// Horbin
// 12/31/14
// Be cautious when editing data.

// NOTE: For all Offset values, if three dimensions are used, the point will be treated as an absolute point on the game map.
// Ex: [15,20] is an offset 15m east, 20m north of the encounter center
// Ex: [12100,11000,0] is a specific point on the map.
// absolute 3d locations can be subsituted for any offset within this file!
[[
//------------------------------------------------------------------------------------
//-----Mission Area Setup-----
    "TestMission",  // Mission Title NOSPACES!
    200                // encounter radius
],[ 
//------------------------------------------------------------------------------------
//-----Notification Configuration-----
//--Map Marker Config.
    "Test Mission",  // Name, set to "" for nothing
     "mil_dot", // icon type:                                     https://community.bistudio.com/wiki/cfgMarkers for other options.
                     // mil_triangle, mil_objective, mil_box, group1, loc_Power, etc.
     "ELLIPSE", // "RECTANGLE". do not use "ICON", two markers are used in making each mission indicator.
     "ColorYellow",//                                                  https://community.bistudio.com/wiki/setMarkerColor
     "FDiagonal",// Cross, Vertical, Horizontal, etc      https://community.bistudio.com/wiki/setMarkerBrush 
       200           // size of the marker.    
],[[
    // NOTIFICATION Messages and Map display Control.
	true,    // Notify players via Radio Message
    "ALL",   // radio channel. "ALL" = no radio required.
    0,         //range from encounter center AI radio's can be heard (0=unlimited.)
    false,  // Notify players via global message - hint screen on right of game display -
    true,   // Show encounter area on the map
    30,      // Win delay: Time in seconds after a WIN before mission cleanup is performed
    10       // Lose delay: Time in seconds after a lose before mission cleanup is performed
//NOTE: the above delay must finish before the mission is considered 'complete' by the mission manager control loop.
// These two delays will also affect how much time will elapse from mission completion until living AI cleanup.
],[
   // Mission spawn message, DO NOT Remove these! They can be edited down to "" if desired.
     "CORE Directive",  // title line
     "Defense Alert!", 
     "High Command has directed us to establish a Forward Operating Base!" //description/radio message.
],[  
    // Mission Success Message
    "Mission Success",  // title line
     "",
     "Notifying High Command that the FOB has been destroyed!"
],[
   // Mission Failure Message
    "Mission Failure!",
    "",
    "Reconnaissance complete. All forces are to RTB."
]],[
//---------------------------------------------------------------------------------
//-----Loot Configuration-----    
// Refer to LootData.sqf for available loot types and contents.
[
   ["Random",[0,0]],["Random",[5,5]],["Random",[-5,5]]
   //Array of loot now supported using above syntax.
   // replace "Random" with your desired loot option from LootData.sqf, or leave random for random results!
   // AND don't forget you can use these loot options to fill vehicles with loot too!(see vehicle section below)
],[
    "Random" ,        // WIN Loot
    [0,0]                // Offset from mission center x,y, 3 coords [x,y,z] places loot at a specific map location!  
],[
    "None" ,            // Lose Loot.
     [0,0]                // Offset from mission center.
]],[
//---------------------------------------------------------------------------------
//-----Building  and stand alone vehicle Configuration-----       
//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.
// NOTE: if using 3D coordinates for buildings, if the 1st building uses a location of [0,0,0] 
// ALL other buildings will assume their locations are offsets!
    // building name                 | offset   |rotation|persist flag
    ["Land_BagBunker_Tower_F",  [0,0],     0,         0],  
    ["Land_BarrelWater_F",          [-7,-7], 0,         0],
    ["Land_Wreck_Car2_F",          [12,12],  0,         0],
    ["Land_Wreck_Offroad2_F",   [-10,-10],0,        0],
    ["Land_HighVoltageTower_F",    [20,-10],0,       0],
    ["CamoNet_INDP_big_F",        [-20, 10],0,        0],
	// Vehicle Name  | offset | rotation | Fuel, Ammo, DmgEngine, Dmg FuelTank, DmgHull
	["I_UGV_01_rcws_F",[0,100],   0,       [.5,   0,     .5,         .5,         .5]]
	// vehicles: 1 for fuel and ammo is full 100%, DmgEngine=1 is 100% damaged
	
],[
//---------------------------------------------------------------------------------
//-----Group Configuration-----  see Convoy section for AI in vehicles! 
//--- See SoldierData.sqf for AI type options.
/*
    Defined AI logic options: See 'Documenation' for details'
["BUILDINGS", [spawnloc], [actionloc], [duration, range]]  
["EXPLORE   ",[spawnloc], [actionloc], [radius]]
["BOXPATROL", [spawnloc], [actionloc], [radius]]
["CONVOY",    [spawnloc], [actionloc], [speed, FlagRTB, FlagRoads, FlagDespawn, convoyType]]
["SENTRY",    [spawnloc], [actionloc], [radius]]
["PARADROP",  [spawnloc], [actionloc], [speed, altitude, FlagRTB, FlagSmokes]]  
["PATROLROUTE", [spawnloc], [actionloc], [behaviour, speed, [locations], FlagRTB, FlagRoads, FlagDespawn, flyHeight]    
    
*/
// **paste 'copy' below this line to add additional groups.

// **Start 'copy'****Spawn a Group of AI Config Data *********
// 3 rifleman that will spawn NW of encounter center and patrol all buildings within 70m
// Example below shows how town names can be used in place of spawn locations and offsets!
    [["RESISTANCE","COMBAT","RED","LINE"],[[3,"Rifleman"]],["Buildings",[0,0],[0,0], [70] ]], // 3 rifleman that will patrol all buildings within 70m for unlimited duration
// **End 'copy'******(see Patrol Options below for other AI behaviour)
// Example of a 3D map location. This loc is specific to ALTIS
[["RESISTANCE","COMBAT","RED","LINE"],[[5,"Rifleman"]],["BoxPatrol",[21520,11491.9,0],[0,0],[70] ]],
    // 5 rifleman that spawn at [21520,11491.9,0] and march to encounter centr to set up a box patrol!    
// Expanded group example:
// 1 sniper, 2 rifleman, 2 hunters wil spawn east of encounter center and perform a box shaped patrol.
[[
    "RESISTANCE", // side: RESISTANCE, WEST, EAST, CIV
    "COMBAT",      // behaviour: SAFE, AWARE, COMBAT, STEALTH
    "RED",          //combatmode: BLUE, WHITE, GREEN, YELLOW, RED
    "COLUMN"    //formation: STAG COLUMN, WEDGE, ECH LEFT, ECH RIGHT, VEE, LINE, COLUMN
],[      // number and type of AI to be in the group (see SoldierData.sqf)
    [1,"Sniper"],[2,"Rifleman"],[2,"Hunter"]          
],[  
    "BoxPatrol",  
    [0,75],   // spawn location offset.
    [0,0],    // origion of patrol routine.
    [0]       // options to be passed to the routine.
]],
// 2 hunters that will spawn near encounter center and take up guard positions.
// This example the AI are spawned 6 meters NE of encoutner center, and will look for a building within 30meters of encounter senter to take up Sentry postions.
 [["RESISTANCE","COMBAT","RED","LINE"],[[2,"Hunter"]],["Sentry",[6,6],[0,0],[30]]
]],
// NOTE: if no buildings are located within 'radius' both 'Buildings' and 'Lookout' will locate nearest buildings to the encounter and move there!
// NOTE: See AI_LOGIC.txt for detailed and most current descriptions of AI logic.

//---------------------------------------------------------------------------------
//-----LAND Vehicle Configuration----- 
[
 [  // Convoy #1    
    // Spawns 3 vehicles 600m south of encounter center. These 3 will move as a convoy and contain 3 groups of mixed troops.
    // These troops will be dropped off just south of encounter center, then the convoy will return to their spawn location and despawn.
 [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
   [  "B_Truck_01_transport_EPOCH",[-50,-610],[1,"Rifleman"],        "Truck01"      ], 
   [  "C_Offroad_01_EPOCH"           ,[-50,-635],[1,"Rifleman"],     "None"      ], 
   [  "C_Offroad_01_EPOCH"           ,[-50,-688],[1,"Rifleman"],     "None"      ]
   //[  "C_Offroad_01_EPOCH"           ,[13300,14600,0],[ 0, ""          ],       "Truck01"]   
                 // If driver-less vehicles are desired, place them at the bottom of the list. 
				 // Troops WILL be placed into 'driver-less' vehicles if the other vehicles are full!!!
    ],[  
    // Drivers                                                         # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [3, "Driver"]  ],   ["Convoy",[-75,-600],[0,-50],["NORMAL",true,true, true]   ]]
  ],[   
     // Troops : These are distributed across all vehicles in this convoy. These lines are identical to the lines in the group section.
     //  Troop behaviour and side options                        # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
    [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[1,"Rifleman"]],["BoxPatrol",[-70,-600],[0,0],[0]]],
  //  [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[2,"Rifleman"]],["BoxPatrol",[-70,-600],[50,0],[50]]],
    [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[1,"Rifleman"]],["BoxPatrol",[-70,-600],[-50,0],[50]]]
   // 'dest' for troops is where they will go to perform their 'Patrol Logic' once the disembark the convoy IF their vehicle's driver group is using the 'Convoy' patrol logic.
   // otherwise troops will remain in vehicle unless it is engaged. Once vehicle destroyed, Troops will move onto their 'Patrol Logic'.
     ]
   ],
   
     [  // Convoy #2                     
    [         // Vehicle                     Offset         Crew (only 1 type!)   Cargo
           [  "B_Truck_01_transport_EPOCH",[-500,-200],[0,""],"None"      ] 
                 // If driver-less vehicles are desired, place them at the bottom of the list. 
				 // Troops WILL be placed into 'driver-less' vehicles if the other vehicles are full!!!
      ],
      [                 
           // Drivers                                                          # and type  |         Patrol     |    spawn   | dest       | 'Patrol' options
          [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["BoxPatrol",[-600,-200],[-50,50],[0]   ]]
          
      ],
      // Troops : These are distributed across all vehicles in this convoy.                                                         
     [      //  Troop behaviour and side options                        # and type of Troops                               Patrol logic |  spawn     |dest |'Patrol' options
        [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[4,"Rifleman"]  ],   ["BoxPatrol",[-600,-200],[20,0],[0]   ]]
 //     [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[5,"Rifleman"]     ],   ["BoxPatrol",[-600,-200],[20,20],[0]   ]]
            // 'dest' for troops is where they will go to perform their 'Patrol Logic' once the disembark the convoy IF their vehicle's driver group is using the 'Convoy' patrol logic.
             // otherwise troops will remain in vehicle unless it is engaged. Once vehicle destroyed, Troops will move onto their 'Patrol Logic'.
     ]
   ] 
   
   
   
],
// Triggers and Event control.
//  There are 3 general states for a mission. Win, Lose, or Phase Change.
// In order to establish a WIN or LOSE, all Trigger specified below must be met within their specified state.
// Same evaluation is done with checking for Phase changes. 
// Phase Change Detail:
//	When a 'phase change occurs the appropriate additional mission will be launched.
//  Win/Lose logic for this encounter will suspend when phase change is launched. 
//  If triggers in this mission are still desired, uncomment the "NO TRIGGERS" comment IN THE MISSION being launched by this mission"
// See the Triggers.txt file under Docs!
[ // NOTE: side RESISTANCE for groups == side GUER for Triggers.
    [    //WIN Triggers and Controls
      ["LowUnitCount", "GUER", 0, 0, [0,0]], // all enemies are dead:  side options "EAST","WEST","GUER","CIV","LOGIC","ANY"
       ["ProxPlayer", [0,0], 50, 1], // 1 player is within 50 meters of encounter center.
	   ["Reinforce", 100, "Help_Helo"] // %chance when requested, Mission to run
//  ["BodyCount", 10] // when at least 10 AI are killed by players
	   // Note Reinforce trigger will not impact win/loss logic.
    ],
    [    //LOSE Triggers and Controls
//      ["HighUnitCount", "GUER",10,40,[0,0]] // 10 enemies get within 40m's of encounter center
           //["Timer",180]  // mission ends after 3 minutes if not completed
    ],   
    [    //Phase01 Triggers and Controls
//        ["Timer", 180]  // Mission launches in 180 seconds
//      ["Detected",0,0]    //Launch mission if any AI group or vehicle detects a player
       //  ["ProxPlayer", [0,0], 100, 1] // 1 player is within 100 meters of encounter center.
    ],
    [    //Phase02 Triggers and Controls
       // ["Timer",120] // after 5 minutes Enemies to this AI arrive--town WAR!!!!!
    ],
    [    //Phase03 Triggers and Controls
    
    ],
    [    // NO TRIGGERS: Uncomment the line below to simply have this mission execute. Mission triggers from a mission that
          // launched this mission will continue to be observed.
    // Uncommenting this line will ignore all triggers defined above, and mission will pass neither a WIN or LOSE result.
    //   ["NO TRIGGERS"]
    ]
],

// Phased Missions.
// Chaininig of missions is unlimited.
// Above triggers will 'suspend' when below phase starts. Phase launched will use its own triggers as specified in its mission script.
// If it is desired to continue to use the above Triggers instead of the 'launched mission's' triggers do the following:
//   uncomment the "NO TRIGGERS' line from the mission being launched.
// The file needs to be located in the same folder as this mission launching them.
[
    ["NukeDevice",["Paros"]],  //Phase01 <-- as an array a 3dlocation, offset, or town name can be specified for the phase mission's center
    "TestMission01Enemy", //Phase02 <-- just a file name, phased mission uses THIS mission's center!
    "TestPhase3" //Phase03
],
[
    //Airborne Vehicle Configuration
 [  // Division #1
   [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
//     [  "O_Heli_Light_02_unarmed_EPOCH",[0,-1900],[1,"Rifleman"],        "Truck01"      ], 
//     [  "O_Heli_Light_02_unarmed_EPOCH"           ,[0,-1800],[1,"Rifleman"],     "None"      ], 
     [  "O_Heli_Light_02_unarmed_EPOCH"           ,[0,-1700],[1,"Rifleman"],     "None"      ]
    ],[  
    // Pilots                                                          # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["ParaDrop",[0,-1700],[0,0],["Normal", 200, true,true  ]   ]]
  ],[   
     // Troops : These are distributed across all aircraft in the division. These lines are identical to the lines in the group section.
     //  Troop behaviour and side options                    # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
 //   [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[-70,-1900],[0,0],[0]]],
 //   [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[-70,-1800],[50,0],[50]]],
    [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[0,-1700],[0,0],[150]]]
   // 'dest' for troops is where they will go to perform their 'Patrol Logic' once they get on deck
     ]
   ],
    [  // Division #2
   [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
     [  "O_Heli_Light_02_unarmed_EPOCH",[200,-1700],[1,"Rifleman"],        "Truck01"      ], 
     [  "O_Heli_Light_02_unarmed_EPOCH"           ,[200,-1750],[1,"Rifleman"],     "None"      ], 
     [  "O_Heli_Light_02_unarmed_EPOCH"           ,[200,-1800],[1,"Rifleman"],     "None"      ]
    ],[  
    // Pilots                                                          # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [3, "Driver"]  ],   ["PatrolRoute",[0,-1800],[0,0],["COMBAT","NORMAL",["Pyrgos"],true, false, true,100]   ]]
   //Patrol flys from spawn location to mission center [0,0] then  to Pyrgos, then returns to spawn location (RTB) and despawns!
  ],[   
  
     // Troops : These are distributed across all aircraft in the division. These lines are identical to the lines in the group section.
     //  Troop behaviour and side options                    # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
  //  [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[-70,-1700],[0,0],[0]]],
   // [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[-70,-1750],[50,0],[50]]],
    //[["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[0,-1800],[-50,0],[50]]]
   // 'dest' for troops is where they will go to perform their 'Patrol Logic' once they get on deck
     ]
   ]
    
]


];
//*******************************************************************************
//******* Do not change this!                                       **********************************
//*******************************************************************************
