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
    "Mil_Outpost",  // Mission Title NOSPACES!
    200 ,               // encounter radius
    "LAND"// Options "LAND","WATER","NONE". Setting this will force a scan of 'encounter Radius' meters around the center of the mission to ensure the same type of water/land is present.
               // This setting should hopefully reduce the chance of the mission being randomly placed too near water for example.
              // this paramater is optional, but if a value is present it MUST be one of the three above values.
              // This option is only used if a mission location is not set via the Theme's 'Locations' section, or the mission loc is not specified elsewhere in the ThemeData.sqf.
],[ 
//------------------------------------------------------------------------------------
//-----Notification Configuration-----
//--Map Marker Config.
    "Static Placement",  // Name, set to "" for nothing
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
// "Random" will select a random configuration, ignoring all 'ScatterXX' options.
// "ScatterXX" this loot will not appear in a box, but will be scattered about on the ground around the location/offset
    // Ex: ["Scatter01",[0,0]]  will take the loot contained in the "Scatter01" option and spread it around at offset [0,0] to the mission center.
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
// NOTE: if using 3D coordinates for buildings, if the 1st building uses a location of [0,0] 

    
    
// These vehicles are static and remain until server reset.
["M3Editor", [0,0], 777, 1, // 1 = vehicle will persist until server restart.
   // paste your array of buildings/vehicles what should stay until serverrestart
 [
	["B_Truck_01_mover_EPOCH",[14697.4,16707.8,0],133.183,[0,0,1],true]
]
 
],
 
// M3Editor buildings all with 'big_smoke'
["M3Editor", [0,0], "SMOKE_BIG", 0,
 
   // paste your array of building objects here
 [
	["Land_TentHangar_V1_F",[14692.4,16710.5,0],312.727,[0,0,1],true],
	["Land_LampShabby_F",[14694.2,16695.4,0],84.0909,[0,0,1],true],
	["Land_LampShabby_F",[14707.4,16710.3,0],179.091,[0,0,1],true],
	["Land_LampShabby_F",[14677.4,16711.2,0],349.091,[0,0,1],true],
	["Land_LampShabby_F",[14690.6,16726.1,0],267.727,[0,0,1],true],
	["Land_Cargo20_military_green_F",[14686.4,16707.5,0],196.364,[0,0,1],true],
	["Land_Cargo20_military_green_F",[14692.2,16702.4,0],196.364,[0,0,1],true],
	["CargoNet_01_barrels_F",[14692.6,16721.2,0],311.818,[0,0,1],true],
	["CargoNet_01_barrels_F",[14691.6,16720.1,0],311.818,[0,0,1],true],
	["CargoNet_01_barrels_F",[14690.6,16719,0],311.818,[0,0,1],true],
	["CargoNet_01_barrels_F",[14691.7,16718,0],311.818,[0,0,1],true],
	["CargoNet_01_barrels_F",[14692.7,16719.1,0],311.818,[0,0,1],true],
	["CargoNet_01_barrels_F",[14693.7,16720.3,0],311.818,[0,0,1],true],
	["Land_PalletTrolley_01_khaki_F",[14693.6,16716.8,0],279.091,[0,0,1],true],
	["Land_CratesWooden_F",[14698,16716.3,0],44.5454,[0,0,1],true],
	["Land_CratesWooden_F",[14699,16713.2,0],350,[0,0,1],true],
	["Land_CratesWooden_F",[14700.6,16714.9,0],225,[0,0,1],true],
	["Flag_Altis_F",[14686.3,16700.5,0],0,[0,0,1],true],
	["MetalBarrel_burning_F",[14695.6,16714.1,0],0,[0,0,1],true],
	["MetalBarrel_burning_F",[14693,16704.3,0],0,[0,0,1],true],
	["Land_WaterTank_F",[14681.3,16709.2,0],220.455,[0,0,1],true],
	["Land_Cargo10_military_green_F",[14689.2,16722.3,0],319.091,[0,0,1],true],
	["Land_FieldToilet_F",[14687.3,16725,0],76.8182,[0,0,1],true],
	["Land_FieldToilet_F",[14687,16726.3,0],76.8182,[0,0,1],true],
	["Land_Pallets_stack_F",[14695.5,16718.4,0],40.4546,[0,0,1],true],
	["Land_WaterCooler_01_new_F",[14683.1,16709.4,0],193.636,[0,0,1],true],
	["Box_Wps_F",[14689.5,16710.4,0],106.818,[0,0,1],true],
	["Box_Wps_F",[14688.5,16710.8,0],122.727,[0,0,1],true],
	["CargoNet_01_box_F",[14685.4,16710.3,0],15.9091,[0,0,1],true],
	["CargoNet_01_box_F",[14687.2,16709.9,0],30.4546,[0,0,1],true],
	["CargoNet_01_box_F",[14689,16709.1,0],15.9091,[0,0,1],true],
	["Box_Wps_F",[14690.5,16708.3,0],106.818,[0,0,1],true],
	["Box_Wps_F",[14690.7,16708.8,0],106.818,[0,0,1],true],
	["Box_Wps_F",[14691.6,16708.5,0],126.818,[0,0,1],true],
	["Box_Wps_F",[14690.9,16709.5,0],108.182,[0,0,1],true]
]
 
]


	
],[
//---------------------------------------------------------------------------------
//-----Group Configuration-----  see Convoy section for AI in vehicles! 
//--- See SoldierData.sqf for AI type options.
[[
    "RESISTANCE", // side: RESISTANCE, WEST, EAST, CIV
    "COMBAT",      // behaviour: SAFE, AWARE, COMBAT, STEALTH
    "RED",          //combatmode: BLUE, WHITE, GREEN, YELLOW, RED
    "COLUMN"    //formation: STAG COLUMN, WEDGE, ECH LEFT, ECH RIGHT, VEE, LINE, COLUMN
],[[1,"Sniper"],[1,"Rifleman"]],[  "TowerGuard",[0,0], [0,0],[100,"Land_TentHangar_V1_F"] ]],
// 4 AI will spawn into the specified building.

 [["RESISTANCE","COMBAT","RED","LINE"],[[3,"Sniper"],[3,"Rifleman"]],[  "TowerGuard",[0,0], [0,0],[150,"ANY"] ]],
// if "ANY" is changed to a specific building type, ex: "Land_Cargo_Tower_V3_F", they will all spawn into this building type.

[["RESISTANCE","COMBAT","RED","LINE"],[[5,"Hunter"]],["Buildings",[6,6],[0,0],[100]]]
// these 5 will patrol in and out of the buildings withn 100m of encounter center.
],
// NOTE: if no buildings are located within 'radius' both 'Buildings'  will locate nearest buildings to the encounter and move there!
// NOTE: See AI_LOGIC.txt for detailed and most current descriptions of AI logic.

