function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
      if (UsersIni:GetValue(Player:GetName(),   "Jailed") == "true") and (IsDiggingEnabled == false) then 
             Player:SendMessage(cChatColor.Red .. "You are jailed")
             return true
      else
             return false
      end
end

function OnPlayerPlacingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
      if (UsersIni:GetValue(Player:GetName(),   "Jailed") == "true") and (IsPlaceEnabled == false) then 
             Player:SendMessage(cChatColor.Red .. "You are jailed")
             return true
      else 
             return false
      end
end

function OnExecuteCommand(Player, CommandSplit)
      if (UsersIni:GetValue(Player:GetName(),   "Jailed") == "true") and (AreCommandsEnabled == false) then
             Player:SendMessage(cChatColor.Red .. "You are jailed") 
             return true
      else 
             return false
      end
end

function OnChat(Player, Message)
      if (UsersIni:GetValue(Player:GetName(),   "Jailed") == "true") and (IsChatEnabled == false) then 
             Player:SendMessage(cChatColor.Red .. "You are jailed")
             return true
      else 
             return false
      end
end
