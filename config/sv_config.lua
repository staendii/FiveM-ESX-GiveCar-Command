Config = {}

Config.SecurityToken = "aosijdAoijj12098" -- You can change it so noone can give Cars using the Event

Config.AllowedGroups = { -- Groups that can use the Command
    "admin"
}

Config.Command = "givecar" -- The Command to use

Config.PlateFormat = "5L " ..math.random(1, 99999) -- The default Plate when no Plate is given

Config.CustomBanFunction = function (id, reason) -- The Function to Drop/Ban the Player when an invalid Token is provided
    print("Kicked Player due to Exploit! Name: " ..GetPlayerName(id).. "(" ..id.. ")")
    DropPlayer(id, reason)
end