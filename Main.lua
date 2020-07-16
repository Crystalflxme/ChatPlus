local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ChatService = require(ServerScriptService:WaitForChild("ChatServiceRunner").ChatService)
local ModuleSettings = require(script.Parent)

local Events = script.Parent:WaitForChild("Events")
local SendSystemMessage = Events:WaitForChild("SendSystemMessage", 5)
local SetSystemMessageFormatting = Events:WaitForChild("SetSystemMessageFormatting", 5)

-- Script & Config Validation --
assert(Events, 'Core folder "Events" not found!')
assert(SendSystemMessage, 'Event "SendSystemMessage" not found in the events folder!')
assert(SetSystemMessageFormatting, 'Event "SetSystemMessageFormatting" not found in the events folder!')
assert(ModuleSettings.SystemMessageName, 'Settings Issue - "SystemMessageName" not found.')
assert(ModuleSettings.DefaultSystemMessageFormatting, 'Settings Issue - "DefaultSystemMessageFormatting" not found.')
assert(ModuleSettings.JoinLeaveMessages, 'Settings Issue - "JoinLeaveMessages" not found.')
assert(ModuleSettings.Users, 'Settings Issue - "Users" not found.')
assert(ModuleSettings.Groups, 'Settings Issue - "Groups" not found.')

-- Local Functions --
local function ApplyChatData(speaker, chatData)
	for i, data in pairs(chatData) do
		speaker:SetExtraData(data[1], data[2])
	end
end

local function HasUserChatData(player)
	for userId, userData in pairs(ModuleSettings.Users) do
		if userId == player.UserId then
			return true
		end
	end
	return false
end

local function FindHighestPriorityGroup(player)
	local highestPriority = math.huge
	local relevantGroupId
	for groupId, groupData in pairs(ModuleSettings.Groups) do
		if player:IsInGroup(groupId) and groupData.Priority < highestPriority then
			highestPriority = groupData.Priority
			relevantGroupId = groupId
		end
	end
	return relevantGroupId
end

local function GetRankTypes(groupData)
	local staticRanks = {}
	local dynamicRanks = {}
	for rankName, rankData in pairs(groupData) do
		if rankName ~= "Global" and rankName ~= "Priority" then
			local firstCharacter = string.sub(rankName, 1, 1)
			if firstCharacter == ">" or firstCharacter == "<" then
				table.insert(dynamicRanks, {rankName, rankData})
			else
				table.insert(staticRanks, {rankName, rankData})
			end
		end
	end
	return staticRanks, dynamicRanks
end

function CheckOperatorString(condition1, operator, condition2)
	return operator == "<" and condition1 < condition2 or operator == ">" and condition1 > condition2
end

-- System Messages Setup --
local SystemMessenger = ChatService:AddSpeaker(ModuleSettings.SystemMessageName)
ApplyChatData(SystemMessenger, ModuleSettings.DefaultSystemMessageFormatting)

-- Connections --
ChatService.SpeakerAdded:Connect(function(speakerName)
	if game.Players:FindFirstChild(speakerName) then
		local player = game.Players:FindFirstChild(speakerName)
		local speaker = ChatService:GetSpeaker(speakerName)
		if HasUserChatData(player) then
			ApplyChatData(speaker, ModuleSettings.Users[player.UserId])
		else
			local groupId = FindHighestPriorityGroup(player)
			if groupId then
				local groupData = ModuleSettings.Groups[groupId]
				local playerRank = player:GetRankInGroup(groupId)
				
				ApplyChatData(speaker, groupData.Global)
				
				local staticRanks, dynamicRanks = GetRankTypes(groupData)
				local skipDynamic = false
				for i, rank in pairs(staticRanks) do
					if tonumber(rank[1]) == playerRank then
						skipDynamic = true
						ApplyChatData(speaker, rank[2])
						break
					end
				end
				
				if not skipDynamic then
					for i, rank in pairs(dynamicRanks) do
						local rankName = string.gsub(string.gsub(rank[1], ">", ""), "<", "")
						local rankOperator = string.sub(rank[1], 1, 1)
						
						if CheckOperatorString(playerRank, rankOperator, tonumber(rankName)) then
							ApplyChatData(speaker, rank[2])
						end
					end
				end
			end
		end
	end
end)

-- System Messenger Final Setup --
if not ChatService:GetChannel("All") then
	while wait() do
		local ChannelName = ChatService.ChannelAdded:Wait()
		if ChannelName == "All" then
			break
		end
	end
end
SystemMessenger:JoinChannel("All")

game.Players.PlayerAdded:Connect(function(player)
	if ModuleSettings.JoinLeaveMessages then
		SystemMessenger:SayMessage(player.Name .. " has joined the server!", "All")
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	if ModuleSettings.JoinLeaveMessages then
		SystemMessenger:SayMessage(player.Name .. " has left the server!", "All")
	end
end)

SendSystemMessage.Event:Connect(function(messageText)
	SystemMessenger:SayMessage(messageText, "All")
end)

SetSystemMessageFormatting.Event:Connect(function(formattingTable)
	ApplyChatData(SystemMessenger, formattingTable)
end)

warn("[ChatPlus] Loaded!")
