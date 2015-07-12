#Fulcrum Mission System (FuMS)
(like the mod? please feel free to donate.  http://conroh.com/fums/
------------------------------------------------------------------------------------
v2.1
* Fixed slow helo's. All helo's now spawn and fly at proper speeds.

* Vehicle stuck logic enhanced.

* Fixed data entry error in the 'Aquatic' theme that was causing frogmen to be on side 'EAST' instead of 'RESISTANCE'
(no wonder they wouldn't shoot at you!!!!!!!)

*UAV and UGV mission support
UAV's and UGV's use all the same logic as 'drivers'. 
See MissionFile.htm, AI_Logic section for options.
Valid UAV and UGV objects are defined for FuMS in the BaseServer.sqf file. See BaseServer.htm for details.

*Theme Global Loot Data
Fixed bug causing a parsing error when choosing to use a theme's local loot data file.

*Rebuild of Logic Bomb
See MissionFile.htm for details. Missions now operate on a trigger/action mechanic.
Mission phasing has been removed. Missions now create children missions as part of the new 'logic' structure. Settings for 
the new 'mission launch' actions are detailed in MissionFile.htm.
Mission spawning no longer 'suspends' triggers in the active mission, and admin's can now control how assets created
in spawned missions contribute to the parent mission.
Also see Test theme TestMission01.sqf for multiple examples.

*New Triggers
- "OK" - Use of this trigger will result in the associated action occurring immediately upon mission start.
- "CAPTIVE" - Evaluates 'true' when the specified number of AI have been rescued.

*New Mission Actions:
- "Lose" - causes 'lose' messages and loot events
- "Win" - causes 'win' messages and loot events
- "END" - terminates the mission and cleans up mission resources. Operates independent of win/lose. win/lose no longer clean up the mission.
- "CHILD",["<MissionName>",[location],Times, Frequency(seconds) ]
- "STEPCHILD",["<MissionName>",[location],Times, Frequency(seconds)]
   Child and StepChild spawn new missions that will share and inherit resources. See MissionFile.htm.

* MissionFile.htm updated.
-Details on new Mission Logic
-Details on how XPOS works with respect to 2D, 3D coordinates and 'named' locations.

*New AI Logic:
"CAPTIVE" - makes a unit 'neutral' with AI regardless of its 'side'.  Adds an action menu to the AI with the following options:
	Flee: If within 200m of a rescue spot captive will run to that location. Otherwise it selects a random rescue spot from the list provided.  Unit sets CARELESS behavior and sprints to its destination.
	Stay: Unit will stop at its location and assume the stance of the player issuing the order.
	Follow: Unit will follow the player, mimicking his stance. If the player gets more than 250m away from the unit, the unit will resort to a 'Stay' behavior using the stance of the player at the time the unit loses him.
	Board: Unit will board nearest non-ai controlled vehicle.
	Escape Point: Unit will temporarily display its 'escape point' on the map.
	Note: The captives are a little 'shell shocked' and will sometimes take a few seconds to respond to commands, but they will always acknowledge they heard the command via 'system chat'.
	Note: Captives that start a mission as 'cargo' in an AI vehicle will remain in the vehicle until it is disabled.
	Note: Captives assigned to follow an AI group will stop following that group when the group leader dies.
	Note: Captives remain 'neutral' to hostile AI until directed to Flee.

*New "CAPTIVE" Theme
Theme demonstrates new Captive logic. This theme creates a mission in a random location that contains 10 prisoners being guarded by a small
squad of Humans, and an unarmed UGV.  The goal is to get into the camp and rescue at least 7 of the captured clone prisoners. 
Beware, if too many of the guards are killed, reinforcements will be called upon!
Talk to an AI to find his 'evac location', take advantage of nearby transportation, and if you succeed expect to find loot at the Evac site!

*New SoldierData Flag
All AI defined in SoldierData files may also be provided with a true/false flag to set their captivity.
This flag has no relation to the new 'Captive' AI logic and missions.
This flag is a method to define custom AI that, by default, are 'setcaptive', thus hostile AI will not fire upon them.
See GlobalSoldierData.htm section 8 for more details.

Issues:
* Loot set to be placed in vehicles is not working consistently.


v2.0
* Documentation Update
GitHub now contains extensive documentation on all FuMS options.
Check the Docs folder on the github!

* update VCOM Driving v.1.2
  Improved handling of bridges and gates
  http://forums.bistudio.com/showthread.php?187450-VCOM-AI-Driving-Mod

* BodyCount now increments when an AI is killed by another AI.  No credit is given for AI killed by vehicles controlled by either players or AI.

* Improvements to HC crash/network disconnect detection.
HC will persist through temporary network outages and lag.  Only after a hard disconnect from the server will HC
missions and AI be removed. Epoch UI check/dependency removed.

* Update to Mission building placement (see MissionFile.htm for documentation)
- M3Editor structures now support SMOKE/FIRE options (see Test Mission for example)
- Random building selection fixed for old building format.(see Helocrash missions)

* Box Smoke: Fixed bug that was causing smoke to be triggered by AI.

* AI and Box positioning:
Tweaked positioning of AI and loot boxes when spawned in missions.  
AI and boxes should appear closer to intended positions. FuMS was originally using an offset of 10-30m when creating the
object to help prevent collisions. Several admins have expressed a desire to have more specific control over ai and loot 
box placement, so this version has reduced that offset to 0m.  AI and loot boxes should be appearing exactly where 
specified.
Note: This may cause some issues with loot not appearing for some missions where the mission location was generated randomly
due to the terrain not supporting placement of the AI or Lootbox.

*Tower Guard AI Logic:
Tweaked spawn positioning to ensure all AI in the group are placed within nearby buildings in the event insufficient rooftops 
are found for them to take up guard positions. 
AI will now properly populate and 'sentry' in desired buildings (see Test/Destroyable.sqf mission)

* Min/Max Player setting adding to all Themes:
==============
==Admin Note==
======================================================================================
- Ensure the following is added to the 'options' section of any custom themes.sqf developed outside of FuMS.
		1,  // Player minimum to launch missions from this theme.
        100   // Player maximum above which missions will not launch
=======================================================================================
- All FuMS themes now include these new settings. (See ThemeData.sqf's included with distro)
- A theme will now ONLY create missions when the player count is greater than or equal too the minimum and 
less than the maximum player count.
- A delay of 60 seconds occurs between meeting the player requirement and the theme creating its 1st mission.
- Missions already created will remain in play if the player requirement fails while the mission is running.
When the mission completes the theme will then suspend further missions until the requirement is met again.
- See ThemeData.htm documentation for details.


     
* Fixed bugged with 'AI only gear' sometimes not being cleaned up when an AI dies.

* Two new triggers that allow mission state to be controlled by the amount of damage specific vehicles and/or buildings
have sustained!  See MissionFile.htm for details and \test\Destroyable mission for example.

** Damaged Buildings Trigger
["DmgBuildings","INDEXER", amount]
1.	"INDEXER"
a.	This is a zero based index on which buildings on which damage will be watched.
b.	Valid formats may be a single building, range of buildings, or a combination of single buildings and ranges.
c.	Examples:
1.	"0"  = will watch the 1st building created by the mission.
2.	"1-5" = will watch the 2nd-6th buildings created by the mission.
3.	"1,2,4-8" = will watch the 2nd, 3rd, and 5th-9th buildings created by the mission
2.	amount
a.	A value from 1.0 to 0.0
b.	When damage value of the building reaches this amount it is 'counted' towards satisfying the trigger
3.	Trigger will return true when ALL buildings in the "INDEXER" list are damaged to the 'amount' set in the trigger.

** Damaged Vehicles Trigger
	["DmgVehicles","INDEXER", amount]
1.	Identical behavior to "DmgBuildings" above.
2.	Vehicles created in BOTH the building section and vehicle section are counted when trying to determine the proper 'indexer' values.
3.	Example:
a.	If you have two static vehicles in the building section it will be index ref 0 and 1
b.	Any vehicles that are then created in the 'Vehicles' section would be index referenced starting with 2
c.	IE you have a mission with 3 static vehicles in the building section and a patrol of 4 other vehicles.
1.	Indexer = "1,5"
2.	This would watch the 2nd static vehicle in the building section and the 3rd vehicle (6th total) in the "Vehicles" section.

* Custom Scripting:
Supports custom scripts that can be ran at mission start and at mission end.
Scripts to be run are defined in the \FuMS\Themes\<ThemeName>\Scripts folder.
Scripts are 'called'. FuMS expects an array to be returned by the start script, which it then in turn passes to the mission end script.

This array can be used to pass variables from the start to the end scripts.
See MissionFile.htm and ThemeData.htm documentation for details.

*Random mission positioning

FuMS missions now support randomizing the location of the 'core' of the mission within the defined encounter radius.
See MissionFile.htm and \FuMS\Themes\Test\Destroyable.sqf for details.



--Known issues
Helo patrols traveling slow.
Scuba AI not using underwater firearms underwater.

--Upcoming
Fixing Helo and Scuba AI behaviour 
Sound notification and environmental effects for missions
autonomous AI UAV/UGV's
VIP rescue/Captor theme



------------------------------------------------------------------------------------
v1.5g
** Changes to client side files! Make sure you update them too!
+ Fixed bug preventing vehicles from being sold
+ Fixed bug for Scatter Loot: Loot now properly spawns above ground.
+ Fixed bug that was preventing non-admin players to hear corrupted clones (zombies)
+ Fixed 762 Ammo caused by Arma3 class name changes in BaseLoot.sqf
Ammo762 = ["20Rnd_762x51_Mag","10Rnd_762x54_Mag","30Rnd_762x39_Mag","150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer"];

+ M3Editor support for ALL Missions
FuMS now supports M3Editor format for buildings.  See \Docs\M3Editor Buildings.txt for instructions.
Mission creators can now place 'prebuilt' areas crated in M3Editor.
Additionally, FuMS will automatically calculate 'offsets'. This will permit you to then translate the group of buildings to any location
on ANY map.  Through FuMS you should be able to port M3Editor designs from any map to any other map.
See \Theme\Test\CaptureTheFlag.sqf for example usage. (I know this does not look pretty!)

+ ZupaCapure Points Trigger
See Docs\Triggers.txt for instructions.
Missions can now be controlled by ZupaCapure points.  This new trigger permits the mission designer to create any number of capture points
within his mission.  Mission success occurs when all points are capped.
Behaviour is based upon ZupaCapture Points. See \Theme\Test\CaptureTheFlag.sqf for example usage.

+ Static Weapon support
Static weapons can be defined, just like a vehicle in the 'convoy' section of a mission.
["B_HMG_01_high_F",[-20,-25],[180],"None"]
Note: In place of specifying 'crew' the FACING of the weapon is defined ([180]), so this HMG will face south.

New AI Logic:
"Gunner"
Syntax: ["Gunner", [spawnloc], [actionloc], [0]]
-spawnloc: offset or specific map location <-- ignored for this logic, be retained for continuity of Logic series
-actionloc: offset or specific map location at which AI will be placed.
-[0]: Place holder.
Behaviour:
Used as a defined logic for 'drivers' in the Convoy section of missions. AI under this logic will man, and remain in static weapons.

New AI Logic:
"TowerGuard"
Syntax:["TowerGuard", [spawnloc], [actionloc], [radius,"Building_Name"]]
- spawnloc: offset or specific map location <-- ignored for this logic, be retained for continuity of Logic series
- actionloc: offset or specific map location at which AI will be placed.
- radius: distance from 'actionloc' to search for rooftops
- "Building_Name": a building name may be provided. In this case AI will only be placed on these buildings. Default is "ANY"
 Behaviour:
 Script will search 'AREA' for all enter-able buildings. 
 highest point of all buildings in the area are located.
 if "Specific" building is provided, the list will be filtered to only buildings matching this name and the closest to the 'Origin' will be selected.
 AI will be spawned at the top of these buildings and remain there.
 
 Note: "TowerGuard" and "Gunner" will leave their posts in response to an XFILL call 
from a driver running the "XFILL" convoy option logic.
 
 ***Example***
 *** See \FuMS\Themes\Test\Mil_Outpost.sqf
 ***  for example usage of new functionality
 *************

** Known Issues:
- Helicopters sometimes not moving or moving at a much slower rate than specified.
- Vehicles occupied by players not persisting through server restart.
- Frogman AI are not firing SDAR while in water.


v1.5f

#RAPTORS ADDON SUPPORT:

http://makearmanotwar.com/entry/ec2EDrOCkM#.VT0zFfnF9EK

See FuMS Installation instructions for setup.




+ Anit-Air for AI

Added ability to added anti-air weapons to AI, similar to 'anti-tank'.  Use the same field in the SoldierData.sqf with one of the 
following settings:

 //Anti-Tank options

  // true = RPG launcher with ammo.
  
// "AIR" = Titan_F launcher with ammo.

// "LAND" = RPG launcher with ammo.

  // "RANDOM" = 50/50 chance of AIR or Land launcher.
  
  // false = no special anti-vehicle weapons.
  
  // NOTE: controlling the deletion of this equipment upon AI death is set in BaseServer.sqf
        
See GlobalSoldierData.sqf for examples

+ Fixed a bug with 'HasAdminAccess' that was causing erroneous .rpt logs.






v1.5e

+ Loot Options:
"SCATTER" key word.
"SCATTER" may now be used in place of a Loot option name or "RANDOM" in the 'Loot Configuration' section of all missions.
When "SCATTER" is specified the loot option named "SCATTER" is selected.
Loot contained in the 'SCATTER' option (defined in LootData.sqf or GlobalLootData.sqf ) will be distributed on the ground in random directions around the loot's location.
This options works WITH vehicles, so, if in the mission file, "SCATTER" is the loot option for the vehicle, the loot will be scattered
around the vehicle when it is spawned.
No loot box will be created when "SCATTER" is used.

Ex: ["Scatter",[0,0]]
In this case when loot is to be spawned the loot items contained in the "SCATTER" description in the LootData.sqf will be spawned
on the ground around the location [0,0] (encounter center).

+ Fire and Smoke Effects:
3 sizes of Fire and smoke
"Fire" or "Smoke" options are now available to static vehicles and buildings in all missions.
"FIRE_SMALL","FIRE_MEDIUM","FIRE_BIG","SMOKE_SMALL","SMOKE_MEDIUM","SMOKE_BIG"
are the list of current valid options.
Static vehicles are defined in the 'Buildings' section of each mission. See Theme\Test\NukeDevice.sqf for example usage.
Attaching this parameter to a vehicle or building will cause it to have the desired effect until it despawns.

+ Building Randomization:
In the 'Building' section of each mission when defining structures and static vehicles, the 'name' of the building/vehicle may now be a list of names.  When FuMS sees a list it will randomly select one of the names from the list.
See \FuMS\Themes\StaticMissions\DayZHeloCrash.sqf for example.

+ Crash Site Theme (Title: StaticMissions) - inspired by Richie

Theme demonstrates new functionality introduced in v1.5e.  This theme will spawn 10 Dayz style helo crashes at random locations
across the map. All 10 crashes are spawned when the HC connects and remain until server reset.  Placement of these crashes follow
normal FuMS spawn mechanics so they will not spawn near bases, players or other encounters.
Note: If you want the locations to show on the map, set the 'show encounter' option to 'true' in the DayZHeloCrash.sqf mission file.
Note: This mission can be easily edited to add AI, or even change the helo to a semi-functioning, 
smoking version...it is just another FuMS mission after all!

+ MadScience Theme: Modified to not show on map by default.

+ SEM Theme: Added Smoke/Fire effects where applicable to crash missions.


v1.5d
+ Updated TrackPatrol and RoutePatrol to more effectively utilize 'named' locations.
 This update permits use of keywords 'Villages','Cities', and 'Capitals'.  See \Docs folder for specifics on AI logic.

+ Fixed bug with TrackRoute that was causing 'track icons' to appear at position [0,0] on some maps. 
 
+ Vehicle stuck code enhanced. 
AI vehicles now will 'teleport' to the nearest road in the event they become entangled on terrain.
AI controlled vehicles will also no longer decide they are stuck because they are waiting on their group leader's vehicle.
AI will now wait patiently for the group leader's vehicle to move, then proceed on mission. Change should lend to
a more reliable persistence in vehicle traffic, especially when multiple vehicles are under a single AI group's control.

+ AI Controlled vehicles will no longer run out of fuel, but will always leave a vehicle with 1/4 a tank.

+ Modified "Tracked" AI so that their map symbol changes dynamically as they change vehicle types (Truck, Car, Air, Ship, Walking)

+ HC disconnect code optimized, once again......

+ Added Convoy Theme. (all map compatible)
  Based upon capability already in FuMS and AI map tracking icons, this theme has been added.
  FuMS will create and maintain two convoys of 3 pickup trucks.  Each truck has 4 AI. Loot located in the trucks
  Convoy spawns at a random location on the map, then proceeds to two randomly selected villages. 
  1 vehicle is a 'Technical'. This vehicle, "B_G_Offroad_01_armed_F" is also added to the exclusions list in BaseServer.sqf to limit player use.
  
+ Updated Helo Patrol Theme (Now all map compatible)
  2 patrols of 3 armed helo's are created. The patrol flys between 5 randomly selected village,city,capital locations on the map.  Helo patrols once destroyed do not return until server restart.
  
 + AI Gear Exclusion List
 See BaseServer.sqf in the "Soldier Section".  Gear can now be defined as AI only.  Any equipment placed into these lists will be deleted from an AI when it dies. This will allow AI to utilize weapons not permitted by the player base.


v1.5c
 - revert to pre 1.4 HC connection coding. Old heart beat monitor restored.
 - Should fix issues with HC timeouts.

v1.5b
- Fixed bug that resulted in repeated mission spawning when FuMS Admin Controls where disabled.
- Fixed bug with that was not properly disabling FuMS Admin Tools when set to false.
 -- ensure your HC folder in mission.pbo is updated!
- Fixed bug that was causing paratroopers to sometimes despawn upon landing.
- Fixed bug with smoking loot boxes not following configured settings.

- Added code to prevent server side HC initialization from hanging if the HC can not be assigned a gender.
  This will correct issues where the server would not perform object cleanuup for an HC that connects to the server
  with no identity.
  
+ New AI Logic:
["TRACKROUTE", [spawnloc], [actionloc], [behaviour, speed, [locations], FlagRTB, FlagRoads, FlagDespawn, flyHeight]
Identical syntax and behavior is the same as "PatrolRoute", but when this logic is associated with a group in the mission file a
symbol appropriate to the group's vehicle will mark the group's movement on the map. (updates every 3 seconds based off
the leader's position).
 - See the Test/LandPatrol  and HeloPatrols/ missions for example usage.
 - See Docs folder on GitHub for details.

+ Smart Mission spawning:
Missions using random locations as spawn points will now check for similar type territory within their encounter radius.
As an example a "LAND" mission with an encounter radius of 150m will ensure land is present within its radius in all directions.
To take advantage of this new check, place the parameter "WATER" or "LAND" after the encounter radius in the mission file.
Additionally, the mission MUST be trying to use a 'random' location. (See TestMission01.sqf for details)
Example from BikeGang test mission:

	[
	
	"BikeGang", // Mission Title NOSPACES!
	
	300, // encounter radius
	
	"LAND" // location requirement: LAND, WATER, NONE
	
    	// this parameter is optional, but if a value is present it MUST be one of the three above values.
    	
	], 
- When spawning, FuMS will check 100m, 200m and 300m N/E/S/W for land. If water found on any check a new random position
will be selected. A maximum of 15 attempts are made before settling on a position.
Note: PlotPole/Player proximity is still honored for both water and land missions.

+ Mission Overlap checking:
Missions using random locations as spawn points will now check for other missions within their radius before spawning.

+ Automatic world identification.
BaseServer.sqf no longer requires information about the world map. Admin's ensure you update your BaseServer.sqf.
See \FuMS\HC\Util\GetWorldInfo.sqf for list of currently supported maps.
Feedback needed to populate other maps' Exclusion Areas (ie spawn locations)

+ FuMS Server side 'theme spawning enable flag' moved to BaseServer.sqf, default is false (OFF)




v1.5a
+ Fix to Crazed-Clones - now properly attack players
+ Fix to AI RocketLaunchers they are now properly removed upon AI death.
+ Corrected language for error message received when attempting to read a Theme's Soldier or Loot files and they are not present.
+ Fix to 'invalid' HC disconnects detected by server during initial HC connection.
    (was accomplished by waiting for the 'gender' of the HC to be defined before allowing the server to watch for the disconnect)
 - thanks to SpiRe for the pointer-
 - Note: This is a 'test fix'. I am having issues duplicating this error on my test server..so further input may be needed if this does not resolve the issue!
  
######TO IMPROVE PERFORMANCE DISABLE SERVER SIDE FUMS######
#####Only do this if you are using a headless client#######
set line 15 of \FuMS\init.sqf   FuMS_ServerFuMSEnable=false;
By default serverside FuMS is enable with SEM, Small, Aquatic and MadScience Theme.
###########################################################


v1.5
-----v1.5-------- 
+ CrazedClone AI Logic added
 based upon Gulozwood scripting.
 
 + MadScience Theme
  At server start 9 random towns are chosen as infected zones.
  When a player gets near the center of an infected town, the crazed clones materialize. crazed clones WILL attack AI too.

+ SafeBase Code added
  When an encounter is created at a random location, FuMS now checks for plot poles within 200m of the location. If any are found
  FuMS then searches for players within 200m of each plot pole. If players are found, a new position is generated. If after
  15 attempts a good position can not be found, the mission will spawn ignoring these plot pole, player checks.
  
 + AI controlled vehicle ammo now follows AI's unlimitedAmmo flag defined in GlobalSoldierData.sqf
 + BaseServer Option:
     Added option in Loot section to zero out vehicle ammo the 1st time players occupy/capture an AI controlled vehicle.
 
 + ServerSide FuMS enabled!
 Due to the large potential load that FuMS can place on a server, some of the themes packaged with FuMS have been set to HC only. The following themes will spawn as part of the default config. If additional themes are desired the BaseServer.sqf will need to be modified by an admin:
	+ SEM, Small, Aquatic, MadScience - default to run on Server AND HC's
	+ HeloPatrols, TownRaid, Test - default to run on 1st HC's only
	  
+ Note: ServerSide FuMS support is ENABLED by default. To turn OFF Serverside FuMS change line 14 of \FuMS\init.sqf to:
   FuMS_ServerFuMSEnable = false;
      + OR ensure no theme is configured to run on the server (no values of -1 or 0 in BaseServer.sqf). 
	  Default to ENABLED was set to support a larger range of players.
   
+ Note: For initial SA map notification for the MadScience theme is on to allow admins to see how things will look, and to locate towns to do their own testing. It is recommended that when you move to a live server to 
	+ set line 14 of \FuMS\Themes\MadScience\SpawnTrigger.sqf to false to hide the 'infected' towns from players.

+ Note: Themes set with a -1 value in BaseServer.sqf will run on BOTH the server and all HC's that connect to the server. This will result in dramatic scaling of the number of missions running. As an example, the Aquatic theme spawns 3 water encounters and maintains 3 up at all times.
	+ This theme is configured to run on both the Server and HC's, so when an HC conncect, another 3 (total 6) aquatic encounters will be maintained.
	+ If/when the HC disconnects, FuMS will reduce the number of aquatic missions back down to 3.
	+ Basically Themes with -1 set will run in duplicate, once on the server, once on the HC. (see BaseServer.sqf)

v1.4
+ HC disconnect/reconnect greatly optimized!
+ Multiple Headless Client support. FuMS now properly cleans up AI when controlled from multiple HC's.
  See BaseServer.sqf on how to set Themes to run on specific HC's. Coming soon, server side spawning!
  
+ AdminTools: SetPlayer, SetMission are now functioning properly. Admins will be able to designate a player and then spawn in any FuMS mission on that player's location.
+ Mission Syntax pre-compiler Complete!
   Headless client now scans and pre-compiles all missions.  If an error is found the mission will not be used as part of the theme, and a message
   will be inserted into the HC's .rpt log.   
+ Syntax checker should also eliminate any .sqf errors or crashes due to misconfiguration. If you experience any of these, please forward your .RPT
to me!  
+ 80% reduction in Mission .pbo footprint for FuMS (now less than 30kb)!
+ All HC files moved to server side PBO. HC's now download all their scripts and data from the server upon connecting.
+ BaseServer MinFrameRate
  Option added to BaseServer.sqf to limit HC interaction with server if FPS drops below the specified amount.
- Removed radiochatter sound file.  Functionality still there, but unique static sound no longer packaged with FuMS.
**(Admins may need to remove the CfgSounds definition in description.ext from the previous install)
# 2 second delay added to mission creation after buildings are placed to provide opportunity for them to initialize and be positioned prior to creation of units.
# modified 'halo/para drop' code to fix a bug that resulted in AI sometimes never realizing they reached the ground.  
+ Smoke Box options - see BaseServer.sqf
	+ Trigger range - smoke now activates on player proximity (0=unlimited)
	+ Colors - smoke color can now be customized
	+ Duration - duration of smoke now independent of loot box cleanup timer
# fixed reliability of admin menu, and enhanced it to support multiple HC's and server-side spawning (non-HC) configuration.
+ 5 Theme Options now availible via the ThemeData.sqf:
	+ 1: Create random mission from theme's list each control loop cycle.
   	+ 2: Create missions 'in order' found in the ThemeData.sqf
   	+ 3: Create random mission, until all in the theme's list have been spawned.
   	+ 4: Spawn all missions in the theme's list immediately. Use the theme's respawn delay to 'regenerate the mission when it is complete.
   	+ 5: Spawn all missions in the theme's list ONLY once!  
+ Additional option added to enhance Admin use of dynamic events.   
+ ****************
+ ** Admin Note **
+ ** To support migration to server side script storage and Multiple-HC support all mission files need to undergo the following changes:
+ -remove 'initData ='
+ -remove 'MissionData = _initData;'
+ -remove 'HCHAL_ID publicVariableClient "MissionData";
+ **
+ SmokeBox options array replaces true/false flag in BaseServer.sqf
+ *****Missions packaged with FuMS are ready to go!
+ **FRESH INSTALL RECOMMENDED**
+ 

v1.3
+Headless Client Installation!
	Install instructions now include basic instructions for setting up your Headless Client
	
+VCOM_Driving V1.01 - Genesis92x
http://forums.bistudio.com/showthread.php?187450-VCOM-AI-Driving-Mod
Added to AI. See BaseServer.sqf for disabling it. 

+Stand alone vehicles:
In addition to adding vehicles in the 'convoy' section of a mission. Vehicles can now also be added in the 'buildings'
section. Vehicles placed in the 'buildings' section have additional flags to adjust their fuel, ammo, and damaged condition.

+AI only vehicles:
See BaseServer.sqf for details (near bottom): Admins can now add AI only vehicles. Players attempting to access vehicles on this list
will receive a 'curious' message and be removed from the vehicle.

+Admin Controls for Missions!
See \Docs\AdminControls.txt for specifics.  This version allows admins to directly control the launching of missions through
control of a theme's mission control loop. More options to come.
--known bug: sometimes the addaction menu will disappear. Re-logging returns it. Not sure what is the cause..Please post a solution 
if you know of one!

+Marine Locations:
"Marine" is now available as a location. Similar to "Villages", "Cities", and "Capitals", this new location will automatically
add all 'marine locations' on your map to a list for use in encounter location randomization.
See the new Aquatic theme for example of usage!

Fixes:
-Optimized vehicle spawning, improving reliability of helo patrol and paradrop AI_Logic.

-Modified HC's heartbeat to occur once per second instead of once every two seconds to eliminate false HC disconnects 
being detected by some servers.

Changes:
* Moved configurable items out of SoldierData.sqf and BaseLootData.sqf and moved them to the more
appropriate location of BaseServer.sqf. READ the new BaseServer.sqf!

* Upon mission completion, AI engaged with players will remain until no longer engaged, effectively suspending cleanup
for those AI and their vehicles. After a mission completes, any AI that was engaged will remain in play until it
goes for 3 minutes without encountering players. AI Vehicles in this situation will remain for 3 minutes after
the driver dies to provide an opportunity for players to 'get into' and claim those vehicles.
Under normal circumstances, AI not engaged with players, and their vehicles will be removed at mission completion.

***************************************************
***  Admins, Theme folder files requiring update:
**	 BaseServer.sqf
		+Soldier Defaults section
		+Loot Defaults section
		+Map Definition: Admin controls enable flag
**   All ThemeData.sqf's  -->see \Test\ThemeData.sqf for template.
		+Options section: ThemeAutoStart flag
		+AI to Base section: added 8th chat interaction
		+Base to AI section: added 8th chat interaction
**RECOMMEND USING NEW FILES OFF THE DISTRO AND MODIFYING TO MEET YOUR SERVER'S CONFIG.		
*************************************************
v 1.2a,b,c
Fixes:
-Issue with HC hanging when restarted at the same time as the server corrected.
Recommendation: Do not reboot your HC, but maybe once every couple days.
Rebooting HC with server is not required under normal circumstances!
And don't forget, you can 'kick' your HC just like a player to get FuMS to do a full reset!

-Changed 'options' for AI "BUILDINGS" logic to mirror most of the other logic types:
   See Docs\AI_Logic.txt for details before customizing your own missions!
   
-Enhanced error reporting to server and HC .rpt for mistakes in config files.
-An error in a mission file will no longer cause FuMS to hang. FuMS will report the error, skip the mission
  and continue to run all configured themes.

-"Random" boxes for mission loot have been restricted to the following:
"B_supplyCrate_F","O_supplyCrate_F","I_supplyCrate_F","CargoNet_01_box_F"
  Other boxes can be used, but only if specified in the mission file's loot section:
  ["Random",[0,0]]    -->>  ["<your box name>",[0,0]]

- Corrected an error in building placement that was causing mission buildings to ignore 'rotation' settings.
 
- Volume of radio static has been reduced to 60% (was at 100%). see your 'description.ext' 
        sound[] = {"HC\Encounters\Sounds\radio01.ogg",.6,1};
		
**Contributor: MillerTime : http://hightimez-gamerz.enjin.com/home
-Loot Box smoke now more patriotic.
  Box smoke also persists through the duration of the box to aid in locating it.
- Color enhancements to Global Hint message.
-Adjusted location of AI radio message window to no longer interfere with 'Action' menu.
-Small theme example.
*************************

-New Theme Options - 
  Admins can now consolidate all loot and soldier specs into two common files for ALL mission themes.
  Global Loot Data - theme will use server's master loot definitions
  Global Soldier Data - theme will use server's master soldier definitions
  See Themes/Test/ThemeData.sqf for syntax
  No changes required to current mission or themes. Any Theme with the flag set to true will now use
  the GlobalLootData.sqf or GlobalSoldierData.sqf located in the root /Themes folder.

-New Soldier Options -
 Admins can now specify default magazine counts when using the 'RifleXXXPairs' set of values in their SoldierData.sqf's.
 See BaseSoldier.sqf. for settings. 
 
-New AI Options -
Anti-Tank!  See GlobalSoldierData.sqf for how to now include anti-tank weaponry to allow your ai to combat those armored vehicles!
Ex: [ true, true, true], // DiverOverWater, UnlimitedAmmo, anti-tank! 
Any AI with this gear will have it deleted upon death.

-New Building Support -
See MazeTest2.sqf for example:
Building placement code modified to better support 3D offsets.
In the building section if the 1st building in the list is designated at a position of [0,0,0], then all other building
locations are treated as offsets.  This will provide the ability to import pre-designed bases and building layouts, and 
move them around the map.

-Global Variable Conforming:
To reduce risk of conflict with other Mods and addons, FuMS global variables have been modified.
********************************************************************
**Admins: Make corrections to your files in the \FuMS\Themes folders for any custom missions you are currently using!
** Missions distributed with FuMS are up to date.
********************************************************************
FuMS_ServerData - BaseServer.sqf - was ServerData
FuMS_THEMEDATA - bottom of all ThemeData.sqf files - was THEMEDATA
FuMS_LOOTDATA - bottom of all LootData.sqf - was LOOTDATA
FuMS_SOLDIERDATA - bottom of all SoldierData.sqf - was SOLDIERDATA
 <if you are using the new 'global' Data and Soldier files the above changes don't need to be made immediately>
*******************************************************************

v 1.2
- Themes:
	* AirPatrol
	- 4 Separate missions designed to scout the towns of ALTIS.
	- Each mission is a division of 3 armed helicopters.
	- The Helo's will patrol their route, return to their starting point and despawn, prompting the next patrol of helo's to spawn.

- Fixes:
	* PatrolRoute: adjusted 'completion radius' on waypoints for aircraft.
             improvements to RTB and cyclic behaviour (see AI_Logic.txt in Docs folder)
	* ControlLoop: corrected error in random and 'in order' mission selection not properly advancing to the next mission in the list.
	* SpawnVehicle: vehicle crew members now carry mission specific variables, and now count in Trigger logics.
	* LogicBomb: corrected a bug that was causing BodyCount trigger to terminate a theme's logic loop.
   
- New Trigger:
	* ALLDEADorGone - true when all ai associated with a mission and its phase missions have been killed or have despawned. This check is done MAP wide, so may be more useful in detecting mission state on some large area missions.

v 1.1b
 - Phased missions can now use a location other than the parent mission's center
	Ex:
	// Phased Missions.
	// Chaininig of missions is unlimited.
	// Above triggers will 'suspend' when below phase starts. Phase launched will use its own triggers as specified in its mission script.
	// If it is desired to continue to use the above Triggers instead of the 'launched mission's' triggers do the following:
	//   uncomment the "NO TRIGGERS' line from the mission being launched (ie the child mission).
	// The file needs to be located in the same theme folder as the mission launching them.
- 	[
-     	["NukeDevice",["Paros"]],  //Phase01 <-- as an array a 3dlocation, offset, or town name can be specified for the phase mission's center
	// In the above example, based upon the phase01 trigger, when a player gets within 100m of the current encounter's center
	//  The NukeDevice mission begins in the town of Paros.
- 	"TestMission01Enemy", //Phase02 <-- just a file name, phased mission uses THIS mission's center!
	// In this example, when the phase02 triggers become true (for this mission after 5 minutes of time), this mission
	//  is started at the current mission's position.
- 	"TestPhase3" //Phase03
- 	],

- AI of different factions will engage each other
       East or West, Resistance, Civ are the three available sides. (East and West are friends under EPOCH)

- Added ability to spawn AI of side "CIV"

- Additional AI radio chatter added to identify when AI engage other AI
(see ThemeData.sqf under 'Test' theme. "DetHostileAI" response pair added

v 1.1a
- Fixes:
  - Tweaks to mission data files to reduce format errors (still need to be careful!)
  - mission vehicles now only persist if a player captures it (ie gets into it).
-Additions:
  - GlobalLootOptions added to BaseLoot.sqf
    20, //Loot box timer- 20minutes after mission completes all loot boxes associated with mission will despawn.
    true, // produce smoke at location of a spawned loot box
    true // vehicles occupied by players become sell-able and persist through server restart
- Missions support multiple loot types/locations. See TestMission01.sqf for syntax!

v 1.1
 - Server Side PBO support.
   - All themes and missions moved to a server side PBO to reduce client side mission file, and help protect mission authorship.
   - See install instructions!  All themes and missions now contained in the FuMS.pbo
  
 - All 'offset' location types within mission files now support use of town names. Within the mission and theme files, town names located on the server's map may be used in place of actual locations to assist in mission creation.
 
- PatrolRoute  AI logic added.  See docs/AI_LOGIC.txt for all other AI logic's available.
"PATROLROUTE"
syntax:["PATROLROUTE", [spawnloc], [actionloc], [behaviour, speed, [locations], FlagRTB, FlagRoads, FlagDespawn, flyheight]
-spawnloc: offset or specific map location group will spawn
-actionloc: offset or specific map location at which behaviour will start.
-behaviour: "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH" - impacts AI's tendency to follow roads, and use lights.
-speed: "NORMAL", "FULL" or "LIMITED"
-[locations] : array of 2d locations, 3d locations, OR town names. 
-FlagRTB: true= group of pilots/drivers will cycle through all locations.
-FlagRoads: true= group will attempt to use roads to get to the locations
-FlagDespawn: true= group will despawn upon reaching final location.
-flyheight: if 'air' vehicle, altitude to fly the route.
Behaviour: group will patrol the locations specified, designed for longer distance, fixed location type patrols.  If vehicle 
is of type 'air' it will spawn airborne.

v 1.00a
   Fixes:
   - vehicles can now be sold to vendors.  Going to look into placing options in the mission files to permit this to be configurable by the admin.
   - Offending infiSTAR box removed from mission data.
   - 'Random' option added for  loot box creation.  If you replace the name of the box with "Random" in the LootData.sqf, a random box will be chosen for you.  List of 'box' options can be found in Encounters\GlobalConfig\BaseLoot.sqf.
   - Undesired 'stock' objects no longer spawning in loot boxes.
   
v 1.00
- Addtions:
 - Aircraft support: All AI Logic now works with helicopters and other aircraft
 - Paradrop AI Logic: aircraft, as well as supporting convoy drop off/pickup, all can perform paradrops. See Docs/AI_Logic for specifics.
 - All loot boxes pop smoke to aid in location
 - Theme Option 4: Can now specify a theme to spawn all the missions in its list at one time. See Basic/ThemeData.sqf for details. This feature will allow for setup of static spawn sites at server start.
     - SEM has been configured to demonstate this new ability.
 - Missions now support spawning by town name.  If a town name is provided with a mission name in the ThemeData.sqf, FuMS will locate the town and spawn the mission at that location. No need for looking up points! Supports all Maps!
     Ex: ["TestMission01","Charkia"] will spawn the mission at the town of 'Charkia'. 

v .95
- Additions:
-  Town Invasion Theme:
 - FuMS now comes with a simple bandit mission theme, and a town invasion theme.
 -  See documentation for description of Town Invasions.
 - Convoy AI
     - Added behaviour: If a driver with Convoy AI LOGIC and 'roadsonly' set to true is assigned to a vehicle, that  vehicle WILL spawn on the road nearest the spawn point in the mision file.
     - Added behaviour: XFILL - vehicle designated with "XFILL" option will call for an evacuation once it gets near its destination waypoint. At this point, all units of the same side, and same Theme will proceed to the vehicle.  The vehicle driver will only call a number of AI based upon his vehicle's capacity. All other AI in the area will continue to operate as normal.
 - All missions support mixture of offset and actual map locations when desired.
 
 - Docs section:
   - See documents for mission trigger definitions and usage
   - See documents for mission AI patrol logic and usage
   - See documents for building / modifying misions and themes
   - See documents for details on themes included with FuMS.
  
- Fixes:
 - Formatting of 'hint' window
 - proper delay in end of mission cleanup
 - proper translation of missions when using a mixture of offsets and actual map locations
 - Corrected issue with SEM missions attempting to launch a phase mission upon mission timeout.
 - 
v .92
- Mission File format change:
     modified exec line at bottom if each mission. If you made any of your own missions, make sure you modify the line near the bottom to match the following:
	_msnStatus = [_initData, _this select 0] call MissionInit;
		
- New mission Trigger: "Reinforce"
  ["Reinforce", chance, <Mission File Name>]
  Example: ["Reinforce", 100, "Reinforcements"]
  Add this trigger to the 'Win' section of a mission.sqf to enable the AI's call for help to be responded too!
  This trigger does not impact 'win' conditions for the mission.
  "Reinforce" - keyword used by Logic Bomb
  chance - percentage chance of BaseOps providing reinforcements
  <Mission File Name> - name of the file in the mission's theme folder to execute. (do not include the .sqf)
  
  See the Reinforcements.sqf as an example.  Additional units, convoys, vehicles, even loot can be added to the reinforcement mission.
  For proper mission dynamics, do not add other triggers to the reinforcement.sqf mission.
  
- Safe vehicle Spawning:
	Vehicles now attempt to locate a spot that is 5m radius clear of objects before spawning. 
	If a position is not found within 100m of the creation point, the vehicle will spawn on the nearest road.
    (FuMS does not support boats or heli's yet!)
	
- Urban areas for Missions:
 Each ThemeData.sqf now includes options to permit missions to be spawned in Villages, Cities, or Capital Cities.
See the 'Basic\ThemeData.sqf' for details.
This functionality will work on all maps, no extra work required. You want a Theme (mission set) that only spawns in villages, or only specific towns or cities?
The capability is now there, without having to look up points. Just specify the town names, or use keywords: "Villages", "Cities", "Capitals"!

- Simple Epoch Missions:
Mission files have been changed and theme enabled with Radio Chatter support
SEM AI uses Radio channel #1 "EpochRadio1" by default. 

v .9
  - Added Radio Chatter system for AI
  - Minor bug fixes with HC cleanup.
  - Mission design system is working. See Install instructions for details on how to create your own themes and missions.

v .8a
   -Removed code checking for multiple HC's. Was casuing conflict on some systems
   -Added BattlEye Filters to GitHub repo.




##############################################################################################################  
#Features
Fully customizable and expandable headless client mission system.
No coding necessary to build your own mission sets!
Easily configurable to any map. 
Supports multiple mission sets (Themes) simultaneously. Run multiple mission story lines at the same time.
Mission configuration file that are easy to modify: Typical mission file includes the following::

* Relative placement grid.  All buildings, groups, vehicles, and their patrols are designated via points relative to the mission center. This permits easy transport of your missions to other locations on the map, or even over to other maps!
	- Absolute location placement also supported per mission.
	- Global Random mission locations, and custom location lists for your mission supported.
(see TestMission01.sqf for examples of each)#
* Custom Notifications: Start, Success, Failure
	- Map, Hint, and Radio notifications fully customizable by mission
	- Change text, turn each on/off.
* Loot : (see LootData.sqf)
	- Spawn loot at mission start, and/or upon reaching failure or victory conditions
	- Spawn mission loot inside vehicles.
	- Loot database by type to permit easy generation of random loot based upon mission.
	- Custom loot sets by theme, or random loot set selection is available.
	- Ability to select random loot containers
	- Loot boxes spawn with a smoke, to assist location in wilderness areas.
* Buildings - Each mission can have its own set of buildings
	- Option to clean up buildings after a mission or have them remain until server reset.
	- EPOCH buildings will spawn loot too.
* Groups AI Soldiers 
	- Groups composed of any combination of 'soldier types'. (see SoldierData.sqf)
		- 10 basic types included.
		- Common sense randomization sets for gear.
		- Simple to add different or additional AI types.
	- Encounters that spawn AI over water automatically equip them with scuba gear.
	- Configure side, formation, and group behavior by mission.
	- Custom patrol patterns for each group:  
		- Perimeter, Box, Explore, Guard, Sentry, Convoy patterns implemented, more to come!
	- AI driver support for convoy, drop off, pick up/evac of troops, and paradrop!
	- AI radio for help: When a group drops below 50%, the group leader will make 3 attempts to radio his base ops for assistance. The chance of a reinforcements, and what is sent, is controllable by each mission!
* Vehicles
	- Configure man and unmanned vehicles, with or without loot.
	- Manned vehicles can be configured with troops.
	- Vehicles have access to the same patrol patterns as AI
	- Troops placed in vehicles can be set to use different patrol patterns when dropped off, or their vehicle is disabled.
	- AI controlled vehicles immune to 'crash' damage for reliability of mission behavior.
	- Vehicles still able to be damage by players or other AI.
	- Player message upon entering a vehicle: 'vehicle is only available until server reset'.
	- Vehicles sellable to Vendors.
	- Mission cleanup: At mission end, AI controlled vehicles are removed when the associated AI are removed.
*Triggers - configurable by mission to control its Victory, Failure, and Phasing conditions.
	- Low Unit Count - trips when unit count within radius of mission drops below a value.
	- Player Proximity-trips when set number of players get within radius of mission.
	- Timer - trips after an elapsed set period of time.
	- Detected - trips when AI detect a player.
	- HighUnitCount - trips when unit count within radius of mission exceeds a value.
	- NO Triggers- option to enable a mission to simply generate buildings, loot, ai, vehicles without any conditions, making them persist until server restart.
	- **More triggers to follow!
* Phasing- aka Mission branching and dynamic modification.
	- Each mission supports up to three different branches.
	- Missions can be chained together. 
	- Used with triggers, dynamic mission sets can be created, simply through use of the 'configuration' files.

Theme level Features: (ThemeData.sqf)
* Radio communication support: AI can be configured by theme to utilize radios to communicate.
	- Custom interface separate from game chat for display of radio messages.
	- Control AI death messages independently of other radio use.
	- Radio type and range they can be heard controlled via theme options.
	- Option to make messages heard if player does not have a radio.
	- Custom callsigns for Base operations and the AI in each theme.   
	- Only spawned group leader has a radio. Kill him, the group stops talking with base Ops. Each group that is spawned has an incremental number on his call sign (Pride01, Pride02, ....etc).
	- Configurable text and 'conversation' pairs between AI and base Ops.
		- Check-In - Group leader checks in upon spawn, with details of his location.
		- Detect - Group leader notifies base upon spotting clones (can occur once every 10mins per group leader)
		- Less50 - Group call base ops for help when his group is below 50%. Chance Base ops will send help! (see Reinforce trigger in Docs for details!).
		- SitRep - Every 30minutes base ops calls all the theme groups for a sitrep.
		- Death- Group leader will notify base ops when his team starts to take casulties.
		- More to come.
      

