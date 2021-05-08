--[[
Made by
  _      _    _   _____  _  ____     ____     __ 
 | |    | |  | | / ____|| |/ /\ \   / /\ \   / /
 | |    | |  | || |     | ' /  \ \_/ /  \ \_/ /
 | |    | |  | || |     |  <    \   /    \   /  
 | |____| |__| || |____ | . \    | |      | | 
 |______|\____/  \_____||_|\_\   |_|      |_|          
                                                
--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "Luckyy er lækker") 
vRP = Proxy.getInterface("vRP")

HT = nil

TriggerEvent('HT_base:getBaseObjects', function(obj) 
    HT = obj 
end)

RegisterServerEvent("Money:GetMoney")
AddEventHandler("Money:GetMoney", function()
    local source = source
    local user_id = vRP.getUserId({source})
    local bank = vRP.getBankMoney({user_id})
    local wallet = vRP.getMoney({user_id})
    TriggerClientEvent("GetMoney", source, wallet, bank)
end)

RegisterServerEvent("GetIdentity")
AddEventHandler("GetIdentity", function()
    local source = source
    local user_id = vRP.getUserId({source})
    MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities", {}, function(result)
        TriggerClientEvent('Client:Identity', source, result[1].firstname, result[1].name, result[1].age, result[1].phone, result[1].user_id)
    end)
end)

RegisterServerEvent("getHunger")
AddEventHandler("getHunger", function()
    local source = source
    local user_id = vRP.getUserId({source})
    TriggerClientEvent("getHealth", source, vRP.getHunger({user_id}), vRP.getThirst({user_id}))
end)