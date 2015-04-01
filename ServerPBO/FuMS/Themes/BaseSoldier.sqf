//BaseSoldier.sqf
// Horbin
// 1/10/15
// For use in customizing AI in Fulcrum Mission System.
// NOTE: If you create any of your own custom 'Arrays', make sure the name of the array is also included in the
//     : ListofVar names list at the bottom of this file.
// NOTE: If you do not include the name, the HC will never learn of the new variable's data!!!

#include "BaseLoot.sqf";

Outfit_Military = ["U_O_CombatUniform_ocamo","U_O_PilotCoveralls","U_OG_Guerilla1_1","U_OG_Guerilla2_1",
"U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader"];
Outfit_WetSuit = ["U_O_Wetsuit","U_Wetsuit_uniform","U_Wetsuit_White","U_Wetsuit_Blue","U_Wetsuit_Purp","U_Wetsuit_Camo"];
Outfit_Civilian = ["U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon",
"U_C_Poloshirt_redwhite","U_C_Poor_1","U_C_WorkerCoveralls","U_C_Journalist","U_C_Scientist","U_OrestesBody"];
Outfit_Ghillie = ["U_O_GhillieSuit","U_ghillie2_uniform","U_ghillie3_uniform"];

Outfit_Female = ["U_CamoRed_uniform","U_CamoBrn_uniform","U_CamoBlue_uniform","U_Camo_uniform"];
Outfit_Any = Outfit_Military + Outfit_Civilian + Outfit_Female + Outfit_Ghillie;
Outfit_AnyMilitary = Outfit_Military + Outfit_Female;

// ECH's
Helmet_ECH = ["H_2_EPOCH","H_1_EPOCH","H_3_EPOCH","H_4_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH",
"H_9_EPOCH","H_10_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH"];
Helmet_Combat = ["H_5_EPOCH","H_12_EPOCH","H_13_EPOCH"];
Helmet_SF = ["H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH"];
Helmet_Mich = ["H_23_EPOCH","H_24_EPOCH","H_25_EPOCH"];
Helmet_Crew = ["H_26_EPOCH","H_27_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH"];
Helmet_Pilot =["H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_32_EPOCH","H_33_EPOCH","H_35_EPOCH"];
Hat_Military = ["H_61_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_104_EPOCH"];
Helmet_Military = Helmet_ECH + Helmet_Combat + Helmet_SF + Helmet_Mich + Hat_Military;
Helmet_Aviator = Helmet_Crew + Helmet_Pilot;
Helmet_Any = Helmet_Military + Helmet_Aviator;

Hat_Boonie = ["H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH"];
Hat_Ballcap = ["H_47_EPOCH","H_47_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH",
"H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH"];
Hat_Bandanna = ["H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH"];
Hat_Brimmed = ["H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH"];
Hat_Binnie = ["H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH"];
Hat_Civilian = Hat_Boonie + Hat_Ballcap + Hat_Bandanna + Hat_Brimmed + Hat_Binnie;

Helmet_Racing = ["H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH"];
Hat_Other = ["H_70_EPOCH","wolf_mask_epoch","pkin_mask_epoch"];
// reserve Beret's for special targets
Hat_Beret = ["H_11_EPOCH","H_28_EPOCH","H_34_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH"];

Vest_Bandolier=["V_1_EPOCH","V_2_EPOCH","V_3_EPOCH","V_4_EPOCH","V_5_EPOCH","V_21_EPOCH"];
Vest_Carrier=["V_6_EPOCH","V_7_EPOCH","V_8_EPOCH","V_9_EPOCH","V_22_EPOCH","V_23_EPOCH"];
Vest_ChestRig=["V_10_EPOCH","V_11_EPOCH","V_12_EPOCH","V_24_EPOCH"];
Vest_Tactical=["V_13_EPOCH","V_14_EPOCH","V_15_EPOCH","V_16_EPOCH","V_25_EPOCH","V_26_EPOCH","V_26_EPOCH"];
Vest_LBV=["V_17_EPOCH","V_18_EPOCH","V_29_EPOCH","V_30_EPOCH","V_31_EPOCH","V_32_EPOCH"];
Vest_Rebreather=["V_19_EPOCH","V_20_EPOCH","V_36_EPOCH"];
Vest_Any = Vest_Bandolier + Vest_Carrier + Vest_ChestRig + Vest_Tactical + Vest_LBV + Vest_Rebreather;

