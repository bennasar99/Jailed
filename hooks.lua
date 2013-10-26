function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
      local UsersIni = cIniFile("users.ini")
      local SettingsIni = cIniFile( "Plugins/Jailed/settings.ini" )
      UsersIni:ReadFile(users.ini)
      SettingsIni:ReadFile(settings.ini)
      if (UsersIni:GetValue(Player:GetName(),   "Jailed") == "true") and (SettingsIni:GetValue("Enabled",   "Dig") == "false") then 
             Player:SendMessage(cChatColor.Red .. "You are jailed")
             return true
      else
             return false
      end
end

function OnPlayerPlacingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
      local UsersIni = cIniFile("users.ini")
      local SettingsIni = cIniFile( "Plugins/Jailed/settings.ini" )
      UsersIni:ReadFile(users.ini)
      SettingsIni:ReadFile(users.ini)
      if (UsersIni:GetValue(Player:GetName(),   "Jailed") == "true") and (SettingsIni:GetValue("Enabled",   "Place") == "false") then 
             Player:SendMessage(cChatColor.Red .. "You are jailed")
             return true
      else 
             return false
      end
end

function OnExecuteCommand(Player, CommandSplit)
      print(CommandSplit)
      local UsersIni = cIniFile("users.ini")
      local SettingsIni = cIniFile( "Plugins/Jailed/settings.ini" )
      UsersIni:ReadFile(users.ini)
      SettingsIni:ReadFile(settings.ini)
      if (UsersIni:GetValue(Player:GetName(),   "Jailed") == "true") and (SettingsIni:GetValue("Enabled",   "Commands") == "false") then
             Player:SendMessage(cChatColor.Red .. "You are jailed") 
             return true
      else 
             return false
      end
end

function OnChat(Player, Message)
      local UsersIni = cIniFile("users.ini")
      local SettingsIni = cIniFile( "Plugins/Jailed/settings.ini" )
      UsersIni:ReadFile(users.ini)
      SettingsIni:ReadFile(settings.ini)
      if (UsersIni:GetValue(Player:GetName(),   "Jailed") == "true") and (SettingsIni:GetValue("Enabled",   "Chat") == "false") then 
             Player:SendMessage(cChatColor.Red .. "You are jailed")
             return true
      else 
             return false
      end
end
