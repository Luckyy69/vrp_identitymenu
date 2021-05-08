--[[
Made by
  _      _    _   _____  _  ____     ____     __ 
 | |    | |  | | / ____|| |/ /\ \   / /\ \   / /
 | |    | |  | || |     | ' /  \ \_/ /  \ \_/ /
 | |    | |  | || |     |  <    \   /    \   /  
 | |____| |__| || |____ | . \    | |      | | 
 |______|\____/  \_____||_|\_\   |_|      |_|          
                                                
--]]

HT = nil
Citizen.CreateThread(function()
    while HT == nil do
        TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
        Citizen.Wait(0)
    end
end)

function mainMenu()
    local elements = {
        { label = "Identitet", value = "identity"},
        { label = "Penge", value = "money" },
        { label = "Tilstand", value = "health" },
        { label = "Luk", value = "close" },
    }
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "idk",
        {
            title    = "Identitet Menu",
            align    = "center",
            elements = elements
        },
    function(data, menu)
        if(data.current.value == 'identity') then
            TriggerServerEvent('GetIdentity')
        end
        if(data.current.value == 'money') then
            TriggerServerEvent('Money:GetMoney')
        end
        if(data.current.value == 'health') then
            TriggerServerEvent('getHunger')
        end
        if(data.current.value == 'close') then
             menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

RegisterCommand('identity', function()
    mainMenu()
end)

RegisterNetEvent("getHealth")
AddEventHandler("getHealth", function(rHunger, rThirst)
    local health = GetEntityHealth(GetPlayerPed(-1))
    local armor = GetPedArmour(PlayerPedId())
    local oxygen = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
    local hunger = rHunger
    local thirst = rThirst
    healthMenu(health, armor, oxygen, hunger, thirst)
end)

RegisterNetEvent("GetMoney")
AddEventHandler("GetMoney", function(bank, wallet, mymoney)
    moneyMenu(bank, wallet, mymoney)
end)

RegisterNetEvent("Client:Identity")
AddEventHandler("Client:Identity", function(firstname, name, age, phone, user_id)
    identityMenu(firstname, name, age, phone, user_id)
end)

function moneyMenu(wallet, bank)
    local elements = {
        { label = "Bank: "..bank..",-"},
        { label = "Wallet: "..wallet},
        { label = "Luk", value = "close" },
    }
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "idk",
        {
            title    = "Penge",
            align    = "center",
            elements = elements
        },
    function(data, menu)
        if(data.current.value == 'close') then
             menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function identityMenu(firstname, name, age, phone, user_id)
    local elements = {
        { label = "Fornavn: "..firstname},
        { label = "Efternavn: "..name},
        { label = "Alder: "..age},
        { label = "Telefonnummer: "..phone},
        { label = "Id: "..user_id},
        { label = "Luk", value = "close" },
    }
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "idk",
        {
            title    = "Identitet",
            align    = "center",
            elements = elements
        },
    function(data, menu)
        if(data.current.value == 'close') then
             menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end


function healthMenu(health, armor, oxygen, hunger, thirst)
    local elements = {
        { label = "Liv: "..health},
        { label = "Armor: "..armor},
        { label = "Oxygen: "..oxygen},
        { label = "Sult: "..hunger},
        { label = "Tørst: "..thirst},
        { label = "Luk", value = "close" },
    }
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "idk",
        {
            title    = "Tilstand",
            align    = "center",
            elements = elements
        },
    function(data, menu)
        if(data.current.value == 'money') then
            TriggerEvent('Car:Start')
        end
        if(data.current.value == 'give') then
            TriggerServerEvent('giveCard')
        end
        if(data.current.value == 'close') then
            mainMenu()
        end
    end, function(data, menu)
        menu.close()
    end)
end