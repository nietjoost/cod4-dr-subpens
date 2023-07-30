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

    // Precache
    level._effect[ "frag_exp" ]	= loadfx( "explosions/grenadeExp_dirt" );

    //level thread music();
    level thread messages();
    level thread startdoor();

    // Traps functions
    level thread SetupTrap1();
    level thread SetupTrap2();
    level thread SetupTrap3();
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
		wait ((duration)-0.1);
        wait 1;

        trap3Object2 rotateRoll(360,duration);
		wait ((duration)-0.1);
        wait 1;

        trap3Object3 rotateRoll(360,duration);
		wait ((duration)-0.1);

        trap3Object4 rotateRoll(360,duration);
		wait ((duration)-0.1);
        wait 1;
	}
}


// Utils functions
PlayerMessage(msg)
{
    prefix = "^6[Subpens]^7 ";
    self iprintln(prefix + msg);
}