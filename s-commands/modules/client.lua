ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

TriggerEvent("chat:addSuggestion", "/msg", 'Enviar mensaje privado a un jugador')

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
	TriggerEvent('s-commands:sendProximityMessage', -1, id, _U('oop_prefix', id), message, { 128, 128, 128 })

    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('s-commands:sendProximityMessage', -1, id, _U('oop_prefix', id), message, { 128, 128, 128 })
    end
end)

local font = 0 
local time = 500 
local msgQueue = {}

RegisterNetEvent('s-commands:drawOnHead')
AddEventHandler('s-commands:drawOnHead', function(text, color, source)
    Display(GetPlayerFromServerId(source), text, color)
end)

function Display(mePlayer, text, color)
	local timer = 0
	if msgQueue[mePlayer] == nil then
		msgQueue[mePlayer] = {}
    end
	table.insert(msgQueue[mePlayer], { txt = text , c= color, tim = 0 })
    while tablelength(msgQueue[mePlayer]) > 0 do
        Wait(0)
        timer = timer + 1
		local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
		local lineNumber = 1
		for k, v in pairs(msgQueue[mePlayer]) do
			DrawText3D(coords['x'], coords['y'], coords['z']+lineNumber, v.txt, v.c)
			lineNumber = lineNumber + 0.12
			if(v.tim > time)then
				msgQueue[mePlayer][k] = nil
			else
				v.tim= v.tim + 1
			end
		end
    end
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
  end

function DrawText3D(x,y,z, text, color)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.35*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

RegisterNetEvent('s-commands:setGroup')
AddEventHandler('s-commands:setGroup', function(g)
    group = g
end)

RegisterNetEvent('s-commands:sendProximityMessageooc')
AddEventHandler('s-commands:sendProximityMessageooc', function(playerId, title, message, color, name)
	local target = GetPlayerFromServerId(playerId)
	if target == nil or target == -1 then
		return
	end

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
	local distance = #(sourceCoords - targetCoords)
	if target ~= nil and target == player or distance < 12 or (NetworkIsInSpectatorMode() and distance < 20) then
			if message ~= nil then
				TriggerEvent("chat:addMessage", {args = {title, message}, color = color})
			else
				TriggerEvent("chat:addMessage", {args = {title}, color = color})
			end
	end
end)

RegisterNetEvent('s-commands:sendProximityMessage')
AddEventHandler('s-commands:sendProximityMessage', function(playerId, name, title, message, color)
	local target = GetPlayerFromServerId(playerId)
	if target == nil or target == -1 then
		return
	end

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
	local distance = #(sourceCoords - targetCoords)
	if target ~= nil and target == player or distance < 12 or (NetworkIsInSpectatorMode() and distance < 20) then
		if title == "me" then
			TriggerEvent('chat:addMessage', {
				template = '<div class="me_box">{0}:  <span>'.. message ..'</span></div>',
				args = { name, message }
			})
		elseif title == "do" then
			TriggerEvent('chat:addMessage', {
				template = '<div class="do_box">{0}: <span>'.. message ..'</span></div>',
				args = { "[" .. name .. "]", message }
			})
		elseif title == "b" then
            TriggerEvent('chat:addMessage', {
                template = '<div class="b_box">{0}: <span>'.. message ..'</span></div>',
                args = { name ..   " dice", message }
			})
		elseif title == "gritar" then
            TriggerEvent('chat:addMessage', {
                template = '<div class="g_box">{0}: <span>'.. message ..'</span></div>',
                args = { name ..   " grita", message }
			})
		elseif title == "entorno" then
            TriggerEvent('chat:addMessage', {
                template = '<div class="entorno_box">{0}: <span>'.. message ..'</span></div>',
                args = { "(Entorno) | " .. playerId,   message }
			})
		else
			if message ~= nil then
				TriggerEvent("chat:addMessage", {args = {title, message}, color = color})
			else
				TriggerEvent("chat:addMessage", {args = {title}, color = color})
			end
		end
	end
end)

RegisterNetEvent('s-commands:sendProximityMessageRoll')
AddEventHandler('s-commands:sendProximityMessage', function(playerId, title, message, color)
    local target = GetPlayerFromServerId(playerId)
    if target == nil or target == -1 then
        return
    end
    local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
    local distance = #(sourceCoords - targetCoords)

end)

RegisterNetEvent('sendProximityMessageRoll')
AddEventHandler('sendProximityMessageRoll', function(id, name, num)

    local target = GetPlayerFromServerId(id)
    if target == nil or target == -1 then
        return
    end
    local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
    local distance = #(sourceCoords - targetCoords)
    if target ~= nil and target == player or distance < 8 or (NetworkIsInSpectatorMode() and distance < 20) then
		TriggerEvent('chat:addMessage', {
			template = '<div class="dados_box">{0}:  <span>'.. num ..'</span></div>',
			args = { "[🎲] " .. name .. " Ha lanzado los dados y ha sacado un" }
		})
    end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('chat:removeSuggestion', '/twt')
		TriggerEvent('chat:removeSuggestion', '/me')
		TriggerEvent('chat:removeSuggestion', '/do')
	end
end)


