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

	thread messages();
	thread startdoor();
}

messages()
{
    wait 10;
    iprintlnBold("^1Welcome to Sub Pens");
    wait 1;
}

startdoor()
{
    lootje = getent("startdoor","targetname");
    {
        wait 15;
        lootje moveZ(-400, 5);
        iprintlnbold("^8Start door opened.");
        wait 2;
    }
}
