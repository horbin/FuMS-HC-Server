#Fulcrum Mission System (FuMS)
v1.5a
+ Fix to Crazed-Clones - now properly attack players
+ Fix to AI RocketLaunchers are not properly removed upon AI death.
+ Corrected language for error message received when attempting to read a Theme's Soldier or Loot files and they are not present.
+ Fix to 'invalid' HC disconnects detected by server during initial HC connection.
    (was accomplished by waiting for the 'gender' of the HC to be defined before allowing the server to watch for the disconnect)
 - thanks to SpiRe for the pointer-
 - Note: This is a 'test fix'. I am having issues duplicating this error on my test server..so further input may be needed if this does not resolve the issue!
  



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
      

