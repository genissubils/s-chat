ESX = nil
nivel = 5
TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:removeTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('sharingan_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('onResourceStart', function(resource)
	while(ESX == nil)do
		Wait(100)
	end
	if resource == GetCurrentResourceName() then
        MySQL.Async.fetchAll('SELECT nivel FROM alertas', {}, function(result)
            nivel = result[1].nivel
        end)
	end
end)

AddEventHandler('sharingan_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end

end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

AddEventHandler('playerDropped', function(reason)
    -- TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' ('.. source ..') ha salido de la ciudad. (' .. reason .. ')')
end)

-- RegisterCommand('say', function(source, args, rawCommand)
--     TriggerClientEvent('chatMessage', -1, (source == 0) and 'console' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
-- end)

RegisterServerEvent('esx_alertas:triggered')
AddEventHandler('esx_alertas:triggered', function(typeof)
    TriggerClientEvent("esx_alertas:setalerta", -1, typeof)
    MySQL.Async.fetchAll("UPDATE alertas SET nivel = @nivel WHERE identificador = @identificador",{
        ['@identificador'] = 1,
        ['@nivel'] = typeof
    })
    nivel = typeof
end)




AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)
