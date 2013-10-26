jails = {}

function Initialize(Plugin)
    Plugin:SetName( "Jailed" )
    Plugin:SetVersion( 1 )
	
	PluginManager = cRoot:Get():GetPluginManager()
	PluginManager:AddHook(cPluginManager.HOOK_CHAT, OnChat)
	PluginManager:AddHook(cPluginManager.HOOK_EXECUTE_COMMAND, OnExecuteCommand)
	PluginManager:AddHook(cPluginManager.HOOK_PLAYER_BREAKING_BLOCK, OnPlayerBreakingBlock)
	PluginManager:AddHook(cPluginManager.HOOK_PLAYER_PLACING_BLOCK, OnPlayerPlacingBlock)

	PluginManager:BindCommand("/jail",           	 "jail.jail",      	    HandleJailCommand,      		  " - Jails a player.");
	PluginManager:BindCommand("/unjail",           	 "jail.unjail",      	    HandleUnJailCommand,      	  " - unjails a player.");
	PluginManager:BindCommand("/setjail",            "jail.setjail",     	    HandleSetJailCommand,   		  " - Creates a jail at players location.");
	PluginManager:BindCommand("/deljail",            "jail.deljail",            HandleDelJailCommand,        	  " - Deletes a jail.");
	PluginManager:BindCommand("/jails",         	 "jail.listjail",           HandleListJailCommand,            " - Lists all jails.");
	

	local settingsINI = cIniFile( Plugin:GetLocalDirectory() .. "/settings.ini" )
      settingsINI:ReadFile(settings.ini)
      IsChatEnabled = settingsINI:GetValueSet("Enabled", "Chat", "true")
      AreCommandEnabled = settingsINI:GetValueSet("Enabled", "Commands", "false")
      IsDiggingEnabled = settingsINI:GetValueSet("Enabled", "Dig", "true")
      IsPlaceEnabled = settingsINI:GetValueSet("Enabled", "Place", "true")
      settingsINI:WriteFile(settings.ini)
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
    LOG("Initialised " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
    return true
end

