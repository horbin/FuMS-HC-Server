// BaseLoot.sqf
// Horbin
// 1/9/15
// Inputs: None
// This is a #include found in FuMsnInit.sqf and defines global arrays related to encounter loot.
//  see LootData.sqf for configuration of actual loot produced at encounters.
//private ["_hc","_ListofVarNames"];
//_hc = _this select 0;
//NOTE: Do not use box_ind_ammoveh_f as a loot option if you use InfiStar's admin tools.

Backpacks_Assault = ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr",
"B_AssaultPack_sgg"];
Backpacks_Carryall = ["B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_oucamo"];
Backpacks_Field = ["B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oli","B_FieldPack_oucamo"];
Backpacks_Kit = ["B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_rgr","B_Kitbag_sgg"];
Backpacks_Tactical = ["B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"];
Backpacks_Small = ["smallbackpack_red_epoch","smallbackpack_green_epoch","smallbackpack_teal_epoch","smallbackpack_pink_epoch"];
Backpacks_Other=["B_Parachute"];
Backpacks_All = Backpacks_Carryall+Backpacks_Field+Backpacks_Kit+Backpacks_Tactical+Backpacks_Small;

Explosives = ["DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSMine_Range_Mag",
"APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag"];
Paint = ["PaintCanBlk","PaintCanBlu","PaintCanBrn","PaintCanGrn","PaintCanOra","PaintCanPur","PaintCanRed","PaintCanTeal","PaintCanYel"];
Gems = ["ItemTopaz","ItemOnyx","ItemSapphire","ItemAmethyst","ItemEmerald","ItemCitrine","ItemRuby","ItemQuartz","ItemJade","ItemGarnet"];
RareMetal = ["PartOreGold","PartOreSilver","ItemGoldBar","ItemSilverBar","ItemGoldBar10oz"];
Medical = ["FAK","Towelette","HeatPack","ColdPack"];
Food_Canned = ["FoodBioMeat","FoodWalkNSons","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch"];
Food_Other =["FoodMeeps","FoodSnooter","honey_epoch"];
Food_Cooked=["CookedSheep_EPOCH","CookedGoat_EPOCH","SnakeMeat_EPOCH","CookedRabbit_EPOCH","CookedChicken_EPOCH"];
Food_Craft=["SnakeCarcass_EPOCH","RabbitCarcass_EPOCH","ChickenCarcass_EPOCH","GoatCarcass_EPOCH","SheepCarcass_EPOCH"];
Food_Fish =["ItemTrout","ItemSeaBass","ItemTuna"];
Food_All = Food_Canned+Food_Other+Food_Cooked+Food_Fish+Food_Craft;
Drink = ["WhiskeyNoodle","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","ItemSodaRbull"];
OtherItems=["ItemLockbox","ItemDocument","lighter_epoch"];
BuildingKits = ["KitStudWall","KitWoodFloor","KitWoodStairs","KitWoodRamp","KitFirePlace","KitTiPi","KitShelf","KitFoundation",
"JackKit","KitPlotPole","KitCinderWall"];
BuildingComponents = ["CinderBlocks","MortarBucket","ItemScraps","ItemCorrugated","ItemCorrugatedLg","PartPlankPack","WoodLog_EPOCH"];
CraftingTools = ["ChainSaw","ItemCoolerE","VehicleRepairLg","Hatchet","MultiGun","MeleeSledge"];
CraftingComponents=["CircuitParts","VehicleRepair","ItemMixOil","emptyjar_epoch","jerrycan_epoch","EnergyPack","EnergyPackLg","Heal_EPOCH",
"Defib_EPOCH","Repair_EPOCH","Pelt_EPOCH","Venom_EPOCH","PartOre","ItemKiloHemp"];
 
 
Grenades_Hand = ["HandGrenade_Stone","HandGrenade","MiniGrenade"];
Grenades_Smoke = ["SmokeShell","SmokeShellYellow","SmokeShellGreen","SmokeShellRed","SmokeShellPurple","SmokeShellOrange","SmokeShellBlue"];
Grenades_Light = ["Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"];
Grenades_ALL = Grenades_Hand+Grenades_Smoke+Grenades_Light;

Shell_Smokes = ["1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell",
"1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","3Rnd_Smoke_Grenade_shell",
"3Rnd_SmokeRed_Grenade_shell","3Rnd_SmokeGreen_Grenade_shell","3Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokePurple_Grenade_shell",
"3Rnd_SmokeBlue_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell"];
Shell_Flares = ["UGL_FlareWhite_F","UGL_FlareGreen_F","UGL_FlareRed_F","UGL_FlareYellow_F","UGL_FlareCIR_F","3Rnd_UGL_FlareWhite_F",
"3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareYellow_F","3Rnd_UGL_FlareCIR_F"];
Shell_Grenade = ["3Rnd_HE_Grenade_shell"];
Shell_ALL = Shell_Smokes+Shell_Flares + Shell_Grenade;

