local QBCore = exports['qb-core']:GetCoreObject()

local function SendToDiscord(playerId, playerName, playerMoney, playerIdentifiers)
    if not Config.EnableDiscordLog then return end
    
    local playerBank = 0
    local playerCash = 0
    
    if playerMoney.bank then playerBank = playerMoney.bank end
    if playerMoney.cash then playerCash = playerMoney.cash end
    
    local totalMoney = playerBank + playerCash
    
    local embed = {
        {
            ["color"] = Config.WebhookColor,
            ["title"] = "⚠️ تم اكتشاف مبلغ مشبوه ⚠️",
            ["description"] = "تم العثور على مبلغ يتجاوز الحد المسموح به.",
            ["fields"] = {
                {
                    ["name"] = "🔹 اسم اللاعب",
                    ["value"] = playerName,
                    ["inline"] = true
                },
                {
                    ["name"] = "🆔 رقم اللاعب",
                    ["value"] = playerId,
                    ["inline"] = true
                },
                {
                    ["name"] = "💵 المبلغ الكلي",
                    ["value"] = totalMoney .. "$",
                    ["inline"] = false
                },
                {
                    ["name"] = "💳 مبلغ البنك",
                    ["value"] = playerBank .. "$",
                    ["inline"] = true
                },
                {
                    ["name"] = "💰 مبلغ الكاش",
                    ["value"] = playerCash .. "$",
                    ["inline"] = true
                },
                {
                    ["name"] = "🪪 معرفات اللاعب",
                    ["value"] = "```" .. json.encode(playerIdentifiers, { indent = true }) .. "```",
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "Anti-Money Exploit | " .. os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }
    
    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end

local function ResetPlayerMoney(playerId)
    if not Config.EnableMoneyReset then return end
    
    local xPlayer = QBCore.Functions.GetPlayer(playerId)
    if xPlayer then
        xPlayer.Functions.SetMoney('bank', 0)
        xPlayer.Functions.SetMoney('cash', 0)
    end
end

local function KickPlayer(playerId)
    if not Config.EnableKick then return end
    
    DropPlayer(playerId, Config.KickMessage)
end

RegisterNetEvent('QBCore:Server:PlayerLoaded')
AddEventHandler('QBCore:Server:PlayerLoaded', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    
    if not xPlayer then return end
    
    local playerMoney = {
        bank = xPlayer.PlayerData.money["bank"] or 0,
        cash = xPlayer.PlayerData.money["cash"] or 0
    }
    
    local totalMoney = playerMoney.bank + playerMoney.cash
    
    if totalMoney >= Config.MaxMoney then
        local identifiers = {
            steam = xPlayer.PlayerData.license,
            license = xPlayer.PlayerData.license,
            discord = xPlayer.PlayerData.discord,
            ip = GetPlayerEndpoint(src),
            name = GetPlayerName(src)
        }
        
        SendToDiscord(src, GetPlayerName(src), playerMoney, identifiers)
        
        ResetPlayerMoney(src)
        
        KickPlayer(src)
        
        print("^1[ANTI-MONEY EXPLOIT] ^3تم العثور على مبلغ مشبوه لدى اللاعب: " .. GetPlayerName(src) .. " (" .. src .. ") | المبلغ: " .. totalMoney .. "$^7")
    end
end)

RegisterNetEvent('QBCore:Server:OnMoneyChange')
AddEventHandler('QBCore:Server:OnMoneyChange', function(source, moneyType, amount, operation)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    
    if not xPlayer then return end
    
    Wait(500)
    
    local playerMoney = {
        bank = xPlayer.PlayerData.money["bank"] or 0,
        cash = xPlayer.PlayerData.money["cash"] or 0
    }
    
    local totalMoney = playerMoney.bank + playerMoney.cash
    
    if totalMoney >= Config.MaxMoney then
        local identifiers = {
            steam = xPlayer.PlayerData.license,
            license = xPlayer.PlayerData.license,
            discord = xPlayer.PlayerData.discord,
            ip = GetPlayerEndpoint(src),
            name = GetPlayerName(src)
        }
        
        SendToDiscord(src, GetPlayerName(src), playerMoney, identifiers)
        
        ResetPlayerMoney(src)
        
        KickPlayer(src)
        
        print("^1[ANTI-MONEY EXPLOIT] ^3تم العثور على مبلغ مشبوه لدى اللاعب: " .. GetPlayerName(src) .. " (" .. src .. ") | المبلغ: " .. totalMoney .. "$^7")
    end
end)
