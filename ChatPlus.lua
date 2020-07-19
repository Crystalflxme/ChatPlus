--[[

   _____ _           _  ______ _
  /  __ \ |         | | | ___ \ |
  | /  \/ |__   __ _| |_| |_/ / |_   _ ___ 
  | |   | '_ \ / _` | __|  __/| | | | / __|
  | \__/\ | | | (_| | |_| |   | | |_| \__ \
   \____/_| |_|\__,_|\__\_|   |_|\__,_|___/  v1.2.0

  By Crystalflxme (https://www.roblox.com/users/64917350)

  An open source system for easily editing the default Roblox chat.
  Using: https://developer.roblox.com/en-us/articles/Lua-Chat-System
  DevForum Post: https://devforum.roblox.com/t/chatplus/674457



===================================
--------- Getting Started ---------
===================================

Thanks for using ChatPlus! The entire setup process and more is documented here:
https://crystalflxme.github.io/ChatPlus/setup/getting-started

If you don't want to look at the documentation (very much recommended), then run this command in your command bar to setup ChatPlus:
p=PATH_TO_CHATPLUS f=p.ToLoadIntoChat for i,v in pairs(f:GetChildren()) do v.Parent=game:GetService("Chat") end f:Destroy()

Don't forget to change PATH_TO_CHATPLUS to the path to the ChatPlus module (wherever you put it).

]]

return {
	
	--== If enabled, ChatPlus will stop checking for updates on server start. ==--
	DisableUpdateChecker = false,
	
	--== If enabled, the server will send out messages for players joining and leaving. ==--
	JoinLeaveMessages = true,
	
	--== The chat name to be displayed for system messages. ==--
	SystemMessageName = "Server",
	
	--== The default formatting for system messages sent through this system. ==--
	DefaultSystemMessageFormatting = {
		{"NameColor", Color3.fromRGB(255, 255, 255)},
		{"ChatColor", Color3.fromRGB(255, 255, 255)}
	},
	
	--== The default formatting applied to every player's messages. ==--
	DefaultMessageFormatting = {
		{"NameColor", Color3.fromRGB(255, 100, 100)},
	},
	
	--== The list of users that can have special formatting. ==--
	Users = {
		
		--== An ID of a user you want goes here. ==--
		[64917350] = {
			{"Tags", {{TagText = "Game Owner!!", TagColor = Color3.fromRGB(255, 0, 0)}}}
		}
		
	},
	
	--== The list of groups that can have special formatting. ==--
	Groups = {
		
		--== An ID of a group you want goes here. ==--
		[4361197] = {
			
			--== The priority of this group goes here. The lower the number, the higher priority of the group. ==--
			Priority = 10,
			
			--== The "Global" tag will be applied to every single member of the group. ==--
			["Global"] = {
				{"ChatColor", Color3.fromRGB(255, 215, 0)}
			},
			
			--== Specific rank numbers apply to exact ranks in the group. ==--
			["255"] = {
				{"Tags", {{TagText = "Group Owner", TagColor = Color3.fromRGB(0, 0, 220)}}}
			},
			
			--== The Greater Than operator can be added to specifify formatting that should be applied to users with a rank above the listed amount. ==--
			[">99"] = {
				{"Tags", {{TagText = "Pretty Cool", TagColor = Color3.fromRGB(0, 200, 220)}}}
			},
			
			--== The Less Than operator can also be added to apply to those who are under rank 100. ==--
			["<100"] = {
				{"Tags", {{TagText = "Almost Cool", TagColor = Color3.fromRGB(100, 220, 100)}}}
			}
		},
		
	},
	
	--== Settings for client-sided aspects of the chat in your game. ==--
	ClientChatOptions = {
		
		--== Default settings for your game's BubbleChat. Most of these values are dynamic and can be changed at any time. See here: https://crystalflxme.github.io/ChatPlus/setup/dynamic-client-chat-options/ ==--
		BubbleChat = {
			
			--== Not Dynamic | If enabled, bubble chat will show for players. ==--
			Enabled = true,
			
			--== The font for the BubbleChat ==--
			Font = Enum.Font.SourceSans,
			
			--== The font size for the BubbleChat. MUST FIT A FONTSIZE ENUM: https://developer.roblox.com/en-us/api-reference/enum/FontSize ==--
			FontSize = 24,
			
			--== The color of the text in the bubble. ==--
			TextColor = Color3.fromRGB(0, 0, 0),
			
			--== The background color of the bubble. ==--
			BackgroundColor = Color3.fromRGB(255, 255, 255),
			
			--== The max distance before chat bubbles say "..." ==--
			NearBubbleDistance = 65,
			
			--==  The max distance before chat bubbles disappear. ==--
			MaxBubbleDistance = 100
			
		}
		
	},
	
	
	-- // Don't touch the things below this line! They are not settings! // --
	SystemMessenger = nil
}