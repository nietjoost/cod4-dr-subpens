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

    //level thread music();
    level thread messages();
    level thread startdoor();

    // Traps functions
    level thread SetupTrap1();
    level thread SetupTrap2();
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

    // Start trap
    player iprintln("You activated trap 2");
    player braxi\_rank::giveRankXP("trap_activation");

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