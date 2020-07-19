SpeakerPlus = {}
SpeakerPlus.__index = SpeakerPlus

local ServerScriptService = game:GetService("ServerScriptService")
local ChatService = require(ServerScriptService:WaitForChild("ChatServiceRunner").ChatService)
local Util = require(script.Parent:WaitForChild("Util"))

function SpeakerPlus.new(speakerName, formattingTable)
	assert(speakerName, "SpeakerName not found when trying to setup new SpeakerPlusObject")
	
	local newSpeakerPlus = {}
	setmetatable(newSpeakerPlus, SpeakerPlus)
	
	local SpeakerObject = ChatService:AddSpeaker(speakerName)
	newSpeakerPlus.Speaker = SpeakerObject
	
	if formattingTable then Util.ApplyChatData(SpeakerObject, formattingTable) end
	
	if not ChatService:GetChannel("All") then
		while wait() do
			local ChannelName = ChatService.ChannelAdded:Wait()
			if ChannelName == "All" then
				break
			end
		end
	end
	SpeakerObject:JoinChannel("All")
	
	return newSpeakerPlus
end

function SpeakerPlus:SetFormattingTable(formattingTable)
	assert(formattingTable, 'FormattingTable not found when trying set formatting for speaker "' .. self.Speaker.Name .. '"')
	Util.ApplyChatData(self.Speaker, formattingTable)
end

function SpeakerPlus:Chat(text)
	assert(text, 'Text not found when trying to chat for speaker "' .. self.Speaker.Name .. '"')
	self.Speaker:SayMessage(text, "All")
end

return SpeakerPlus