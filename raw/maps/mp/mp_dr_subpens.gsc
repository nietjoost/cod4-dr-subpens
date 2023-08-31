// Main thread
main()
{
    maps\mp\_load::main();

    game["allies"] = "marines";
    game["axis"] = "opfor";
    game["attackers"] = "axis";
    game["defenders"] = "allies";
    game["allies_soldiertype"] = "desert";
    game["axis_soldiertype"] = "desert";

    setdvar("g_speed" ,"210");
    setdvar("dr_jumpers_speed" ,"1");
    setdvar("r_specularcolorscale", "1" );
    setdvar("r_glowbloomintensity0",".1");
    setdvar("r_glowbloomintensity1",".1");
    setdvar("r_glowskybleedintensity0",".1");

    setdvar("dr_afk_time","60");
    setdvar("dr_afk_warn","45");

    // Custom vars
    level.door_old = false;
    level.player_in_room = false;
    level.race_room_use = false;

    // Precache
    level._effect[ "frag_exp" ]	= loadfx( "explosions/grenadeExp_dirt" );
    level._effect[ "tank_fire_hatch" ] = loadfx( "fire/tank_fire_hatch" );
    level._effect[ "gas_pump_fire" ] = loadfx( "fire/gas_pump_fire" );
    level._effect[ "american_smoke_grenade_mp" ] = loadfx( "props/american_smoke_grenade_mp" );
    level._effect[ "tire_fire_med" ] = loadfx( "fire/tire_fire_med" );

    precacheItem("ak74u_mp");

    //level thread music();
    level thread messages();
    level thread startdoor();

    // Traps functions
    level thread SetupTrap1();
    level thread SetupTrap2();
    level thread SetupTrap3();
    level thread SetupTrap4();
    level thread SetupTrap5();
    level thread SetupTrap6();
    level thread SetupTrap7();
    level thread SetupTrap8();
    
    // Room functions
    level.roomSniperTrigger = GetEnt("roomSniperTrigger", "targetname");
    level.roomKnifeTrigger = GetEnt("roomKnifeTrigger", "targetname");
    level.roomBounceTrigger = GetEnt("roomBounceTrigger", "targetname");
    level.roomWeaponTrigger = GetEnt("roomWeaponTrigger", "targetname");
    level.roomRaceTrigger = GetEnt("roomRaceTrigger", "targetname");

    level thread SetupOldRoom();
    level thread SetupSniperRoom();
    level thread SetupKnifeRoom();
    level thread SetupBounceRoom();
    level thread PickupSniper();
    level thread SetupWeaponRoom();
    level thread SetupRaceRoom();

    // Teleport function
    level thread teleportpos1to2();
    level thread teleportpos2to1();
    level thread BounceTeleport();

    // Finish Line
    level thread WatchFinishLine();

    // Fx
    level thread EnableFire();
}

// Play music
music()
{
    wait 4;
    ambientPlay( "song1" );
}

// Start message
messages()
{
    wait 10;
    iprintlnBold("^1Welcome to Sub Pens");
    wait 1;
}

// Open start door
startdoor()
{
    startDoor = getent("startdoor","targetname");
    {
        wait 15;
        startDoor moveZ(-400, 5);
        iprintlnbold("^8Start door opened.");
        wait 2;
    }
}

// TRAPS
SetupTrap1()
{
    // Set trap settings
    trap1 = GetEnt("trap1", "targetname");
    trap1ExplosionsLocations = GetEntArray("trap1ExplosionsLocations", "targetname");
    trap1ExplosionHurt = GetEntArray("trap1ExplosionHurt", "targetname");

    // Disable the hurt trigger
    for (i = 0; i < trap1ExplosionHurt.size; i++)
    {
        trap1ExplosionHurt[i].dmg = 0;
    }

    // Wait for use
    trap1 waittill("trigger", player);
    player PlayerMessage("You activated trap 1");
    player PlayerMessage("This trap can be activated again after 10 seconds!");

    // Start trap
    for (i = 0; i < trap1ExplosionsLocations.size; i++)
    {
        playFX ( level._effect[ "frag_exp" ], trap1ExplosionsLocations[i].origin);	
	    trap1ExplosionsLocations[i] playsound("clusterbomb_explode_default");
        trap1ExplosionHurt[i].dmg = 100;

        wait 0.1;

        trap1ExplosionHurt[i].dmg = 0;
    }

    // Reset trap use
    wait 10;
    level thread SetupTrap1();
}