Radios = ["EpochRadio0","EpochRadio1","EpochRadio2","EpochRadio3","EpochRadio4","EpochRadio5","EpochRadio6","EpochRadio7",
"EpochRadio8","EpochRadio9"];

BeltItems =["ItemCompass","ItemGPS","ItemWatch","Binocular","NVG_EPOCH","Rangefinder","Laserdesignator"];

Ammo762 = ["20Rnd_762x51_Mag","10Rnd_762x51_Mag","30Rnd_762x39_Mag","150Rnd_762x51_Box","150Rnd_762x51_Box_Tracer"];
Ammo127 = ["5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag"];
Ammo65 = ["30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer",
"200Rnd_65x39_cased_Box","100Rnd_65x39_caseless_mag","200Rnd_65x39_cased_Box_Tracer","100Rnd_65x39_caseless_mag_Tracer"];
Ammo556 = ["20Rnd_556x45_UW_mag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Green",
"30Rnd_556x45_Stanag_Tracer_Yellow","200Rnd_556x45_M249"];
AmmoOther = ["7Rnd_408_Mag","spear_magazine","5Rnd_rollins_mag"];
AmmoHandGun = ["30Rnd_45ACP_Mag_SMG_01","30Rnd_45ACP_Mag_SMG_01_Tracer_Green","9Rnd_45ACP_Mag","11Rnd_45ACP_Mag","6Rnd_45ACP_Cylinder",
"16Rnd_9x21_Mag","30Rnd_9x21_Mag","10rnd_22X44_magazine","9rnd_45X88_magazine","6Rnd_GreenSignal_F","6Rnd_RedSignal_F"];
Ammo_ALL = Ammo762+Ammo127+Ammo65+Ammo556+AmmoOther+AmmoHandGun;

RifleSniper762 = ["srifle_EBR_F","srifle_DMR_01_F","M14_EPOCH","M14Grn_EPOCH"];//"10Rnd_762x51_Mag"
RifleSniper127 = ["srifle_GM6_F","m107Tan_EPOCH","m107_EPOCH"];///"10Rnd_762x51_Mag"
RifleSniper408 = ["srifle_LRR_F"];//"7Rnd_408_Mag"
RifleSniper65 = ["arifle_MXM_F","arifle_MXM_Black_F"];//"30Rnd_65x39_caseless_green_mag_Tracer"

RifleLMG762 = ["LMG_Zafir_F"];//"200Rnd_65x39_cased_Box_Tracer"
RifleLMG65 = ["LMG_Mk200_F","arifle_MX_SW_F","arifle_MX_SW_Black_F"];//"200Rnd_65x39_cased_Box_Tracer"
RifleLMG556 = ["m249_EPOCH","m249Tan_EPOCH"];//"100Rnd_65x39_caseless_mag_Tracer"

Rifle65Lnchr = [ "arifle_Katiba_GL_F","arifle_MX_GL_F","arifle_MX_GL_Black_F"];//"30Rnd_65x39_caseless_green_mag_Tracer"
Rifle556Lnchr = ["arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_TRG21_GL_F"];//"30Rnd_556x45_Stanag_Tracer_Green"
RifleAssault762 = ["AKM_EPOCH"];//"30Rnd_762x39_Mag"
RifleAssault65 = ["arifle_Katiba_C_F","arifle_Katiba_F","arifle_MXC_F","arifle_MX_F","arifle_MX_Black_F",
"arifle_MXC_Black_F"];//"30Rnd_65x39_caseless_green"
RifleAssault556 = ["arifle_TRG21_F","arifle_TRG20_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F",
"arifle_Mk20C_F","arifle_Mk20_F","m16_EPOCH","m16Red_EPOCH","m4a3_EPOCH"];//"30Rnd_556x45_Stanag_Tracer_Green"

RifleSniper = RifleSniper762 + RifleSniper127 + RifleSniper408 + RifleSniper65;
RifleLMG = RifleLMG762 + RifleLMG65 + RifleLMG556;
RifleLnchr = Rifle65Lnchr + Rifle556Lnchr;
RifleAssault = RifleAssault762 + RifleAssault65+RifleAssault556+RifleLnchr;
Rifle_ALL = RifleSniper + RifleLMG+ RifleAssault;
Pistols = ["hgun_PDW2000_F","hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","ruger_pistol_epoch",
"1911_pistol_epoch","hgun_Pistol_Signal_F"];

WeaponAttachments_Optics =["optic_Arco","optic_Hamr","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg",
"optic_Holosight","optic_Holosight_smg","optic_SOS","optic_MRCO","optic_DMS","optic_Yorris","optic_MRD","optic_LRPS",
"optic_NVS","optic_Nightstalker","optic_tws","optic_tws_mg"];

WeaponAttachments_Muzzle =[
"muzzle_snds_H", // 6.5mm
"muzzle_snds_L",// 9mm
"muzzle_snds_M", // 556mm
"muzzle_snds_B", // 7.62mm
"muzzle_snds_H_MG", // 6.5 LMG
"muzzle_snds_acp"]; // 45 cal
WeaponAttachments_Other = ["acc_flashlight","acc_pointer_IR"];



