local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")
local ServerScriptService = game:GetService("ServerScriptService")
local ChatService = require(ServerScriptService:WaitForChild("ChatServiceRunner").ChatService)
local ModuleSettings = require(script.Parent)
local ChatUtil = require(script.Parent:WaitForChild("ChatUtil"))
local SpeakerPlus = require(script.Parent:WaitForChild("SpeakerPlus"))

-- System Validation --
if ModuleSettings.JoinLeaveMessages == nil then error('Settings Issue - "JoinLeaveMessages" not found') end
if ModuleSettings.DisableUpdateChecker == nil then error('Settings Issue - "DisableUpdateChecker" not found') end
assert(script:FindFirstChild("BuildNum"), 'Value "BuildNum" not found')
assert(ModuleSettings.SystemMessageName, 'Settings Issue - "SystemMessageName" not found')
assert(ModuleSettings.DefaultSystemMessageFormatting, 'Settings Issue - "DefaultSystemMessageFormatting" not found')
assert(ModuleSettings.DefaultMessageFormatting, 'Settings Issue - "DefaultMessageFormatting" not found')
assert(ModuleSettings.Users, 'Settings Issue - "Users" not found')
assert(ModuleSettings.Groups, 'Settings Issue - "Groups" not found')

-- Local Functions --
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

function CheckVersion()
	local success, webpageModel = pcall(InsertService.LoadAsset, InsertService, 5356342564)
	if success and webpageModel then
		local websiteBuild = webpageModel.ChatPlus.Main.BuildNum.Value
		local localBuild = script.BuildNum.Value
		if websiteBuild > script.BuildNum.Value then
			warn("[ChatPlus] Your system is " .. websiteBuild - localBuild .. " versions(s) behind! You might want to update.")
		elseif websiteBuild < script.BuildNum.Value then
			warn("[ChatPlus] Please do not mess with the BuildNum value! It is used to check for system updates.")
		end
		webpageModel:Destroy()
	else
		warn("[ChatPlus] Issue with getting most recent version from website")
	end
	
end

-- Connections --
ChatService.SpeakerAdded:Connect(function(speakerName)
	if game.Players:FindFirstChild(speakerName) then
		local player = game.Players:FindFirstChild(speakerName)
		local speaker = ChatService:GetSpeaker(speakerName)
		
		ChatUtil.ApplyChatData(speaker, ModuleSettings.DefaultMessageFormatting)
		
		if HasUserChatData(player) then
			ChatUtil.ApplyChatData(speaker, ModuleSettings.Users[player.UserId])
		else
			local groupId = FindHighestPriorityGroup(player)
			if groupId then
				local groupData = ModuleSettings.Groups[groupId]
				local playerRank = player:GetRankInGroup(groupId)
				
				ChatUtil.ApplyChatData(speaker, groupData.Global)
				
				local staticRanks, dynamicRanks = GetRankTypes(groupData)
				local skipDynamic = false
				for i, rank in pairs(staticRanks) do
					if tonumber(rank[1]) == playerRank then
						skipDynamic = true
						ChatUtil.ApplyChatData(speaker, rank[2])
						break
					end
				end
				
				if not skipDynamic then
					for i, rank in pairs(dynamicRanks) do
						local rankName = string.gsub(string.gsub(rank[1], ">", ""), "<", "")
						local rankOperator = string.sub(rank[1], 1, 1)
						
						if CheckOperatorString(playerRank, rankOperator, tonumber(rankName)) then
							ChatUtil.ApplyChatData(speaker, rank[2])
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

if not ModuleSettings.DisableUpdateChecker then CheckVersion() end
print("[ChatPlus] Build " .. script.BuildNum.Value .. " loaded!")