//---------------------------------------------------------------------------------
//-----LAND Vehicle Configuration----- 
[
    [  // Emplacement #1 (North)   
   [         // 3rd paramater sets the 'facing' of the static weapon.
        ["O_Mortar_01_F",[5,55],[15],"None"],
        ["B_HMG_01_high_F",[2,55],[330],"None"],
        ["B_static_AT_F",[5,58],[45],"None"]
              
    ],[  // Drivers                                                         # and type  |         Patrol     |    spawn   | dest  |facing
         [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [3, "Driver"]  ],   ["Gunner",[-25,0],[0,0],[0]   ]]
    ],
    [  
     ]
   ],
   
   [  // Emplacement #2  (South)                   
       [         // Vehicle                     Offset         Crew (only 1 type!)   Cargo
          ["B_HMG_01_high_F",[-20,-25],[180],"None"]
      ],
      [                 
          [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["Gunner",[-25,0],[0,0],[0]   ]]       
      ],      
     [      //  Troop behaviour and side options                        # and type of Troops                               Patrol logic |  spawn     |dest |'Patrol' options
     ]
   ] ,
   
   
   [  // Emplacement #3  (East)                  
       [         // Vehicle                     Offset         Crew (only 1 type!)   Cargo
          ["B_HMG_01_high_F",[70,25],[90],"None"]
       ],
       [                 
          [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["Gunner",[-25,0],[0,0],[0]   ]]       
       ],                                                    
      [      //  Troop behaviour and side options                        # and type of Troops                               Patrol logic |  spawn     |dest |'Patrol' options
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
  //  ["NukeDevice",["Paros"]],  //Phase01 <-- as an array a 3dlocation, offset, or town name can be specified for the phase mission's center
  //  "TestMission01Enemy", //Phase02 <-- just a file name, phased mission uses THIS mission's center!
   // "TestPhase3" //Phase03
],
[
    //Airborne Vehicle Configuration
 [  // Division #1
   [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
//     [  "O_Heli_Light_02_unarmed_EPOCH",[0,-1900],[1,"Rifleman"],        "Truck01"      ], 
//     [  "O_Heli_Light_02_unarmed_EPOCH"           ,[0,-1800],[1,"Rifleman"],     "None"      ], 
//     [  "O_Heli_Light_02_unarmed_EPOCH"           ,[0,-1700],[1,"Rifleman"],     "None"      ]
    ],[  
    // Pilots                                                          # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options
//   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1, "Driver"]  ],   ["ParaDrop",[0,-1700],[0,0],["Normal", 200, true,true  ]   ]]
  ],[   
     // Troops : These are distributed across all aircraft in the division. These lines are identical to the lines in the group section.
     //  Troop behaviour and side options                    # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
 //   [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[-70,-1900],[0,0],[0]]],
 //   [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[-70,-1800],[50,0],[50]]],
//    [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[0,-1700],[0,0],[150]]]
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
