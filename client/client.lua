ESX = exports["es_extended"]:getSharedObject() 

lib.locale()

CreateThread(function()
    for k,v in pairs(Config.NPC) do
        ModelloHash = GetHashKey(v.Modello)
        RequestModel(ModelloHash)
        while not HasModelLoaded(ModelloHash) do
            Wait(1)
        end

        ped_creato = CreatePed(0, ModelloHash , v.Pos, v.Heading, v.NetworkSync)
        FreezeEntityPosition(ped_creato, true)
        SetEntityInvincible(ped_creato, true)
        SetBlockingOfNonTemporaryEvents(ped_creato, true)
    end
end)

CreateThread(function()
    for k,v in pairs(Config.NPC) do
        if v.Blip.display then
            print(k)
            blip = AddBlipForCoord(v.Pos)
            SetBlipSprite(blip, v.Blip.type)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.Blip.grandezza)
            SetBlipColour(blip, v.Blip.colore)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Blip.nome)
            EndTextCommandSetBlipName(blip)
        end
    end
end)


CreateThread(function()
    local testo = false
    local Sleep
    while true do 
        Sleep = 500
        if ESX.IsPlayerLoaded() then
            for k,v in pairs(Config.NPC) do
                local dist = #(GetEntityCoords(cache.ped)-(type(v.Pos) == type(vector3(0,0,0)) and v.Pos or 0))
                if dist < 5.0 then
                    Sleep = 0
                    if not testo then
                        ESX.ShowHelpNotification(locale('parla')..v.Nome)
                        -- lib.showTextUI("[E] - Per parlare con "..v.Nome)
                        testo = true
                    end
                    if dist < 2.0 then
                        if IsControlJustReleased(0, 38) then
                            ShopMain(k, v.Nome)
                        end
                    end
                else
                    testo = false
                    -- lib.hideTextUI()
                end
            end
        end
        Wait(Sleep)
    end
end)



ShopMain = function(zona, nome)
    local items = {}
    for i=1, #Config.NPC[zona].Items, 1 do
        local item = Config.NPC[zona].Items[i]
        table.insert(items, {
            title = item.label,
            description = locale('prezzo')..item.price,
            onSelect = function(args)
                print(item.label)
                CompraRoba(item.price, item.value)
            end,
        })
    end

    for k, v in pairs(Config.NPC) do
        lib.registerContext({
            id = "Shop-Main",
            title = locale("shopdi")..nome,
            options = {
                {
                    title = locale("titolo-npc"),
                    menu = 'Item-Shop',
                    description = locale("aprinegozio")..nome,
                    metadata = {'It also has metadata support'},
                },
            },
            {
                id = 'Item-Shop',
                title = locale("titolo-negozio")..nome,
                menu = 'Shop-Main',
                options = items
            }
        })
        lib.showContext("Shop-Main")
    end
end


CompraRoba = function(prezzo, item)
    local alert = lib.alertDialog({
        header = locale("conferma")..item,
        content = locale("item")..item .. ", " ..locale("prezzo")..prezzo,
        centered = true,
        cancel = true
    })
    
    if alert == "confirm" then
        TriggerServerEvent("ars-shop-npc:compraRoba", prezzo, item)
    else
        print("niente bro")
    end
end
