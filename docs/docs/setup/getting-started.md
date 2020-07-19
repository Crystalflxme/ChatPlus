> ### Hey there!
- If you need any help with the system feel free to message me on [Twitter](https://twitter.com/crystalflxme) or on the [DevForum](https://devforum.roblox.com/u/crystalflxme) with anything you want clarified or answered!
- If you have any advice for the system or something you'd like to see added, please also contact me!

### Steps to install
1. First, [get the model for ChatPlus here on Roblox](https://www.roblox.com/library/5356342564/ChatPlus)
2. Once you insert the model in your game, place the ChatPlus module on the server-side. It is recommended that you put it in ServerScriptService.
3. Run the following code in your command bar and make sure to replace the `PATH_TO_CHATPLUS` to the path that leads to the ChatPlus module.
```lua
p=PATH_TO_CHATPLUS f=p.ToLoadIntoChat for i,v in pairs(f:GetChildren()) do v.Parent=game:GetService("Chat") end f:Destroy()
```
4. You're done! Feel free to mess around with the system!

<br>

!!! tip "Installing ChatPlus is the easy part!"
    It might be a good idea to also look at the [system's gotchas](gotchas.md) to learn the ins-and-outs of the system before going ahead and [configuring the system](config.md).