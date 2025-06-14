Config = {}

Config.Admins = {
    ["license:abc123"] = true
}

Config.Messages = {
    ["Console"] = "%s - (%d) a été banni du serveur [%s]",
    ["Client"] = "Vous avez été banni du serveur.\nRaison : %s",
    ["Cooldown"] = "Spam détecté sur le trigger %s",
    ["Args"] = "Nombre d'arguments incorrect sur le trigger %s",
    ["Admin"] = "Groupe incorrect pour le trigger %s",
    ["Zone"] = "Zone d'exécution incorrecte sur le trigger %s",
    ["MaxCalls"] = "Trop d'appels sur le trigger %s"
}

-- ESX : Vérifier le groupe, le métier, l'argent, l'inventaire, les armes

Config.Triggers = {
    ["thomapp_admin:server"] = {
        Cooldown = 500,
        Args = 0,
        Admin = false,
        Zone = { Coords = vector3(0, 0, 0), MaxDistance = 10 },
        MaxCalls = { Count = 5, Interval = 10000 }
    }
}
