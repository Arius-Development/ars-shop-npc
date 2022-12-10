Config = {}

Config.NPC = {
    ["shop2"] = {
        Pos = vector3(246.68, -664.56, 37.32),
        Heading = 0.0,
        Nome = "testing",
        Modello = "a_f_m_ktown_02",
        Blip = {
            display = false,
            type = 102,
            grandezza = 0.8,
            colore = 2,
            nome = "downismo",
        },
        Items = {
            { label = "Hamburguesa", value = "burger", price = 20 },
            { label = "Agua", value = "water", price = 12 },
            { label = "Chaleco Antibalas", value = "armour", price = 1231 },
        }
    },
    ["shop3"] = {
        Pos = vector3(159.44, -793.24, 31.12),
        Heading = 0.0,
        Nome = "testing",
        Modello = "a_f_m_ktown_02",
        Blip = {
            display = true,
            type = 102,
            grandezza = 0.8,
            colore = 2,
            nome = "downismo",
        },
        Items = {
            { label = "Hamburguesa", value = "burger", price = 20 },
            { label = "water", value = "water", price = 12 },
            { label = "armour", value = "armour", price = 1231 },
        }
    },
}