RifleSniperPairs = [
    ["srifle_EBR_F","20Rnd_762x51_Mag"],     
    ["srifle_GM6_F", "5Rnd_127x108_Mag"],
    ["srifle_LRR_F","7Rnd_408_Mag"],
    ["srifle_DMR_01_F", "10Rnd_762x51_Mag"],		
    ["m107Tan_EPOCH","5Rnd_127x108_Mag"],
    ["m107_EPOCH","5Rnd_127x108_Mag"],
    ["M14_EPOCH","20Rnd_762x51_Mag"],
    ["M14Grn_EPOCH","20Rnd_762x51_Mag"],
	["arifle_MXM_F","30Rnd_65x39_caseless_mag_Tracer"],
	["arifle_MXM_Black_F","30Rnd_65x39_caseless_mag_Tracer"]
];
RifleLMGPairs = [
    ["LMG_Mk200_F","200Rnd_65x39_cased_Box_Tracer"],
    ["LMG_Zafir_F","150Rnd_762x51_Box_Tracer"],
    ["m249_EPOCH","200Rnd_556x45_M249"],
    ["m249Tan_EPOCH","200Rnd_556x45_M249"],
	["arifle_MX_SW_F","100Rnd_65x39_caseless_mag_Tracer"],
	["arifle_MX_SW_Black_F","100Rnd_65x39_caseless_mag_Tracer"]
];

RifleAssaultPairs = [
    ["arifle_Katiba_F","30Rnd_65x39_caseless_green"],
    ["arifle_Katiba_C_F","30Rnd_65x39_caseless_green"],
    ["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green"],
    ["arifle_MXC_F","30Rnd_65x39_caseless_mag_Tracer"],
    ["arifle_MX_F","30Rnd_65x39_caseless_mag_Tracer"],
    ["arifle_MX_GL_F","30Rnd_65x39_caseless_mag_Tracer"],
    ["arifle_TRG21_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_TRG20_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_TRG21_GL_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_Mk20_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_Mk20C_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_Mk20_GL_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_Mk20_plain_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_Mk20C_plain_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_Mk20_GL_plain_F","30Rnd_556x45_Stanag_Tracer_Green"],
    ["arifle_MX_GL_Black_F","30Rnd_65x39_caseless_mag_Tracer"],
    ["arifle_MX_Black_F","30Rnd_65x39_caseless_mag_Tracer"],
    ["arifle_MXC_Black_F","30Rnd_65x39_caseless_mag_Tracer"],
    ["m16_EPOCH","30Rnd_556x45_Stanag_Tracer_Green"],
    ["m16Red_EPOCH","30Rnd_556x45_Stanag_Tracer_Green"],
    ["m4a3_EPOCH","30Rnd_556x45_Stanag_Tracer_Green"],
    ["AKM_EPOCH","30Rnd_762x39_Mag"]
];
RifleOtherPairs = [
    ["SMG_01_F","30Rnd_45ACP_Mag_SMG_01_Tracer_Green"],
    ["SMG_02_F","30Rnd_9x21_Mag"],
    ["Rollins_F","5Rnd_rollins_mag"]
];
RifleWaterPairs = [
    ["speargun_epoch","spear_magazine"],
    ["arifle_SDAR_F","20Rnd_556x45_UW_mag"]
];
PistolPairs = [
    ["hgun_ACPC2_F","9Rnd_45ACP_Mag"],
    ["hgun_Rook40_F","16Rnd_9x21_Mag" ],
    ["hgun_P07_F","16Rnd_9x21_Mag"],
    ["hgun_Pistol_heavy_01_F","11Rnd_45ACP_Mag"],
    ["hgun_Pistol_heavy_02_F","6Rnd_45ACP_Cylinder"],
    ["ruger_pistol_epoch","10rnd_22X44_magazine"],
    ["1911_pistol_epoch","9rnd_45X88_magazine"],
    ["hgun_Pistol_Signal_F","6Rnd_GreenSignal_F"],
    ["hgun_PDW2000_F","30Rnd_9x21_Mag"]
];

