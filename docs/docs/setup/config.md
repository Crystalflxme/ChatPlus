Editing the config of ChatPlus is made easy by the amount of comments in the config already to help you through the process. If you've change your default config and want to get the comments back or look at something again, use the default config below.

```lua
return {
	
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
	
	
	-- // Don't touch the things below this line! They are not settings! // --
	SystemMessenger = nil
}
```