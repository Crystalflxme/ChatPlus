local Players = game:GetService("Players")
local Chat = game:GetService("Chat")
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ModuleSettings = require(script.Parent)

-- System Validation --
if ModuleSettings.JoinLeaveMessages == nil then error('Settings Issue - "JoinLeaveMessages" not found') end
if ModuleSettings.DisableUpdateChecker == nil then error('Settings Issue - "DisableUpdateChecker" not found') end
assert(script.Parent:FindFirstChild("SpeakerPlus"), 'Module "SpeakerPlus" not found')
assert(script.Parent:FindFirstChild("Util"), 'Module "Util" not found')
assert(script:FindFirstChild("BuildNum"), 'Value "BuildNum" not found')
assert(ModuleSettings.SystemMessageName, 'Settings Issue - "SystemMessageName" not found')
assert(ModuleSettings.DefaultSystemMessageFormatting, 'Settings Issue - "DefaultSystemMessageFormatting" not found')
assert(ModuleSettings.DefaultMessageFormatting, 'Settings Issue - "DefaultMessageFormatting" not found')
assert(ModuleSettings.Users, 'Settings Issue - "Users" not found')
assert(ModuleSettings.Groups, 'Settings Issue - "Groups" not found')
assert(ModuleSettings.ClientChatOptions, 'Settings Issue - "ClientChatOptions" not found')

-- Load ClientChatOptions with Util --
local Util = require(script.Parent:WaitForChild("Util"))
local ClientChatOptions = Instance.new("Folder")
ClientChatOptions.Name = "ClientChatOptions"
Util.ConvertDictToInstances(ModuleSettings.ClientChatOptions, ClientChatOptions)
ClientChatOptions.Parent = ReplicatedStorage

-- Modules --
local ChatService = require(ServerScriptService:WaitForChild("ChatServiceRunner").ChatService)
local SpeakerPlus = require(script.Parent:WaitForChild("SpeakerPlus"))

-- Connections --
ChatService.SpeakerAdded:Connect(function(speakerName)
	if game.Players:FindFirstChild(speakerName) then
		local player = game.Players:FindFirstChild(speakerName)
		local speaker = ChatService:GetSpeaker(speakerName)
		
		Util.ApplyChatData(speaker, ModuleSettings.DefaultMessageFormatting)
		
		if Util.HasUserChatData(player, ModuleSettings.Users) then
			Util.ApplyChatData(speaker, ModuleSettings.Users[player.UserId])
		else
			local groupId = Util.FindHighestPriorityGroup(player, ModuleSettings.Groups)
			if groupId then
				local groupData = ModuleSettings.Groups[groupId]
				local playerRank = player:GetRankInGroup(groupId)
				
				Util.ApplyChatData(speaker, groupData.Global)
				
				local staticRanks, dynamicRanks = Util.GetRankTypes(groupData)
				local skipDynamic = false
				for i, rank in pairs(staticRanks) do
					if tonumber(rank[1]) == playerRank then
						skipDynamic = true
						Util.ApplyChatData(speaker, rank[2])
						break
					end
				end
				
				if not skipDynamic then
					for i, rank in pairs(dynamicRanks) do
						local rankName = string.gsub(string.gsub(rank[1], ">", ""), "<", "")
						local rankOperator = string.sub(rank[1], 1, 1)
						
						if Util.CheckOperatorString(playerRank, rankOperator, tonumber(rankName)) then
							Util.ApplyChatData(speaker, rank[2])
						end
					end
				end
			end
		end
	end
end)

-- System Messenger Setup --
local SystemMessenger = SpeakerPlus.new(ModuleSettings.SystemMessageName, ModuleSettings.DefaultSystemMessageFormatting)
ModuleSettings.SystemMessenger = SystemMessenger

game.Players.PlayerAdded:Connect(function(player)
	if ModuleSettings.JoinLeaveMessages then
		SystemMessenger:Chat(player.Name .. " has joined the server!")
	end
end)
game.Players.PlayerRemoving:Connect(function(player)
	if ModuleSettings.JoinLeaveMessages then
		SystemMessenger:Chat(player.Name .. " has left the server!")
	end
end)

if ModuleSettings.DisableUpdateChecker == false then Util.CheckChatPlusVersion() end
print("[ChatPlus] Build " .. script.BuildNum.Value .. " loaded!")