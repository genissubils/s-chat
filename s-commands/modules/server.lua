ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function getIdentity(source)
	
	local identifier = GetPlayerIdentifiers(source)[1]
	
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	
	if result[1] ~= nil then
		
		local identity = result[1]

		return {
			
			identifier = identity['identifier'],
			
			firstname = identity['firstname'],
			
			lastname = identity['lastname'],
			
			job = identity['job'],
			
			dateofbirth = identity['dateofbirth'],
			
			sex = identity['sex'],
			
			height = identity['height'],
			
			permission_level = identity['permission_level']
		}
	else
		return nil
	end
end

RegisterCommand('mp', function(source, args, rawCommand)  
	if source == 0 then
		return
	end	
	if tonumber(args[1]) and args[2] then	
		local id=tonumber(args[1])	
		msg = table.concat(args, ' ', 2)	 
		local name =  GetPlayerName(source)
		local nombre =  GetPlayerName(id)	
		local characterName = GetCharacterName(source)	
		name = '' .. source .. ' '.. name
		local xPlayers = ESX.GetPlayers()	
		local target = ESX.GetPlayerFromId(id)
		if(target ~= nil) then	   
			TriggerClientEvent('chat:addMessage', id, {	
				template = '<div style="font-size: 1.5vh;"> <b> <b style=color:#ffe180>(( Mensaje Privado )) |<b style=color:#ffe180> ID {1}:<b style=color:#ffffff> {2}  </br></div>',	
				args = { fal, name, msg }
			})
			TriggerClientEvent('chat:addMessage', source, {	
				template = '<div style="font-size: 1.5vh; "> <b> <b style=color:#ffe180>(( Mensaje Privado )) |<b style=color:#ffe180> ID {1}:<b style=color:#ffffff> {2}  </br></div>',	
				args = { fal, name, msg }	
			})			
		else
		--	ESX.ShowNotification('NoPhase Advertencia', 'No estás usando de forma correcta el comando.', 5000 )	
		end
	else
	--	TriggerClientEvent('esx:shownotification', 'NoPhase Advertencia', 'No estás usando de forma correcta el comando.', 5000 )	
	end
end, false)

RegisterCommand('duda', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.DisableesxIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('duda_prefix', source), "(( " .. args .. " ))"}, color = { 17,127,128 } })
end, false)

RegisterCommand('f', function(source, args, rawCommand)
    if source == 0 then
        print("s-commands: you can't use this command from rcon!")
        return
    end
	local AllPlayers = ESX.GetPlayers()
    local xLocalPlayer = ESX.GetPlayerFromId(source)
    if xLocalPlayer.job ~= nil then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		if xLocalPlayer.job.name == "police" then
			for k,v in ipairs(AllPlayers) do
				local p = ESX.GetPlayerFromId(v)
				local grade = xLocalPlayer.job.grade_label
				if p.job ~= nil and p.job.name == "police" then
					TriggerClientEvent('chat:addMessage', v, { args = { _U('rpol_prefix', name ..  " | " .. grade), args }, color = { 51, 109, 255} })
				end
			end
		 elseif xLocalPlayer.job.name == "mechanic" then
				for k,v in ipairs(AllPlayers) do
					local p = ESX.GetPlayerFromId(v)
					local grade = xLocalPlayer.job.grade_label
					if p.job ~= nil and p.job.name == "mechanic" then
						TriggerClientEvent('chat:addMessage', v, { args = { _U('rmec_prefix', name ..  " | " .. grade), args }, color = { 125, 125, 125 } })
					end
				end
			elseif xLocalPlayer.job.name == "tendero" then
				for k,v in ipairs(AllPlayers) do
					local p = ESX.GetPlayerFromId(v)
					local grade = xLocalPlayer.job.grade_label
					if p.job ~= nil and p.job.name == "tendero" then
						TriggerClientEvent('chat:addMessage', v, { args = { _U('rtendero_prefix', name ..  " | " .. grade), args }, color = { 61, 196, 61 } })
					end
				end
		elseif xLocalPlayer.job.name == "taxi" then
			for k,v in ipairs(AllPlayers) do
				local p = ESX.GetPlayerFromId(v)
				local grade = xLocalPlayer.job.grade_label
				if p.job ~= nil and p.job.name == "taxi" then
					TriggerClientEvent('chat:addMessage', v, { args = { _U('rtaxi_prefix', name ..  " | " .. grade), args }, color = { 255, 227, 51 } })
				end
			end
		elseif xLocalPlayer.job.name == "sheriff" then
			for k,v in ipairs(AllPlayers) do
				local p = ESX.GetPlayerFromId(v)
				local grade = xLocalPlayer.job.grade_label
				if p.job ~= nil and p.job.name == "sheriff" then
					TriggerClientEvent('chat:addMessage', v, { args = { _U('rsheriff_prefix', name ..  " | " .. grade), args }, color = { 214, 146, 58 } })
				end
			end
		elseif xLocalPlayer.job.name == "taxi" then
			for k,v in ipairs(AllPlayers) do
				local p = ESX.GetPlayerFromId(v)
				local grade = xLocalPlayer.job.grade_label
				if p.job ~= nil and p.job.name == "taxi" then
					TriggerClientEvent('chat:addMessage', v, { args = { _U('rmili_prefix', name ..  " | " .. grade), args }, color = { 47, 181, 31 } })
				end
			end
        elseif xLocalPlayer.job.name == "ambulance" then
            for k,v in ipairs(AllPlayers) do
				local p = ESX.GetPlayerFromId(v)
				local grade = xLocalPlayer.job.grade_label
                if p.job ~= nil and p.job.name == "ambulance" then
                    TriggerClientEvent('chat:addMessage', v, { args = { _U('rems_prefix', name ..  " |  " .. grade), args }, color =  { 255, 71, 71 } })
                end
            end
        end
    end
end, false)

