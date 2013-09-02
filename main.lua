--MyWarps--
--Based on Mcrainbow by Kwen--

--SETTINGS--
change_gm_when_changing_world = true
clear_inv_when_going_from_creative_to_survival = false
--SETTINGS--

jails = {}

function Initialize(Plugin)
    Plugin:SetName( "Jailed" )
    Plugin:SetVersion( 1 )
	
	PluginManager = cRoot:Get():GetPluginManager()
	PluginManager:BindCommand("/jail",           	 "jail.jail",      	    HandleJailCommand,      		  " - Jails a player.");
	PluginManager:BindCommand("/setjail",            "jail.setjail",     	    HandleSetJailCommand,   		  " - Creates a jail at players location.");
	PluginManager:BindCommand("/deljail",            "jail.deljail",            HandleDelJailCommand,        	  " - Deletes a jail.");
	PluginManager:BindCommand("/jails",         	 "jail.listjail",           HandleListJailCommand,            " - Lists all jails.");
	
	
	local jailsINI = cIniFile("jails.ini")
	if ( jailsINI:ReadFile() == true ) then
		jailNum = jailsINI:GetNumKeys();
		for i=0, jailNum do
			local Tag = jailsINI:GetKeyName(i)
			jails[Tag] = {}
			jails[Tag]["w"] = jailsINI:GetValue( Tag , "w")
			jails[Tag]["x"] = jailsINI:GetValueI( Tag , "x")
			jails[Tag]["y"] = jailsINI:GetValueI( Tag , "y")
			jails[Tag]["z"] = jailsINI:GetValueI( Tag , "z")
		end
    end
	return true
end

function HandleJailCommand( Split, Player )
	local UsersIni = cIniFile("users.ini")
	if UsersIni:ReadFile() == false then
		LOG( "Could not read users.ini!" )
	end
	if #Split < 2 and #Split < 3 then
		HandleListJailCommand( Split, Player )
		return true
	end
	if #Split < 2 or #Split < 3  then
		Player:SendMessage('Usage:/jail [player] [jail]')
		return true
	end
	local Tag = Split[3]

      Jailed = false
      local JailPlayer = function(OtherPlayer)
		if (OtherPlayer:GetName() == Split[2]) then
	          if (OtherPlayer:GetWorld():GetName() ~= jails[Tag]["w"]) then
	              OtherPlayer:TeleportToCoords( jails[Tag]["x"] + 0.5 , jails[Tag]["y"] , jails[Tag]["z"] + 0.5)
		        OtherPlayer:MoveToWorld(jails[Tag]["w"])
                    Jailed = true
                end
	
	          OtherPlayer:TeleportToCoords( jails[Tag]["x"] + 0.5 , jails[Tag]["y"] , jails[Tag]["z"] + 0.5)
	          OtherPlayer:SendMessage(cChatColor.Red .. 'You have been jailed')
                UsersIni:DeleteValue(OtherPlayer:GetName(),   "Jailed")
                UsersIni:SetValue(OtherPlayer:GetName(),   "Jailed",   "true")
	          WorldName = OtherPlayer:GetWorld():GetName()
                Jailed = true
	          return true

		 end
	end
      cRoot:Get():FindAndDoWithPlayer(Split[2], JailPlayer);
	if (Jailed) then
          Player:SendMessage("Player "..Split[2].." is jailed")
          return true
      else
          Player:SendMessage(cChatColor.Red .. "Player not found")
	if jails[Tag] == nil then 
		Player:SendMessage(cChatColor.Red .. 'Jail "' .. Tag .. '" is invalid.')
		return true
      end
end
end

function HandleSetJailCommand( Split, Player)
	local Server = cRoot:Get():GetServer()
	local World = Player:GetWorld():GetName()
	local pX = math.floor(Player:GetPosX())
	local pY = math.floor(Player:GetPosY())
	local pZ = math.floor(Player:GetPosZ())
	
	if #Split < 2 then
		Player:SendMessage(cChatColor.Red .. 'Must supply a tag for the jail.')
		return true
	end
	local Tag = Split[2]
	
	if jails[Tag] == nil then 
		jails[Tag] = {}
	end
	
	local jailsINI = cIniFile("jails.ini")
	jailsINI:ReadFile()
	
	if (jailsINI:FindKey(Tag)<0) then
	jails[Tag]["w"] = World
	jails[Tag]["x"] = pX
	jails[Tag]["y"] = pY
	jails[Tag]["z"] = pZ
	end
	

	
	if (jailsINI:FindKey(Tag)<0) then
		jailsINI:AddKeyName(Tag);
		jailsINI:SetValue( Tag , "w" , World)
		jailsINI:SetValue( Tag , "x" , pX)
		jailsINI:SetValue( Tag , "y" , pY)
		jailsINI:SetValue( Tag , "z" , pZ)
		jailsINI:WriteFile();
	
		Player:SendMessage("Warp \"" .. Tag .. "\" set to World:'" .. World .. "' x:'" .. pX .. "' y:'" .. pY .. "' z:'" .. pZ .. "'")
	else
		Player:SendMessage(cChatColor.Red .. 'Warp "' .. Tag .. '" already exist')
	end
return true
end

function HandleDelJailCommand( Split, Player)
	local Server = cRoot:Get():GetServer()
	
	if #Split < 2 then
		Player:SendMessage(cChatColor.Red .. 'Usage: /jail [player] [jail]')
		return true
	end
	local Tag = Split[2]
	jails[Tag] = nil
	
	local jailsINI = cIniFile("jails.ini")
	jailsINI:ReadFile()
	
	if (jailsINI:FindKey(Tag)>-1) then
		jailsINI:DeleteKey(Tag);
		jailsINI:WriteFile();
	else
		Player:SendMessage(cChatColor.Red .. "Jail \"" .. Tag .. "\" was not found.")
		return true
	end
	
	Player:SendMessage(cChatColor.Green .. "Jail \"" .. Tag .. "\" was removed.")
	return true
end

function HandleListJailCommand( Split, Player)
	local jailStr = ""
	local inc = 0
	for k, v in pairs (jails) do
		inc = inc + 1
		jailStr = jailStr .. k .. ", "
	end
	Player:SendMessage(cChatColor.Green .. 'Jail: ' ..  cChatColor.LightGreen ..  jailStr)
	return true
end
