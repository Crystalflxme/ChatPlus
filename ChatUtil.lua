local ChatUtil = {}

function ChatUtil.ApplyChatData(speaker, formattingTable)
	assert(speaker, "Speaker not found when trying to apply chat formatting")
	assert(formattingTable, "FormattingTable not found when trying to apply chat formatting")
	for i, data in pairs(formattingTable) do
		speaker:SetExtraData(data[1], data[2])
	end
end

return ChatUtil