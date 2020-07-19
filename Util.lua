local InsertService = game:GetService("InsertService")

local Util = {}
local DataTypes = {
	number = "IntValue",
	boolean = "BoolValue",
	Color3 = "Color3Value",
	string = "StringValue",
	EnumItem = "StringValue"
}

function Util.CheckOperatorString(condition1, operator, condition2)
	if condition1 == nil then error('Parameter "Condition1" not found') end
	if condition2 == nil then error('Parameter "Condition2" not found') end
	assert(operator, 'Parameter "Operator" not found')
	
	return operator == "<" and condition1 < condition2 or operator == ">" and condition1 > condition2
end

function Util.ApplyChatData(speaker, formattingTable)
	assert(speaker, "Speaker not found when trying to apply chat formatting")
	assert(formattingTable, "FormattingTable not found when trying to apply chat formatting")
	
	for i, data in pairs(formattingTable) do
		speaker:SetExtraData(data[1], data[2])
	end
end

function Util.HasUserChatData(player, users)
	assert(player, 'Parameter "Player" not found')
	assert(users, 'Parameter "Users" not found')
	
	for userId, userData in pairs(users) do
		if userId == player.UserId then
			return true
		end
	end
	return false
end

function Util.FindHighestPriorityGroup(player, groups)
	assert(player, 'Parameter "Player" not found')
	assert(groups, 'Parameter "Groups" not found')
	
	local highestPriority = math.huge
	local relevantGroupId
	for groupId, groupData in pairs(groups) do
		if player:IsInGroup(groupId) and groupData.Priority < highestPriority then
			highestPriority = groupData.Priority
			relevantGroupId = groupId
		end
	end
	return relevantGroupId
end

function Util.GetRankTypes(groupData)
	assert(groupData, 'Parameter "GroupData" not found')
	
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

function Util.ConvertDictToInstances(tableRef, parent)
	assert(tableRef, 'Parameter "TableRef" not found')
	assert(parent, 'Parameter "Parent" not found')
	
	local function recurse(subTable, subParent)
		for index, value in pairs(subTable) do
			if typeof(value) == "table" then
				local holder = Instance.new("Folder", subParent)
				holder.Name = index
				recurse(value, holder)
			else
				local typ = DataTypes[typeof(value)]
				if typ ~= nil then
					local object = Instance.new(typ, subParent)
					object.Name = index
					local newValue
					if typeof(value) == "EnumItem" then
						newValue = value.Name
					else
						newValue = value
					end
					object.Value = newValue
				end
			end
			
		end
	end
	
	recurse(tableRef, parent)
end

function Util.CheckChatPlusVersion()
	local success, webpageModel = pcall(InsertService.LoadAsset, InsertService, 5356342564)
	if success and webpageModel then
		local websiteBuild = webpageModel.ChatPlus.Main.BuildNum.Value
		local localBuild = script.Parent.Main.BuildNum.Value
		if websiteBuild > localBuild then
			warn("[ChatPlus] Your system is " .. websiteBuild - localBuild .. " versions(s) behind! You might want to update.")
		elseif websiteBuild < localBuild then
			warn("[ChatPlus] Please do not mess with the BuildNum value! It is used to check for system updates.")
		end
		webpageModel:Destroy()
	else
		warn("[ChatPlus] Issue with getting the most recent version from the website")
	end
end

return Util