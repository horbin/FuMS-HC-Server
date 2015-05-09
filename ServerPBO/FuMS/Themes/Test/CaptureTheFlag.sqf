//CaptureTheFlag.sqf
// Horbin
// 5/8/15
// 

[
["CTF", 200], // Mission Title NOSPACES!, and encounter radius
["CTF","mil_objective","ELLIPSE","ColorRed","FDiagonal",200],    // Map Markers ["MapText", "SHAPE", "COLOR", "FILL", size];
   // type is "mil_objective"
[  
    [// NOTIFICATION Messages and Map display Control.
	false, "ALL",0, // Notify players via Radio Message, radio channel, range from encounter center (0=unlimited.
    false, // Notify players via global message
    false,// Show encounter area on the map
    30,    // Win delay: Time in seconds after a WIN before mission cleanup is performed
    30       // Lose delay: Time in seconds after a lose before mission cleanup is performed
          //NOTE: the above delay must occur before the mission is considered 'complete' by the mission manager control loop.
    ],
    // Spawn Mission Message
["ZCP-FuMS",
    "Capture Point Established",
    "Check your map for the location and claim it for your own!"
],
    
    // Mission Success Message
["",
    "",
    ""
],
  
    // Mission Failure Message
["",
    "",
    ""
] 
],
[  //  Loot Config:  Refer to LootData.sqf for specifcs
["Scatter" , [0,0] ], //[static loot, offset location] - spawns with the mission
["Random" , [5,5] ], // Win loot, offset location - spawns after mission success
["None" , [0,0] ]  // Failure loot, offset location - spawns on mission failure
],
[//BUILDINGS: persist = 0: building deleted at event completion, 1= building remains until server reset.
// ["Land_Device_disassembled_F",[-2,0],0,0],
// ["I_UGV_01_rcws_F",[0,5],0, [.5, 1, .5, .5,.5], "SMOKE_BIG"],

["M3Editor", [0,0], 777, 0,

   // paste your array of building objects here
 [
	["Land_Dam_Conc_20",[7442.48,7118.03,-0.0066452],122,[[0.848048,-0.529919,0],[0,-0,1]],false],
	["Land_Dam_Conc_20",[7431.81,7101.22,0.04673],122,[[0.848048,-0.529919,0],[0,-0,1]],false],
	["Land_Dam_Conc_20",[7421.2,7084.37,0.328979],122,[[0.848048,-0.529919,0],[0,-0,1]],false],
	["Land_Dam_Conc_20",[7400.67,7051.01,0.397835],122,[[0.848048,-0.529919,0],[0,-0,1]],false],
	["Land_Dam_Conc_20",[7390.12,7034.2,0.264999],122,[[0.848048,-0.529919,0],[0,-0,1]],false],
	["Land_Dam_Conc_20",[7380.04,7018.02,0.773911],122,[[0.848048,-0.529919,0],[0,-0,1]],false],
	["Land_Dam_Conc_20",[7379.6,7017.89,0.743492],211.821,[[-0.527267,-0.849699,0],[-0,0,1]],false],
	["Land_Dam_Conc_20",[7363,7028.16,0.559814],211.821,[[-0.527267,-0.849699,0],[-0,0,1]],false],
	["Land_Dam_Conc_20",[7346.19,7038.63,0.344444],211.821,[[-0.527267,-0.849699,0],[-0,0,1]],false],
	["Land_Dam_Conc_20",[7329.27,7049.09,0.337463],211.821,[[-0.527267,-0.849699,0],[-0,0,1]],false],
	["Land_Dam_Conc_20",[7312.77,7059.36,0.315765],211.821,[[-0.527267,-0.849699,0],[-0,0,1]],false],
	["Land_Dam_Conc_20",[7296.07,7069.73,0.424164],211.821,[[-0.527267,-0.849699,0],[-0,0,1]],false],
	["Land_Dam_Conc_20",[7279.36,7080.1,0.231331],211.821,[[-0.527267,-0.849699,0],[-0,0,1]],false],
	["Land_Dam_Conc_20",[7279.24,7080.44,0.0161896],302.004,[[-0.848011,0.529978,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7289.66,7097.11,0.0154114],302.004,[[-0.848011,0.529978,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7299.92,7113.63,-0.0218811],302.004,[[-0.848011,0.529978,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7310.5,7130.46,-0.356277],302.004,[[-0.848011,0.529978,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7320.92,7147.13,-0.449211],302.004,[[-0.848011,0.529978,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7331.34,7163.8,-1.19103],302.004,[[-0.848011,0.529978,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7341.76,7180.48,-1.39223],302.004,[[-0.848011,0.529978,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7342.09,7180.75,-1.39199],31.956,[[0.529268,0.848455,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7358.77,7170.34,-0.847466],31.956,[[0.529268,0.848455,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7375.45,7159.94,-0.176178],31.956,[[0.529268,0.848455,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7392.13,7149.53,0.140335],31.956,[[0.529268,0.848455,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7408.81,7139.13,0.204697],31.956,[[0.529268,0.848455,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7425.5,7128.72,0.122322],31.956,[[0.529268,0.848455,0],[0,0,1]],false],
	["Land_Dam_Conc_20",[7442.15,7118.37,-0.214027],31.956,[[0.529268,0.848455,0],[0,0,1]],false],
	["Land_Helfenburk_budova2",[7403.3,7056.35,-6.86646e-005],302.55,[[-0.842922,0.538035,0],[0,0,1]],false],
	["Land_Helfenburk_budova2",[7416.55,7079.44,-6.86646e-005],302.55,[[-0.842922,0.538035,0],[0,0,1]],false],
	["Land_fort_bagfence_round",[7403.01,7072.85,0],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Hhedgehog_concrete",[7417.75,7063.47,8.39233e-005],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Hhedgehog_concrete",[7415.24,7065.42,-6.86646e-005],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Land_HBarrier_large",[7422.18,7060.93,0],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_RampConcreteHigh_F",[7416.14,7111.54,0.0001297],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7422.92,7113.63,4.42285],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7428.22,7115.24,7.84557],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7433.45,7116.9,11.2683],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7438.74,7118.52,14.691],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7420.05,7112.71,0.0001297],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7426.95,7114.82,0.0001297],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7432.36,7116.47,0.0001297],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7437.77,7118.11,8.42511],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7443.26,7118.34,14.5335],74.1832,[[0.962138,0.272562,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7300.99,7084.98,9.15527e-005],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7294.86,7083.42,-0.107048],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7307.12,7086.56,9.15527e-005],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7293.47,7083.03,4.42281],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7288.18,7081.68,4.29425],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7300.31,7084.74,4.42281],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7293.51,7082.84,8.84554],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7286.94,7081.15,8.95625],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7286.67,7081.06,13.2683],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7282.17,7079.84,16.137],75.6375,[[0.968746,0.248056,0],[0,0,1]],false],
	["Land_RampConcreteHigh_F",[7277.71,7079.24,16.079],257.458,[[-0.976137,-0.217155,0],[-0,0,1]],false],
	["Land_RampConcreteHigh_F",[7431.04,7116.14,4.42285],253.095,[[-0.956788,-0.290786,0],[-0,0,1]],false],
	["Land_Cargo_Tower_V1_No1_F",[7364,7098.37,4.57764e-005],120,[[0.866025,-0.5,0],[0,-0,1]],false],
	["Land_Cargo_Tower_V1_No2_F",[7365.19,7097.3,17.6671],300.366,[[-0.862814,0.505522,0],[0,0,1]],false],
	["Land_A_Castle_Gate",[7414.22,7065.3,0],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Land_A_Castle_Donjon",[7413.39,7066.33,0.994888],27.6368,[[0.850525,-0.525896,0.00630535],[-0.525904,-0.850544,-0.000451133]],false],
	["Land_Molo_drevo_bs",[7418.86,7064.38,15.0055],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_Molo_drevo_bs",[7417.96,7064.94,15.0055],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_Molo_drevo_bs",[7416.17,7066.07,15.0055],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_Molo_drevo_bs",[7415.28,7066.63,15.0055],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_Molo_drevo_bs",[7413.48,7067.76,15.0055],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_Molo_drevo_bs",[7411.74,7068.86,15.0055],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_Molo_drevo_bs",[7410,7069.95,15.0055],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_Molo_drevo_bs",[7408.26,7071.05,15.0055],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_pristresek_camo",[7349.98,7161.76,0.000160217],123.638,[[0.832554,-0.553944,0],[0,-0,1]],false],
	["CampEastC",[7337.41,7147.05,0.000320435],301.096,[[-0.856303,0.516474,0],[0,0,1]],false],
	["CampEmpty",[7346.05,7143.85,-0.000137329],119.275,[[0.872283,-0.489002,0],[0,-0,1]],false],
	["BlackhawkWreck",[7397.81,6986.59,0],0,[[0,1,0],[0,0,1]],false],
	["Fortress2",[7341.62,7154.86,-0.000175476],298.186,[[-0.881419,0.472336,0],[0,0,1]],false],
	["CampEastC",[7333.01,7139.74,0.000312805],301.096,[[-0.856303,0.516474,0],[0,0,1]],false],
	["CampEastC",[7328.6,7132.43,0.000305176],301.096,[[-0.856303,0.516474,0],[0,0,1]],false],
	["CampEmpty",[7342.42,7137.39,-0.000137329],119.275,[[0.872283,-0.489002,0],[0,-0,1]],false],
	["CampEmpty",[7339.24,7131.1,-0.000137329],119.275,[[0.872283,-0.489002,0],[0,-0,1]],false],
	["CampEmpty",[7335.78,7125.34,-0.000137329],119.275,[[0.872283,-0.489002,0],[0,-0,1]],false],
	["Campfire_burning_F",[7323.76,7126.59,0],0,[[0,1,0],[0,0,1]],false],
	["Campfire_burning_F",[7321.68,7123.28,0],0,[[0,1,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[7323.48,7128.39,0],0,[[0,1,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[7324.66,7127.81,0],46.5462,[[0.725929,0.687769,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[7320.39,7123.63,0],285.095,[[-0.965495,0.260421,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[7322.29,7126.27,0],288.095,[[-0.950543,0.310594,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[7325.53,7125.75,-9.15527e-005],107.638,[[0.95299,-0.303002,0],[0,-0,1]],false],
	["Land_CampingChair_V2_F",[7321.57,7124.54,0],0,[[0,1,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[7320.47,7121.95,0],222.549,[[-0.676221,-0.736699,0],[-0,0,1]],false],
	["Land_WoodPile_F",[7318.37,7124.51,-7.62939e-006],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_WoodPile_F",[7319.29,7125.81,0.00012207],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Land_WoodPile_F",[7318.84,7125.16,0],113.456,[[0.917366,-0.398045,0],[0,-0,1]],false],
	["Land_CampingTable_F",[7327.75,7127.86,0],24.7277,[[0.418306,0.908306,0],[0,0,1]],false],
	["TK_GUE_WarfareBUAVterminal_EP1",[7375.31,7036.95,0],0,[[0,1,0],[0,0,1]],false],
	["TK_GUE_WarfareBVehicleServicePoint_EP1",[7366.26,7042.43,-7.62939e-006],37.0005,[[0.601822,0.79863,0],[0,0,1]],false],
	["Land_DieselGroundPowerUnit_01_F",[7380.95,7040.27,4.57764e-005],33.4551,[[0.551283,0.834318,0],[0,0,1]],false],
	["Land_FieldToilet_F",[7309.07,7108.25,0],299.641,[[-0.869141,0.494564,0],[0,0,1]],false],
	["Land_FieldToilet_F",[7309.71,7109.38,-0.00012207],299.641,[[-0.869141,0.494564,0],[0,0,1]],false],
	["Land_FieldToilet_F",[7310.36,7110.52,-0.00012207],299.641,[[-0.869141,0.494564,0],[0,0,1]],false],
	["Land_FieldToilet_F",[7311,7111.65,-0.00012207],299.641,[[-0.869141,0.494564,0],[0,0,1]],false],
	["Land_FieldToilet_F",[7311.65,7112.78,-0.00012207],299.641,[[-0.869141,0.494564,0],[0,0,1]],false],
	["Land_WaterTank_F",[7382.73,7043.1,-7.62939e-006],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_WaterTank_F",[7332.23,7122.28,7.62939e-005],30.546,[[0.50823,0.861221,0],[0,0,1]],false],
	["Land_WaterTank_F",[7334.38,7121.01,7.62939e-005],30.546,[[0.50823,0.861221,0],[0,0,1]],false],
	["Land_WaterTank_F",[7333.64,7119.75,7.62939e-005],30.546,[[0.50823,0.861221,0],[0,0,1]],false],
	["Land_WaterTank_F",[7331.48,7121.02,7.62939e-005],30.546,[[0.50823,0.861221,0],[0,0,1]],false],
	["Land_Grave_V1_F",[7343.45,7054.24,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7345.31,7057.54,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7343.31,7058.67,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7341.31,7059.8,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7339.31,7060.93,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7337.31,7062.06,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7335.31,7063.19,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7333.45,7059.89,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7335.45,7058.76,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7337.45,7057.63,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_V1_F",[7341.45,7055.37,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_Grave_monument_F",[7342.15,7063.55,0],30.4548,[[0.506859,0.862029,0],[0,0,1]],false],
	["Land_GarbageContainer_closed_F",[7312.69,7114.19,3.05176e-005],117.82,[[0.884418,-0.466696,0],[0,-0,1]],false],
	["Land_GarbageContainer_closed_F",[7313.53,7115.79,3.05176e-005],117.82,[[0.884418,-0.466696,0],[0,-0,1]],false],
	["Land_GarbageContainer_closed_F",[7314.38,7117.39,3.05176e-005],117.82,[[0.884418,-0.466696,0],[0,-0,1]],false],
	["Land_LampDecor_F",[7337.35,7066.12,0],0,[[0,1,0],[0,0,1]],false],
	["Land_LampDecor_F",[7346.96,7060.54,-2.28882e-005],0,[[0,1,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7376.86,7032.2,-0.000167847],75.6376,[[0.968746,0.248054,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7298.11,7089.5,0],173.094,[[0.120241,-0.992745,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7347.84,7152.48,0],269.095,[[-0.999875,-0.0157941,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7303.84,7101.46,1.52588e-005],212.367,[[-0.535341,-0.844636,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7311.32,7114.4,3.8147e-005],212.367,[[-0.535341,-0.844636,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7319.25,7127.03,3.8147e-005],213.822,[[-0.556615,-0.830771,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7326.49,7138.73,-1.52588e-005],210.912,[[-0.513721,-0.857957,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7330.68,7146.13,-0.000343323],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7335.18,7153,3.8147e-005],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["76n6ClamShell",[7373.64,7132.38,-6.10352e-005],250.185,[[-0.940792,-0.338984,0],[-0,0,1]],false],
	["PowGen_Big",[7329.32,7115.38,0],33.4551,[[0.551283,0.834318,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7303.26,7078.56,7.62939e-005],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7316.41,7068.98,7.62939e-005],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7331.06,7060.14,7.62939e-005],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7344.65,7051.57,7.62939e-005],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7358.95,7042.25,7.62939e-005],120.729,[[0.859594,-0.510978,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7384.72,7046.53,0.000137329],30.5459,[[0.508228,0.861222,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7393.15,7060.82,0.000137329],30.5459,[[0.508228,0.861222,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7395.24,7077.37,0.000114441],210.912,[[-0.513721,-0.857957,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7413.12,7090.78,0.000137329],30.5459,[[0.508228,0.861222,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7422.25,7104.67,0.000137329],30.5459,[[0.508228,0.861222,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7416.18,7121.63,0.0001297],298.186,[[-0.881419,0.472336,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7403.07,7130.8,0.0001297],298.186,[[-0.881419,0.472336,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7389.76,7139.43,0.0001297],298.186,[[-0.881419,0.472336,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7376.69,7147.95,0.0001297],298.186,[[-0.881419,0.472336,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7364.39,7155.76,0.0001297],298.186,[[-0.881419,0.472336,0],[0,0,1]],false],
	["Land_Loudspeakers_F",[7362.11,7128.57,0],0,[[0,1,0],[0,0,1]],false],
	["Land_Loudspeakers_F",[7372.56,7059.77,0],0,[[0,1,0],[0,0,1]],false],
	["CamoNet_INDP_big_Curator_F",[7371.85,7040.34,0],0,[[0,1,0],[0,0,1]],false],
	["Land_Cargo_Patrol_V1_F",[7448.88,7119.73,16.4832],257.459,[[-0.976141,-0.217138,0],[-0,0,1]],false],
	["Land_Cargo_Patrol_V1_F",[7272.45,7078.75,16.4832],78.5472,[[0.980089,0.19856,0],[0,0,1]],false],
	["Land_Cargo_Patrol_V1_F",[7381.44,7011.02,17.4795],349.097,[[-0.189147,0.981949,0],[0,0,1]],false],
	["Land_Cargo_Patrol_V1_F",[7340.37,7187.42,14.5428],160.003,[[0.341971,-0.939711,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7273.72,7072.86,15.0037],302.823,[[-0.840349,0.542046,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7291.77,7062.13,15.0037],302.823,[[-0.840349,0.542046,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7310.34,7050.68,15.0037],302.823,[[-0.840349,0.542046,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7328.49,7039.27,15.0037],302.823,[[-0.840349,0.542046,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7347.71,7027.16,15.0037],302.823,[[-0.840349,0.542046,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7365.56,7016.84,15.0037],302.823,[[-0.840349,0.542046,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7386.72,7011.75,15.0037],212.185,[[-0.532655,-0.846332,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7398.22,7030.02,15.0037],212.185,[[-0.532655,-0.846332,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7409.72,7048.29,15.0037],212.185,[[-0.532655,-0.846332,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7421.22,7066.57,15.0037],212.185,[[-0.532655,-0.846332,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7432.44,7085.37,15.0037],212.185,[[-0.532655,-0.846332,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7443.76,7103.41,15.0037],212.185,[[-0.532655,-0.846332,0],[-0,0,1]],false],
	["Land_LampHalogen_F",[7446.47,7126.38,15.0038],120.547,[[0.861212,-0.508245,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7426.15,7138.37,15.0038],120.547,[[0.861212,-0.508245,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7406.24,7151.17,15.0038],120.547,[[0.861212,-0.508245,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7386.08,7163.72,15.0038],120.547,[[0.861212,-0.508245,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7366.26,7175.7,15.0038],120.547,[[0.861212,-0.508245,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7346.22,7189.35,15.0038],120.547,[[0.861212,-0.508245,0],[0,-0,1]],false],
	["Land_LampHalogen_F",[7334.91,7186.54,15.0038],31.8184,[[0.527229,0.849724,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7322.47,7166.5,15.0038],31.8184,[[0.527229,0.849724,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7310.04,7146.45,15.0038],31.8184,[[0.527229,0.849724,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7297.6,7126.41,15.0038],31.8184,[[0.527229,0.849724,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7285.16,7106.36,15.0038],31.8184,[[0.527229,0.849724,0],[0,0,1]],false],
	["Land_LampHalogen_F",[7272.72,7086.32,15.0038],31.8184,[[0.527229,0.849724,0],[0,0,1]],false],
	["CamoNet_BLUFOR_open_Curator_F",[7325.19,7129.78,0],0,[[0,1,0],[0,0,1]],false],
	["Land_u_Barracks_V2_F",[7356.56,7130.97,-2.28882e-005],302.55,[[-0.842922,0.538035,0],[0,0,1]],false],
	["Land_BagBunker_Tower_F",[7385.68,7073.83,0],286.55,[[-0.958571,0.284852,0],[0,0,1]],false],
	["Land_BagBunker_Tower_F",[7395.11,7088.91,-4.57764e-005],325.824,[[-0.561737,0.827316,0],[0,0,1]],false],
	["Land_ReservoirTank_V1_F",[7341.91,7109.11,0],0,[[0,1,0],[0,0,1]],false],
	["Land_Garaz_s_tankem",[7322.61,7073.57,-2.28882e-005],212.367,[[-0.535341,-0.844636,0],[-0,0,1]],false],
	["Land_Garaz_s_tankem",[7337.9,7098.17,-1.52588e-005],32.0005,[[0.529926,0.848044,0],[0,0,1]],false],
	["Land_Chapel_Small_V2_F",[7351.51,7054.33,3.05176e-005],123.638,[[0.832554,-0.553944,0],[0,-0,1]],false],
	["Land_Tribune_F",[7377.69,7123.17,0.000160217],34.9097,[[0.572285,0.820055,0],[0,0,1]],false],
	["Land_GymRack_03_F",[7385.6,7117.75,0],0,[[0,1,0],[0,0,1]],false],
	["Land_GymRack_02_F",[7387.3,7121.17,0],0,[[0,1,0],[0,0,1]],false],
	["Land_GymRack_01_F",[7384.02,7121.27,0],0,[[0,1,0],[0,0,1]],false],
	["Land_GymBench_01_F",[7382.4,7118.15,0],0,[[0,1,0],[0,0,1]],false],
	["Land_BC_Court_F",[7371.73,7113.71,1.52588e-005],125.093,[[0.81822,-0.574906,0],[0,-0,1]],false],
	["Land_BC_Basket_F",[7382.65,7105.81,1.52588e-005],306.914,[[-0.799538,0.600616,0],[0,0,1]],false],
	["Land_BC_Basket_F",[7360.9,7121.16,-8.39233e-005],126.002,[[0.808996,-0.587814,0],[0,-0,1]],false],
	["Land_PartyTent_01_F",[7386.95,7118.83,-9.91821e-005],36.3642,[[0.592916,0.805264,0],[0,0,1]],false],
	["US_WarfareBFieldhHospital_EP1",[7366.21,7068.28,0],299.641,[[-0.869141,0.494564,0],[0,0,1]],false],
	["Heli_H_rescue",[7348.75,7076.97,0],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7338.01,7036.96,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7320.49,7047.84,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7357.77,7024.25,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7299.93,7060.58,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7293.19,7113.58,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7305.79,7133.73,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7392.58,7154.15,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7413.65,7141.34,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7372.34,7166.6,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7318.41,7153.91,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7422.55,7078.11,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7400.39,7042.13,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Lampa_sidl_3",[7410.71,7062.82,15.2559],0,[[0,1,0],[0,0,1]],false],
	["Land_Grave_V1_F",[7339.45,7056.5,0.000152588],209.458,[[-0.491786,-0.870716,0],[-0,0,1]],false],
	["Land_ScrapHeap_1_F",[7345.41,7161.3,0],125.093,[[0.818221,-0.574903,0],[0,-0,1]],false],
	["Land_ScrapHeap_2_F",[7351.81,7162.49,0.00038147],122.184,[[0.846342,-0.53264,0],[0,-0,1]],false],
	["Land_Scrap_MRAP_01_F",[7358.48,7158.49,0],304.277,[[-0.826324,0.563195,0],[0,0,1]],false],
	["Misc_cargo_cont_net3",[7360.05,7145.04,0.000267029],308.368,[[-0.78404,0.620711,0],[0,0,1]],false],
	["Land_Wreck_Heli_Attack_01_F",[7437.54,6985.9,0],0,[[0,1,0],[0,0,1]],false],
	["C130J_wreck_EP1",[7467.01,7038.21,0],0,[[0,1,0],[0,0,1]],false],
	["Land_Wreck_Heli_Attack_01_F",[7276.35,6983.57,0],0,[[0,1,0],[0,0,1]],false],
	["Mi8Wreck",[7242.05,7152.06,0],0,[[0,1,0],[0,0,1]],false],
	["Land_Wreck_HMMWV_F",[7407.42,7240.23,0],0,[[0,1,0],[0,0,1]],false]
]





]

	// Vehicle Name  | offset | rotation | Fuel, Ammo, DmgEngine, Dmg FuelTank, DmgHull
//	["I_UGV_01_rcws_F",[0,100],   0,       [.5,   1,     .5,         .5,         .5]],
//    ["Land_Wreck_Car2_F",[0,50],0, [.5, 1, .5, .5], "Fire"]

],
[ // AI GROUPS. Only options marked 'Def:' implemented.
//   [["RESISTANCE","COMBAT","RED","COLUMN"],   [  [1,"Sniper"],[2,"Rifleman"],[2,"Hunter"]  ],   ["BoxPatrol",[0,75],[0,0],[0]   ]],
    [["RESISTANCE","COMBAT","RED","LINE"],   [  [3,"Diver"]                                         ],   ["BoxPatrol",[0,0],[0,0],[70] ]]
//[["ZOMBIE","CARELESS","RED","LINE"],   [  [10,"Zombie"]           ],     ["Zombie",[0,0],[0,0],[]     ]],
//[["RESISTANCE","COMBAT","RED","LINE"],[[3,"RaptorM"]],["Buildings",[0,0],[0,0],[70] ]], // 3 rifleman that will patrol all buildings within 70m for unlimited duration
// **End 'copy'******(see Patrol Options below for other AI behaviour)
// Example of a 3D map location. This loc is specific to ALTIS
//[["RESISTANCE","COMBAT","RED","LINE"],[[5,"RaptorF"]],["BoxPatrol",[0,0],[0,0],[70] ]]
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
     // ["LowUnitCount", "EAST", 0, 0, [0,0]], // all enemies are dead:  side options "EAST","WEST","GUER","CIV","LOGIC","ANY"
      //["ProxPlayer", [0,0], 20, 1], // 1 player is within 20 meters of encounter center.
	//  ["Reinforce", 100, "Random"] // %chance when requested, Mission to run
    //  ["BodyCount",1]
	                //[offset], radius, time, name
["ZupaCapture",[  [ [0,0],      50,     180,  "Point 1" ],
                  [ [100,100],  50,     180,  "Point 2" ]			  ]]
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