SetupTrap2()
{
    // Set trap settings
    trap2 = GetEnt("trap2", "targetname");
    trap2Object1 = GetEnt("trap2Object1", "targetname");
    trap2Object2 = GetEnt("trap2Object2", "targetname");
    trap2Object3 = GetEnt("trap2Object3", "targetname");

    // Wait for use
    trap2 waittill("trigger", player);
    trap2 delete();
    player PlayerMessage("You activated trap 2");

    // Start trap
    duration = 0.5;
    for(;;)
	{
  		trap2Object1 rotateYaw(360,duration);
		wait ((duration)-0.1);
        wait 1;

        trap2Object2 rotateYaw(360,duration);
		wait ((duration)-0.1);
        wait 1;

        trap2Object3 rotateYaw(360,duration);
		wait ((duration)-0.1);
        wait 1;
	}
}


SetupTrap3()
{
    // Set trap settings
    trap3 = GetEnt("trap3", "targetname");
    trap3Object1 = GetEnt("trap3Object1", "targetname");
    trap3Object2 = GetEnt("trap3Object2", "targetname");
    trap3Object3 = GetEnt("trap3Object3", "targetname");
    trap3Object4 = GetEnt("trap3Object4", "targetname");

    // Wait for use
    trap3 waittill("trigger", player);
    trap3 delete();
    player PlayerMessage("You activated trap 3");

    // Start trap
    duration = 1;
    for(;;)
	{
  		trap3Object1 rotateRoll(360,duration);
        trap3Object3 rotateRoll(360,duration);
		wait ((duration)-0.1);
        wait 1;

        trap3Object2 rotateRoll(360,duration);
        trap3Object4 rotateRoll(360,duration);
		wait ((duration)-0.1);
        wait 1;
	}
}

SetupTrap4()
{
    // Set trap settings
    trap4 = GetEnt("trap4", "targetname");
    trap4ExplosionsLocations = GetEntArray("trap4ExplosionsLocations", "targetname");
    trap4ExplosionHurt = GetEntArray("trap4ExplosionHurt", "targetname");

    // Disable the hurt trigger
    for (i = 0; i < trap4ExplosionHurt.size; i++)
    {
        trap4ExplosionHurt[i].dmg = 0;
    }

    // Wait for use
    trap4 waittill("trigger", player);
    player PlayerMessage("You activated trap 4");
    player PlayerMessage("This trap can be activated again after 60 seconds!");

    // Start trap
    for (i = 0; i < trap4ExplosionsLocations.size; i++)
    {
        trap4ExplosionsLocations[i] moveZ(10, 1);
    }

    wait 3;

    trap4ExplosionHurt[0].dmg = 100;
    trap4ExplosionHurt[1].dmg = 100;
    
    for (i = 0; i < trap4ExplosionsLocations.size; i++)
    {
        playFX ( level._effect[ "frag_exp" ], trap4ExplosionsLocations[i].origin);	
	    trap4ExplosionsLocations[i] playsound("clusterbomb_explode_default");
    }

    wait 0.1;
    trap4ExplosionHurt[0].dmg = 0;
    trap4ExplosionHurt[1].dmg = 0;

    wait 1.5;

    for (i = 0; i < trap4ExplosionsLocations.size; i++)
    {
        trap4ExplosionsLocations[i] moveZ(-10, 1);
    }

    // Reset trap use
    wait 58;
    level thread SetupTrap4();
}

