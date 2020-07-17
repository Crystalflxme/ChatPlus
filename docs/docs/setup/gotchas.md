When configuring ChatPlus, there are a few system specific things that you'll want to keep in mind to effectively use the system. They can be seen below.

!!! info "Fun Fact"
    If you would like a direct reference to the system/server speaker object that's built into ChatPlus, you can reference "ChatPlus.SystemMessenger" to get it.

## ChatPlus Formatting

ChatPlus uses a special formatting method that is based off of Roblox's default Lua Chat System "ExtraData" property. You can read more about the ExtraData property [here](https://developer.roblox.com/en-us/articles/Lua-Chat-System/API/ChatMessage). 

All data that can be changed from the ExtraData property transfers to this system. However, there are a few differences in the syntax.

Normally, you would do this to change a chat name color:
```lua
Speaker:SetExtraData("NameColor", Color3.fromRGB(255, 255, 255))
```

But with ChatPlus, you do this instead:
```lua
{"NameColor", Color3.fromRGB(255, 255, 255)}
```

When placed inside of another table to hold all of the data you want to set, this is known as a ChatPlus **FormattingTable** It is what the system uses to know how to format chat messages.

More examples of FormattingTables can be found [here on the examples page](/examples/).

## ChatPlus Formatting Priority

!!! warning "The Rule of Formatting Priority in ChatPlus"
    When certain formatting has priority over another, the one that doesn't have the priority is not shown at all!

1. The "Global" tag under the "Groups" table will apply to every single user and bypasses any formatting priority in the group.

2. If a user is listed under the "Users" table, then that formatting will take priority over *any* other formatting (even groups).
> **Example:** If the user is a rank that gets formatting in a group, all if it will be overridden by whatever the user formatting is (even the "Global" tag).

3. The group "Priority" number represents what groups should take formatting priority over the other.
> **Example:** If a user is in more than one group listed the group with more priority (smaller number) will be used for formatting.

4. Ranks without a greater or less than symbol will take priority over formatting that has them.
> **Example:** The rank "250" formatting would take priority over the ">200" rank formatting even though it is still true.

