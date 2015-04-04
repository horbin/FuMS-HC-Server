//LootData.sqf
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
    
    
//******** CloneHunter Loot****************************
 [
// Loot Option title, and box to be used.  Use of array names is permitted. 
  ["CloneHunter", "box_nato_ammoveh_f"],
  [// All weapons and quantity 
      ["LMG_Mk200_F", 2],
      ["arifle_MXM_Black_F", 2]
  ],
  [// All magazines and quantity
      ["30Rnd_65x39_caseless_mag_Tracer", 4],
      ["200Rnd_65x39_cased_Box_Tracer", 4]
  ],
  [// All items and quantity
      ["NVG_EPOCH", 2],
      ["FAK", 3],
      ["optic_Arco", 2],
      ["ItemKiloHemp", 3],
      ["meatballs_epoch", 2],
      ["HeatPack", 3],
      ["ItemSodaOrangeSherbet", 2] 
  ],
  [// All backpacks and quantity
    [Backpacks_ALL, 1]
  ]
 ],//********** Loot**********************
//**********************************************************************************************************
//************ Generic Truck Loot
 [
// Loot Option title, and box to be used.  If box = 'VEHICLE' then loot is intended to be placed in a vehicle.
  ["Truck01","box_nato_ammo_f"],
  [// All weapons and quantity  
   
  ],
  [// All magazines and quantity
   
  ],
  [// All items and quantity
      ["meatballs_epoch", 5],
	  [Food_Cooked, 3],
      ["ItemSodaOrangeSherbet", [1,2,4]],  // 1 plus a random amount between 2-4 : 3-5 items!
      ["MultiGun",1],
      ["EnergyPackLg",3],
      ["Repair_EPOCH",1],
      ["Defib_EPOCH",1],
      ["Heal_EPOCH",1]
  ],// All backpacks and quantity
  [
    
  ]
 ]  //*********** Loot************************ 
//**********************************************************************************************************
];

FuMS_LOOTDATA set [_this select 0, _lootData];

