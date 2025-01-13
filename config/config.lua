return {
    debug = false,
    restrictIfNotFound = false,                                   -- [WARNING] If true, any vehicle not configured will be restricted.
    deleteOnRestrict = false,                                     -- Otherwise we kick the player out of the vehicle. (Will always delete if the vehicle was just spawned)
    restrictMessage = 'You are not allowed to use this vehicle.', -- Default message to show when access is denied. You can override this in the vehicleConfig.lua file.

    checkNumberPlates = true,                                     -- Whether to check number plates for bad words.
    -- List of bad words on number plates.
    badWords = {
        "nigger", "nigga", "nibba", "nibber", "nigaa", "n1gga", "n1gger", "n1ga", "nigar", "nigg3r", "nigg@",
        "chink", "ch1nk", "chinck", "chynk", "cynk",
        "spic", "sp1c", "sp!c", "spik", "spyk",
        "wetback", "w3tback", "w3tb@ck",
        "faggot", "fag", "f4g", "f@g", "fa66ot", "f@ggot", "fagget",
        "retard", "r3tard", "r3t@rd", "rehtard", "r3t4rd",
        "nazi", "naz1", "n4zi", "n4z1", "nazee", "n@zi", "hitler", "h1tler", "h!tler", "heil", "seig", "sieg",
        "coon", "c00n", "k00n", "kuhn", "c0on",
        "jigaboo", "jiggaboo", "j1gaboo", "j!gaboo",
        "towelhead", "t0welhead", "towelh3ad",
        "sandnigger", "sandnigga", "s4ndnigger", "sandn1gga",
        "pak1", "paki", "pak1stani", "p@ki",
    }

}