SetupTrap5()
{
    // Set trap settings
    trap5 = GetEnt("trap5", "targetname");
    trap5Object1 = GetEnt("trap5Object1", "targetname");

    // Wait for use
    trap5 waittill("trigger", player);
    trap5 delete();
    player PlayerMessage("You activated trap 5");

    // Start trap
    duration = 1;
    for(;;)
	{
        trap5Object1 moveZ(200, duration);
        wait duration + 0.5;

        trap5Object1 moveZ(-200, duration);
        wait duration + 0.5;

        wait duration + 0.5;

  		trap5Object1 rotateYaw(360,duration);

        wait 3.5;
	}
}

SetupTrap6()
{
    // Set trap settings
    trap6 = GetEnt("trap6", "targetname");
    trap6Object1 = GetEntArray("trap6Object1", "targetname");

    // Wait for use
    trap6 waittill("trigger", player);
    trap6 delete();
    player PlayerMessage("You activated trap 6");

    // Start trap
    for (i = 0; i < trap6Object1.size; i++)
    {
        trap6Object1[i] thread MoveObjectUpAndDown();
        wait 0.5;
    }
}

SetupTrap7()
{
    // Set trap settings
    trap7 = GetEnt("trap7", "targetname");
    trap7Object1 = GetEnt("trap7Object1", "targetname");

    // Wait for use
    trap7 waittill("trigger", player);
    trap7 delete();
    player PlayerMessage("You activated trap 7");

    // Start trap
    trap7Object1 delete();
}

SetupTrap8()
{
    // Set trap settings
    trap8 = GetEnt("trap8", "targetname");
    trap8Object1 = GetEntArray("trap8Object1", "targetname");

    // Wait for use
    trap8 waittill("trigger", player);
    trap8 delete();
    player PlayerMessage("You activated trap 8");

    // Start trap
    for (i = 0; i < trap8Object1.size; i++)
    {
        trap8Object1[i] thread MoveObjectUpAndDown();
        wait 0.5;
    }
}

MoveObjectUpAndDown()
{
    duration = 2;

    for (;;)
    {
        self moveZ(300, duration);
        wait 1;
        self moveZ(-300, duration);
        wait 1;
    }
}


// Room code
SetupOldRoom()
{
    // Set room settings
    doorOldTrigger = GetEnt("roomOldTrigger", "targetname");
    doorOldObjects = GetEntArray("roomOldDoor", "targetname");

    // Wait for use
    doorOldTrigger waittill("trigger", player);

    // Check if a player is already in room
    if (level.player_in_room == true)
    {
        player PlayerMessage("^1 Someone is already in a room.");
        level thread SetupOldRoom();
        return;
    }

    // Setting before start
    doorOldTrigger delete();
    level.door_old = true;
    level.roomSniperTrigger delete();
    level.roomKnifeTrigger delete();
    level.roomBounceTrigger delete();
    level.roomWeaponTrigger delete();
    level.roomRaceTrigger delete();

    // Message
    iprintlnBold("^5" + player.name + " ^7has chosen the room ^1OLD");
    player PlayerMessage("You have chosen the room ^1OLD");

    // Start old room
    for (i = 0; i < doorOldObjects.size; i++)
    {
        doorOldObjects[i] moveZ(-400, 5);
    }
}

SetupSniperRoom()
{   
    // Setup spawns
    sniperspawn1 = GetEnt("sniperspawn1", "targetname");
    sniperspawn2 = GetEnt("sniperspawn2", "targetname");

    // Wait for use
    level.roomSniperTrigger waittill("trigger", player); 

    // Checks before continnue
    if (level.door_old)
        return;

    if (level.player_in_room)
    {
        level thread SetupSniperRoom();
        player PlayerMessage("^1A room is already in-use.");
        return;
    }

    // Set room is in use
    level.player_in_room = true;

    // Message
    iprintlnBold("^5" + player.name + " ^7has chosen the room ^1SNIPER");
    player PlayerMessage("You have chosen the room ^1SNIPER");

    // Start sniper room
    player SetOrigin(sniperspawn1.origin);
    player SetPlayerAngles(sniperspawn1.angles);
    level.activ SetOrigin(sniperspawn2.origin);
    level.activ SetPlayerAngles(sniperspawn2.angles);

    player thread SpawnSniperRoomLogic();
    level.activ thread SpawnSniperRoomLogic();

    // Reset room
    player waittill( "death" );
    level.player_in_room = false;
    level thread SetupSniperRoom();
}

