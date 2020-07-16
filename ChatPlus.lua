--[[

   _____ _           _  ______ _
  /  __ \ |         | | | ___ \ |
  | /  \/ |__   __ _| |_| |_/ / |_   _ ___ 
  | |   | '_ \ / _` | __|  __/| | | | / __|
  | \__/\ | | | (_| | |_| |   | | |_| \__ \
   \____/_| |_|\__,_|\__\_|   |_|\__,_|___/  v1.0.0

  By Crystalflxme (https://www.roblox.com/users/64917350)

  An open source system for easily editing the default Roblox chat.
  Using: https://developer.roblox.com/en-us/articles/Lua-Chat-System
  DevForum Post: https://devforum.roblox.com/t/chatplus/674457



=========================================
--------- Setup & Settings Help ---------
=========================================

First off, if you need any help with the system feel free to message me on Twitter (https://twitter.com/crystalflxme) or on the DevForum (https://devforum.roblox.com/u/crystalflxme)!

If you have any advice for the system or something you'd like to see added, please contact me on any of the platforms listed above.

For getting started:
 - Place the ChatPlus module on the server-side. It is recommended that you put it in ServerScriptService.
 - Editing the systems settings is really easy! Below is the configuration with comments there to explain what goes where!


 --=====================--
    Formatting Priority
 --=====================--

> PLEASE NOTE: When certain formatting has priority over another, the one that doesn't have the priority is not shown at all! <

The "Global" tag under the "Groups" table will apply to every single user and bypasses any formatting priority in the group.

If a user is listed under the "Users" table, then that formatting will take priority over *any* other formatting (even groups).
 - Example: If the user is a rank that gets formatting in a group, all if it will be overridden by whatever the user formatting is (even the "Global" tag).

The group "Priority" number represents what groups should take formatting priority over the other.
 - Example: If a user is in more than one group listed the group with more priority (smaller number) will be used for formatting.

Ranks without a greater or less than symbol will take priority over formatting that has them.
 - Example: The rank "250" formatting would take priority over the ">200" rank formatting even though it is still true.



=================================
--------- Documentation ---------
=================================

There isn't really much to document at the moment, but what is there has been written down.  :P

 --========================--
     ChatPlus' Formatting
 --========================--

ChatPlus uses a special formatting method that is based off of Roblox's default Lua Chat System "ExtraData" property.
You can read more about the ExtraData property here: https://developer.roblox.com/en-us/articles/Lua-Chat-System/API/ChatMessage

All data that can be changed from the ExtraData property transfers to this system. There are a few differences in the syntax.

Normally, you would do this:
Speaker:SetExtraData("NameColor", Color3.fromRGB(255, 255, 255))

But with this system, you do this instead:
{"NameColor", Color3.fromRGB(255, 255, 255)}

Those tables should be put inside of a table called a FormattingTable. This is what the system uses to set the formatting.
More examples of the FormattingTables can be found in the default config of ChatPlus.

 --=====================--
      ChatPlus.Events
 --=====================--

 [ SendSystemMessage - BindableEvent ]
Usage: To send a system message though this system easily by using :Fire() from the event.
Arguments:
 - MessageText | The string to be sent by the server.

 [ SetSystemMessageFormatting - BindableEvent ]
Usage: To change the formatting of a system message using using :Fire() from the event.
Arguments:
 - FormattingTable | The formatting to be applied (see "ChatPlus' Formatting" above).


]]

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
		
	}
	
}
