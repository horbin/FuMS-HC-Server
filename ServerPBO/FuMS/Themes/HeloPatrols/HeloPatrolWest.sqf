//TestHeloPatrol.sqf
// Horbin
// 2/14/15
// Be cautious when editing data.

// NOTE: For all Offset values, if three dimensions are used, the point will be treated as an absolute point on the game map.
// Ex: [15,20] is an offset 15m east, 20m north of the encounter center
// Ex: [12100,11000,0] is a specific point on the map.
// absolute 3d locations can be subsituted for any offset within this file!


[[
//------------------------------------------------------------------------------------
//-----Mission Area Setup-----
    "HeloPatrolWest",  // Mission Title NOSPACES!
    200                // encounter radius
],[ 
//------------------------------------------------------------------------------------
//-----Notification Configuration-----
//--Map Marker Config.
    "Test Helo Patrol",  // Name, set to "" for nothing
     "mil_dot", // icon type:                                     https://community.bistudio.com/wiki/cfgMarkers for other options.
                     // mil_triangle, mil_objective, mil_box, group1, loc_Power, etc.
     "ELLIPSE", // "RECTANGLE". do not use "ICON", two markers are used in making each mission indicator.
     "ColorRed",//                                                  https://community.bistudio.com/wiki/setMarkerColor
     "FDiagonal",// Cross, Vertical, Horizontal, etc      https://community.bistudio.com/wiki/setMarkerBrush 
       200           // size of the marker.    
],[[
    // NOTIFICATION Messages and Map display Control.
	true,    // Notify players via Radio Message
    "ALL",   // radio channel. "ALL" = no radio required.
    0,         //range from encounter center AI radio's can be heard (0=unlimited.)
    false,  // Notify players via global message - hint screen on right of game display -
    false,   // Show encounter area on the map
    30,      // Win delay: Time in seconds after a WIN before mission cleanup is performed
    10       // Lose delay: Time in seconds after a lose before mission cleanup is performed
//NOTE: the above delay must finish before the mission is considered 'complete' by the mission manager control loop.
// These two delays will also affect how much time will elapse from mission completion until living AI cleanup.
],[
   // Mission spawn message, DO NOT Remove these! They can be edited down to "" if desired.
     "CORE Directive",  // title line
     "Defense Alert!", 
     "High Command has dispatched a squadron of helicopters to patrol the skys!" //description/radio message.
],[  
    // Mission Success Message
    "Mission Success",  // title line
     "",
     "Notifying High Command that the squadron has been lost!"
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
   "None",[0,0]
   //Array of loot now supported using above syntax.
   // replace "Random" with your desired loot option from LootData.sqf, or leave random for random results!
   // AND don't forget you can use these loot options to fill vehicles with loot too!(see vehicle section below)
],[
    "None" ,        // WIN Loot
    [0,0]                // Offset from mission center x,y, 3 coords [x,y,z] places loot at a specific map location!  
],[
    "None" ,            // Lose Loot.
     [0,0]                // Offset from mission center.
]],
[
//---------------------------------------------------------------------------------
//-----Building Configuration-----       
//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.

],
[
//---------------------------------------------------------------------------------
//-----Group Configuration-----  see Convoy section for AI in vehicles! 
//--- See SoldierData.sqf for AI type options.
],
//---------------------------------------------------------------------------------
//-----LAND Vehicle Configuration----- 
[

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
    //  ["LowUnitCount", "GUER", 0, 0, [0,0]], // all enemies are dead:  side options "EAST","WEST","GUER","CIV","LOGIC","ANY"
     //  ["ProxPlayer", [0,0], 50, 1], // 1 player is within 50 meters of encounter center.
	  // ["Reinforce", 10, "Random"] // %chance when requested, Mission to run
       ["BodyCount", 9] // when at least 10 AI are killed by players
	   // Note Reinforce trigger will not impact win/loss logic.
    ],
    [    //LOSE Triggers and Controls
//      ["HighUnitCount", "GUER",10,40,[0,0]] // 10 enemies get within 40m's of encounter center
           //["Timer",300]  // mission ends after 30 minutes if not completed
		   ["AllDeadorGone"]
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
   // ["NukeDevice",["Paros"]],  //Phase01 <-- as an array a 3dlocation, offset, or town name can be specified for the phase mission's center
   // "TestMission01Enemy", //Phase02 <-- just a file name, phased mission uses THIS mission's center!
   // "TestPhase3" //Phase03
],
[
    //Airborne Vehicle Configuration
 [  // Division #1
   [         // Vehicle                                 Offset     Crew (only 1 type!)   CargoLoot (see Loot section below for more detail!)
     [  "B_Heli_Light_01_armed_F"           ,[0,0],[2,"Rifleman"],        "Truck01"      ],  //U-80 Ghost Hawk
     [  "B_Heli_Light_01_armed_F"           ,[0,-150],[2,"Rifleman"],     "Truck01"      ], //AH-9 Pawnee
     [  "B_Heli_Transport_01_F"               ,[0,-250],[2,"Rifleman"],     "Truck01"      ]   //WY-55 Hellcat
    
    //"B_Heli_Transport_01_F" //U-80 Ghost Hawk
    //"I_Heli_light_03_F" // WY-55 Hellcat
    ],
    [  
    // Pilots                                                          # and type  |         Patrol     |    spawn   | dest  | 'Patrol' options   
       [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [3, "Driver"]  ],   ["PatrolRoute",[0,0],[0,0],["COMBAT","NORMAL",["Panochori","Kavala","Negades","Agios Konstantinos","Oreokastro"],true,false,true,100   ]]]
  ],
  [   
     // Troops : These are distributed across all aircraft in the division. These lines are identical to the lines in the group section.
     //  Troop behaviour and side options                    # and type of Troops     Patrol logic |  spawn     |dest |'Patrol' options
    [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["PatrolRoute",[0,0],[0,0],["COMBAT","NORMAL",["Panochori","Kavala","Negades","Agios Konstantinos","Oreokastro"],true,false,true,100   ]]]
 //   [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[-70,-1800],[50,0],[50]]],
  //  [["RESISTANCE","COMBAT","RED","COLUMN"],[[1,"Sniper"],[6,"Rifleman"]],["BoxPatrol",[0,-1700],[-50,0],[50]]]
   // 'dest' for troops is where they will go to perform their 'Patrol Logic' once they get on deck
     ]
   ]
  ]
];
