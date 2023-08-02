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

    // Custom vars
    level.door_old = false;
    level.player_in_room = false;

    // Precache
    level._effect[ "frag_exp" ]	= loadfx( "explosions/grenadeExp_dirt" );

    //level thread music();
    level thread messages();
    level thread startdoor();

    // Traps functions
    level thread SetupTrap1();
    level thread SetupTrap2();
    level thread SetupTrap3();
    level thread SetupTrap4();
    level thread SetupTrap5();
    
    // Room functions
    level.doorSniperTrigger = GetEnt("roomSniperTrigger", "targetname");

    level thread SetupOldRoom();
    level thread SetupSniperRoom();

    // Teleport function
    level thread teleportpos1to2();
    level thread teleportpos2to1();
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
        wait duration;

        trap5Object1 moveZ(-200, duration);
        wait duration;

        wait duration;

  		trap5Object1 rotateYaw(360,duration);
		wait ((duration)-0.1);

        wait 3;
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
    level.doorSniperTrigger delete();

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
    level.doorSniperTrigger waittill("trigger", player);
    level.player_in_room = true;
    
    // Check old to be sure
    if (level.door_old)
        return;

    // Message
    iprintlnBold("^5" + player.name + " ^7has chosen the room ^1SNIPER");
    player PlayerMessage("You have chosen the room ^1SNIPER");

    // Start sniper room
    player SetOrigin(sniperspawn1.origin);
    player setplayerangles(sniperspawn1.angles);
    player TakeAllWeapons();
    player GiveWeapon("m40a3_mp");
    player GiveWeapon( "remington700_mp" ); 
    player GiveMaxAmmo("m40a3_mp");
    player GiveMaxAmmo( "remington700_mp" );
    wait .05;
    player SwitchToWeapon("m40a3_mp");  
    wait(0.05);
    //level.activ SetOrigin (sniperspawn2.origin);
    //level.activ setplayerangles (sniperspawn2.angles);
    //level.activ TakeAllWeapons();
    //level.activ GiveWeapon("m40a3_mp");
    //level.activ GiveWeapon("remington700_mp");
    //level.activ GiveMaxAmmo("m40a3_mp");
    //level.activ GiveMaxAmmo("remington700_mp");
    wait .05;
    //level.activ SwitchToWeapon("m40a3_mp");  
    wait(0.05);
    player switchToWeapon( "m40a3_mp" );
    //level.activ SwitchToWeapon( "m40a3_mp" );

    // Reset room
    player waittill( "death" );
    level.player_in_room = false;
    level thread SetupSniperRoom();
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


// Utils functions
PlayerMessage(msg)
{
    prefix = "^6[Subpens]^7 ";
    self iprintln(prefix + msg);
}