SpawnSniperRoomLogic()
{
    self TakeAllWeapons();
    self GiveWeapon("m40a3_mp");
    self GiveWeapon( "remington700_mp" ); 
    self GiveMaxAmmo("m40a3_mp");
    self GiveMaxAmmo( "remington700_mp" );
    self RoomCountDown("m40a3_mp");
}

SetupKnifeRoom()
{
    // Setup spawns
    knifespawn1 = GetEnt("sniperspawn1", "targetname");
    knifespawn2 = GetEnt("sniperspawn2", "targetname");

    // Wait for use
    level.roomKnifeTrigger waittill("trigger", player);  

    // Checks before continnue
    if (level.door_old)
        return;

    if (level.player_in_room)
    {
        level thread SetupKnifeRoom();
        player PlayerMessage("^1A room is already in-use.");
        return;
    }

    // Set room is in use
    level.player_in_room = true;

    // Message
    iprintlnBold("^5" + player.name + " ^7has chosen the room ^1KNIFE");
    player PlayerMessage("You have chosen the room ^1KNIFE");

    // Start sniper room
    player SetOrigin(knifespawn1.origin);
    player SetPlayerAngles(knifespawn1.angles);
    level.activ SetOrigin(knifespawn2.origin);
    level.activ SetPlayerAngles(knifespawn2.angles);

    player thread SpawnWeaponRoomLogic("knife_mp");
    level.activ thread SpawnWeaponRoomLogic("knife_mp");

    // Reset room
    player waittill( "death" );
    level.player_in_room = false;
    level thread SetupKnifeRoom();
}

SpawnWeaponRoomLogic(weapon)
{
    self TakeAllWeapons();
    self giveWeapon(weapon);
    self GiveMaxAmmo(weapon);
    wait 0.1;
    self switchToWeapon(weapon);
    self RoomCountDown(weapon);
}

SetupBounceRoom()
{
    // Setup spawns
    bouncespawn1 = GetEnt("bouncespawn1", "targetname");
    bouncespawn2 = GetEnt("bouncespawn2", "targetname");

    // Wait for use
    level.roomBounceTrigger waittill("trigger", player);
    

    // Checks before continnue
    if (level.door_old)
        return;

    if (level.player_in_room)
    {
        level thread SetupBounceRoom();
        player PlayerMessage("^1A room is already in-use.");
        return;
    }

    // Set room is in use
    level.player_in_room = true;

    // Message
    iprintlnBold("^5" + player.name + " ^7has chosen the room ^1BOUNCE");
    player PlayerMessage("You have chosen the room ^1BOUNCE");

    // Start sniper room
    player SetOrigin(bouncespawn1.origin);
    player SetPlayerAngles(bouncespawn1.angles);
    level.activ SetOrigin(bouncespawn2.origin);
    level.activ SetPlayerAngles(bouncespawn2.angles);

    player thread SpawnWeaponRoomLogic("knife_mp");
    level.activ thread SpawnWeaponRoomLogic("knife_mp");

    // Teleport back if touch
    player.tp = bouncespawn1;
    level.activ.tp = bouncespawn2;

    // Reset room
    player waittill( "death" );
    level.player_in_room = false;
    level thread SetupBounceRoom();
}

PickupSniper()
{
    bounceSniper = GetEnt("bounceSniper", "targetname");

    for (;;)
    {
        bounceSniper waittill("trigger", player);

        player TakeAllWeapons();
        player GiveWeapon("m40a3_mp");
        player GiveWeapon( "remington700_mp" ); 
        player GiveMaxAmmo("m40a3_mp");
        player GiveMaxAmmo( "remington700_mp" );
        wait 0.1;
        player switchToWeapon("m40a3_mp");
    }
}