RegisterCommand('ff', function(source, args, rawCommand)
    if source == 0 then
        return
    end
	local AllPlayers = ESX.GetPlayers()
    local xLocalPlayer = ESX.GetPlayerFromId(source)
    if xLocalPlayer.job ~= nil then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		if xLocalPlayer.job.name == "police" or xLocalPlayer.job.name == "sheriff" then
            for k,v in ipairs(AllPlayers) do
                local p = ESX.GetPlayerFromId(v)
                local grade = xLocalPlayer.job.label
                if p.job ~= nil and p.job.name == "police" or p.job.name == "sheriff" then
                    TriggerClientEvent('chat:addMessage', v, { args = { _U('rsapd_prefix', grade ..  " | " .. name), args }, color = { 51, 109, 255} })
                end
            end
		end
    end
end, false)

RegisterCommand('ffr', function(source, args, rawCommand)
    if source == 0 then
        return
    end
	local AllPlayers = ESX.GetPlayers()
    local xLocalPlayer = ESX.GetPlayerFromId(source)
    if xLocalPlayer.job ~= nil then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		if xLocalPlayer.job.name == "police" or xLocalPlayer.job.name == "taxi" or xLocalPlayer.job.name == "ambulance" then
            for k,v in ipairs(AllPlayers) do
                local p = ESX.GetPlayerFromId(v)
                local grade = xLocalPlayer.job.label
                if p.job ~= nil and p.job.name == "police" or p.job.name == "sheriff" or p.job.name == "ambulance" then
                    TriggerClientEvent('chat:addMessage', v, { args = { _U('remergency_prefix', grade ..  " | " .. name), args }, color = { 173, 36, 36} })
                end
            end
		end
    end
end, false)

RegisterCommand('chatmessageent', function(source, args, rawCommand)
	if source == 0 then
		print('s-commands: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('s-commands:sendProximityMessage', -1, source, name, 'entorno', args)
end, false)
 
  function stringsplit(inputstr, sep)
	  if sep == nil then
		  sep = "%s"
	  end
	  local t={} ; i=1
	  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		  t[i] = str
		  i = i + 1
	  end
	  return t
  end

  -- Proximity commands
  RegisterCommand('b', function(source, args, rawCommand)
	if source == 0 then
		print('s-commands: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('s-commands:sendProximityMessage', -1, source, name, 'b', args)
end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('s-commands: you can\'t use this command from rcon!')
		return
	end
	local playerped = GetPlayerPed(source)
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('s-commands:sendProximityMessage', -1, source, name, 'me', args)
end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('s-commands: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('s-commands:sendProximityMessage', -1, source, name, 'do', args)
end, false)

RegisterCommand('g', function(source, args, rawCommand)
	if source == 0 then
		print('s-commands: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('s-commands:sendProximityMessage', -1, source, name, 'gritar', args)
end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})	
	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)	
		end	
	else	
		return GetPlayerName(source)	
	end
end


