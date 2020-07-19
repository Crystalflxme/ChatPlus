# ChatPlus in action:

![](https://doy2mn9upadnk.cloudfront.net/uploads/default/original/4X/1/d/c/1dc20a43451bf79fce01be955b1c111fa4f8ce51.png)
![](https://doy2mn9upadnk.cloudfront.net/uploads/default/original/4X/2/1/b/21bbe813fa13ea43fd42de22d05d4f7e8b8e7143.png)
![](https://doy2mn9upadnk.cloudfront.net/uploads/default/original/4X/0/6/b/06b6002308a3dbb41fadaa451b8fe9dddbb27721.png)
![](https://doy2mn9upadnk.cloudfront.net/uploads/default/original/4X/6/9/b/69b6ac9e50e3c5c085258468b3a4f385df923d9d.png)
![](https://doy2mn9upadnk.cloudfront.net/uploads/default/original/4X/6/9/c/69cadecbbbc6b6bd921066487172249650bb65d7.png)

![](https://doy2mn9upadnk.cloudfront.net/uploads/default/optimized/4X/f/c/9/fc9006eaddcdc255ab7e664a2fff00936f5900c1_2_196x250.png) ![](https://doy2mn9upadnk.cloudfront.net/uploads/default/optimized/4X/2/6/5/265b00ce4f45d603dedbc13e83e453d8e2c5e3f7_2_203x250.png)

ChatPlus makes it easy to create formatting like this to let you focus on how it looks rather than if it works.

<br>

# Editing ChatPlus' Special Formatting

ChatPlus has a special way of hanlding formatting to make it easy to customize how your chat looks. This method of changing formatting can be used anywhere in ChatPlus for formatting anything. You can read more about the specifics [here](setup/gotchas.md).

Editing the formatting of text with this method is as simple as follows:

```lua
-- You could have a chat tag with a custom name color...
local FormattingTable = {
    {"NameColor", Color3.fromRGB(255, 255, 255)},
    {"Tags", {{TagText = "Cool Person", TagColor = Color3.fromRGB(255, 0, 0)}}}
}

-- Or some big wacky text!
local FormattingTable2 = {
    {"Font", Enum.Font.Cartoon},
    {"TextSize", 32}
}

-- Or maybe... both!
local FormattingTable3 = {
    {"NameColor", Color3.fromRGB(255, 0, 0)},
    {"Tags", {{TagText = "Super Cool Person", TagColor = Color3.fromRGB(0, 255, 0)}}},
    {"Font", Enum.Font.Fantasy},
    {"TextSize", 32}
}
```

A single table for everything! Nice.

**Want to try ChatPlus?** Learn how to [get started here](setup/getting-started.md).