SetupWeaponRoom()
{
    // Setup spawns
    weaponRoomSpawn1 = GetEnt("weaponRoomSpawn1", "targetname");
    weaponRoomSpawn2 = GetEnt("weaponRoomSpawn2", "targetname");

    // Wait for use
    level.roomWeaponTrigger waittill("trigger", player);
    

    // Checks before continnue
    if (level.door_old)
        return;

    if (level.player_in_room)
    {
        level thread SetupWeaponRoom();
        player PlayerMessage("^1A room is already in-use.");
        return;
    }

    // Set room is in use
    level.player_in_room = true;

    // Message
    iprintlnBold("^5" + player.name + " ^7has chosen the room ^1weapon");
    player PlayerMessage("You have chosen the room ^1weapon");

    // Start sniper room
    player SetOrigin(weaponRoomSpawn1.origin);
    player SetPlayerAngles(weaponRoomSpawn1.angles);
    level.activ SetOrigin(weaponRoomSpawn2.origin);
    level.activ SetPlayerAngles(weaponRoomSpawn2.angles);

    player thread SpawnWeaponRoomLogic("ak74u_mp");
    level.activ thread SpawnWeaponRoomLogic("ak74u_mp");

    // Reset room
    player waittill( "death" );
    level.player_in_room = false;
    level thread SetupWeaponRoom();
}

SetupRaceRoom()
{
    // Setup spawns
    raceRoomSpawn1 = GetEnt("raceRoomSpawn1", "targetname");
    raceRoomSpawn2 = GetEnt("raceRoomSpawn2", "targetname");

    // Wait for use
    level.roomRaceTrigger waittill("trigger", player);

    // Checks before continnue
    if (level.door_old)
        return;

    if (level.player_in_room)
    {
        level thread SetupRaceRoom();
        player PlayerMessage("^1A room is already in-use.");
        return;
    }

    // Set TP back
    level thread RaceTeleport();
    player.tp = raceRoomSpawn1;
    level.activ.tp = raceRoomSpawn2;

    if (level.player_in_room)
    {
        level thread SetupSniperRoom();
        player PlayerMessage("^1A room is already in-use.");
        return;
    }

    // Set room is in use
    level.player_in_room = true;

    // Message
    iprintlnBold("^5" + player.name + " ^7has chosen the room ^1weapon");
    player PlayerMessage("You have chosen the room ^1weapon");

    // Start sniper room
    player SetOrigin(raceRoomSpawn1.origin);
    player SetPlayerAngles(raceRoomSpawn1.angles);
    level.activ SetOrigin(raceRoomSpawn2.origin);
    level.activ SetPlayerAngles(raceRoomSpawn2.angles);

    player thread SpawnWeaponRoomLogic("knife_mp");
    level.activ thread SpawnWeaponRoomLogic("knife_mp");

    // Finish line
    raceFinishLine = GetEnt("raceFinishLine", "targetname");
    raceFinishLine waittill("trigger", winner);

    winnerTP = GetEnt("raceRoomSpawn3", "targetname");
    loserTP = GetEnt("raceRoomSpawn4", "targetname");

    if (winner.name == player.name)
    {
        // Jumper won
        player PlayerMessage("You won the race!");
        level.activ PlayerMessage("^1You lost the race!");
        player SetOrigin(winnerTP.origin);
        player SetPlayerAngles(winnerTP.angles);
        player GiveWeaponFn("m40a3_mp");
        level.activ SetOrigin(loserTP.origin);
        level.activ SetPlayerAngles(loserTP.angles);
        level.activ Jail();
    }
    else
    {
        // Activator won
        level.activ PlayerMessage("You won the race!");
        player PlayerMessage("^1You lost the race!");
        level.activ SetOrigin(winnerTP.origin);
        level.activ SetPlayerAngles(winnerTP.angles);
        level.activ GiveWeapon("m40a3_mp");
        player SetOrigin(loserTP.origin);
        player SetPlayerAngles(loserTP.angles);
        player Jail();
    }

    // Reset room
    player waittill( "death" );
    level.player_in_room = false;
    level thread SetupRaceRoom();
}