//This array used by AttachMuzzle to locate proper attachment, based upon the AI's gun.
Muzzles =[
["muzzle_snds_H",RifleSniper65+RifleLMG65+RifleAssault65], // 6.5mm
["muzzle_snds_M",Rifle556Lnchr+RifleAssault556], // 556mm
["muzzle_snds_B",RifleSniper762+RifleAssault762], // 7.62mm
["muzzle_snds_H_MG",RifleLMG65], // 6.5 LMG
["muzzle_snds_L",["hgun_PDW2000_F","hgun_P07_F","hgun_Rook40_F"]],// 9mm
["muzzle_snds_acp",["hgun_ACPC2_F","hgun_Pistol_heavy_01_F","1911_pistol_epoch"]] // 45 cal
];

//Push data to the HC
// NOTE: If you create any of your own custom 'Arrays', make sure the name of the array is also included in the list below.
// NOTE: If you do not include the name, the HC will never learn of the new variable's data!!!
FuMS_ListofGlobalItems =
[
"Backpacks_Assault","Backpacks_Carryall","Backpacks_Field","Backpacks_Kit",
"Backpacks_Tactical","Backpacks_Small","Backpacks_Other","Backpacks_All","Explosives","Gems","RareMetal","Medical",
"Food_Canned","Food_Other","Food_Cooked","Food_Craft","Food_Fish","Food_All","Drink","OtherItems","BuildingKits",
"BuildingComponents","CraftingTools","CraftingComponents","Grenades_Hand","Grenades_Smoke","Grenades_Light",
"Grenades_ALL","Shell_Smokes","Shell_Flares","Shell_Grenade","Shell_ALL","Radios","BeltItems","Ammo762",
"Ammo127","Ammo65","Ammo556","AmmoOther","AmmoHandGun","Ammo_ALL","RifleSniper762","RifleSniper127",
"RifleSniper408","RifleSniper65","RifleLMG762","RifleLMG65","RifleLMG556","Rifle65Lnchr","Rifle556Lnchr",
"RifleAssault762","RifleAssault65","RifleAssault556","RifleSniper","RifleLMG","RifleLnchr","RifleAssault",
"Rifle_ALL","Pistols","WeaponAttachments_Optics","WeaponAttachments_Muzzle","WeaponAttachments_Other"
];


FuMS_ListofGlobalGear =
[
"Outfit_Military","Outfit_WetSuit","Outfit_Civilian","Outfit_Ghillie","Outfit_Female","Outfit_Any",
"Outfit_AnyMilitary","Helmet_ECH","Helmet_Combat","Helmet_SF","Helmet_Mich","Helmet_Crew",
"Helmet_Pilot","Hat_Military","Helmet_Military","Helmet_Aviator","Helmet_Any","Hat_Boonie",
"Hat_Ballcap","Hat_Bandanna","Hat_Brimmed","Hat_Binnie","Hat_Civilian","Helmet_Racing",
"Hat_Other","Hat_Beret","Vest_Bandolier","Vest_Carrier","Vest_ChestRig","Vest_Tactical",
"Vest_LBV","Vest_Rebreather","Vest_Any","RifleSniperPairs","RifleLMGPairs",
"RifleAssaultPairs","RifleOtherPairs","RifleWaterPairs","PistolPairs","Muzzles"
];

    