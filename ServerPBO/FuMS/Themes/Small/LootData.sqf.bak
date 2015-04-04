//LootData.sqf    - For Simple Epoch Missions =DrSudo=
// Horbin
// 1/8/15
//INPUTS: lootConfig, mission center, mission status.
// Intended as a #include to the Fulcrum Mission System init file.
// This function pulls the applicable data from here, and call the function to create the loot box.
// Note: "RANDOM" in any field will select a random type (BoxType, weapon, magazine, item, backpack, etc)
// Note: Placing a 'variable name' from BaseLoot into an option will direct FillLoot.sqf to select a random item from
//    the list of obtions in the 'variable name'
// Example: [Backpacks_All, 4] will select a random backpack, and place 4 of them in the container
// Example: ["FAK",[1,0,5] ] will add '1' FAK, and an additional '0' to '5' First Aid Kits to the container.
//    see BaseLoot.sqf for more specific 'random' lists you can choose from.
//*********************************************************************************************************
// LOOTDATA is GLOBAL to all mission sets to permit easier management of quantity/richness/type of loot
//   accross all missions and mission themes on the server.
//**********************************************************************************************************
_lootData =
[
    // To add more loot options, copy and paste all lines (including comments) from the 'CloneHunter' code below.
    // Paste the code above the '**** CloneHunter Loot**** line.
  //***********************************
 [
// Loot Option title, and box to be used.  Use of array names is permitted. 
  ["BuildingBox", "Random"],
  [      // All weapons and quantity 
      [Rifle_ALL, 2]
  ],
  [// All magazines and quantity
     [Ammo_ALL, 7]
  ],
  [// All items and quantity
      	[Food_ALL, 7]
  ],
  [// All backpacks and quantity
         [Backpacks_ALL, 1]
  ]
 ],//**********End of loot**********************
 //***********************************
 [
// Loot Option title, and box to be used.  Use of array names is permitted. 
  ["MultiGunBox", "Random"],
  [      // All weapons and quantity 
      [Rifle_ALL, 2]
  ],
  [// All magazines and quantity
     [Ammo_ALL, 7]
  ],
  [// All items and quantity
      	[Food_ALL, 5]
  ],
  [// All backpacks and quantity
    [Backpacks_ALL, 1]
  ]
 ],//**********End of loot**********************
  //***********************************
 [
// Loot Option title, and box to be used.  Use of array names is permitted. 
  ["LMGBox", "Random"],
  [
      // All weapons and quantity 
      [Rifle_ALL, 2]
  ],
  [// All magazines and quantity
     [Ammo_ALL, 7]
  ],
  [// All items and quantity
      	[Food_ALL, 3]
  ],
  [// All backpacks and quantity
    [Backpacks_ALL, 2]
  ]
 ],//**********End of loot**********************   
 //***********************************
 [
// Loot Option title, and box to be used.  Use of array names is permitted. 
  ["SmallGunBox", "Random"],
  [
	// All weapons and quantity 
      [Rifle_ALL, 4]
  ],
  [// All magazines and quantity
     [Ammo_ALL, 2]
  ],
  [// All items and quantity
      	[Food_ALL, 2]
  ],
  [// All backpacks and quantity
    [Backpacks_ALL, 1]
  ]
 ],//**********End of loot**********************
//**************************************************************   
//***********************************
 [
// Loot Option title, and box to be used.  Use of array names is permitted. 
  ["RiflesBox", "Random"],
  [
      // All weapons and quantity 
      [Rifle_ALL, 2]
  ],
  [// All magazines and quantity
     [Ammo_ALL, 7]
  ],
  [// All items and quantity
      	[Food_ALL, 2]
  ],
  [// All backpacks and quantity
      [Backpacks_ALL, 1]
  ]
 ],//**********End of loot**********************
//******************************************************************************
 [
// Loot Option title, and box to be used.  If box = 'VEHICLE' then loot is intended to be placed in a vehicle.
  ["SniperBox","Random"],
  [
  // All weapons and quantity  
  [Rifle_ALL, 3]
  ],
  [// All magazines and quantity
     [Ammo_ALL, 5]
  ],
  [// All items and quantity
      	[Food_ALL, 4]
  ],
  [// All backpacks and quantity
    [Backpacks_ALL, 3]
  ]
 ]  //***********End of Loot************************ 
//**********************************************************************************************************
];

FuMS_LOOTDATA set [_this select 0, _lootData];