// Teleport functions
teleportpos1to2()
{
    teleportpos1to2Trigger = GetEnt("teleportpos1to2Trigger", "targetname");
    teleportpos1to2Object = GetEnt("teleportpos1to2Object", "targetname");
    
    for (;;)
    {
        teleportpos1to2Trigger waittill("trigger", player);
        player SetOrigin(teleportpos1to2Object.origin);
        player SetPlayerAngles(teleportpos1to2Object.angles);
        wait 0.1;
    }
}

teleportpos2to1()
{
    teleportpos2to1Trigger = GetEnt("teleportpos2to1Trigger", "targetname");
    teleportpos2to1Object = GetEnt("teleportpos2to1Object", "targetname");
    
    for (;;)
    {
        teleportpos2to1Trigger waittill("trigger", player);
        player SetOrigin(teleportpos2to1Object.origin);
        player SetPlayerAngles(teleportpos2to1Object.angles);
        wait 0.1;
    }
}

BounceTeleport()
{
    bouncetp = GetEnt("bouncetp", "targetname");

    for (;;)
    {
        bouncetp waittill("trigger", player);

        player SetOrigin(player.tp.origin);
        player SetPlayerAngles(player.tp.angles);
    }
}

RaceTeleport()
{
    racetp = GetEnt("racetp", "targetname");

    for (;;)
    {
        racetp waittill("trigger", player);

        player SetOrigin(player.tp.origin);
        player SetPlayerAngles(player.tp.angles);
    }
}

// Finish line logic
WatchFinishLine()
{
    // Get trigger
    finishLine = GetEnt("finish_line", "targetname");

    // Wait for use
    finishLine waittill("trigger", player);

    // Win message
    iprintlnBold(player.name + " ^2finished first!");

    playFX( level._effect[ "american_smoke_grenade_mp" ], player.origin);
}

// Utils functions
PlayerMessage(msg)
{
    prefix = "^6[Subpens]^7 ";
    self iprintln(prefix + msg);
}

RoomCountDown(weapon)
{
    self FreezeControls(true);
    self SetOrigin(self.origin + (0,0,20));
    self iprintlnBold("^13");
    wait 1;
    self iprintlnBold("^62");
    wait 1;
    self iprintlnBold("^51");
    wait 1;
    self iprintlnBold("^2GO!");
    self FreezeControls(false);
    wait 0.1;
    self SwitchToWeapon(weapon); 
}

Jail()
{
    self FreezeControls(true);
    self SetOrigin(self.origin + (0,0,40));
    wait 15;
    self FreezeControls(false);
}

GiveWeaponFn(weapon)
{
    self GiveWeapon(weapon);
    self GiveMaxAmmo(weapon);
    wait 0.1;
    self switchToWeapon(weapon);
}

// Fx
EnableFire()
{
    fx1 = GetEnt("fx1", "targetname");
    playLoopedFX ( level._effect[ "tank_fire_hatch" ], 1, fx1.origin);

    fx2 = GetEnt("fx2", "targetname");
    playLoopedFX ( level._effect[ "gas_pump_fire" ], 1, fx2.origin);

    fx3 = GetEnt("fx3", "targetname");
    playLoopedFX ( level._effect[ "tank_fire_hatch" ], 1, fx3.origin);

    fx4 = GetEnt("fx4", "targetname");
    playLoopedFX ( level._effect[ "tank_fire_hatch" ], 1, fx4.origin);

    fx5 = GetEnt("fx5", "targetname");
    playLoopedFX ( level._effect[ "tank_fire_hatch" ], 1, fx5.origin);

    fx6 = GetEnt("fx6", "targetname");
    playLoopedFX ( level._effect[ "tank_fire_hatch" ], 1, fx6.origin);

    fx7 = GetEnt("fx7", "targetname");
    playLoopedFX ( level._effect[ "tire_fire_med" ], 1, fx7.origin);
}