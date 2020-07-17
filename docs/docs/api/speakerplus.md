SpeakerPlus is a module within ChatPlus that easily allows you to create your own custom chat speaker objects with their own name, formatting, and chats. More specifically, it creates [ChatSpeaker](https://developer.roblox.com/en-us/articles/Lua-Chat-System/API/ChatSpeaker) objects for you.

## Global Methods

```lua
SpeakerPlus.new()
```
**Description:** Will create a SpeakerPlus object for you with the given speaker name in the chat and applied formatting from the FormattingTable.

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| SpeakerName | string | Yes |
| FormattingTable | array | No |


## SpeakerPlusObject

<br>

### Methods

---------------

```lua
SpeakerPlusObject:Chat()
```
**Description:** Will make the SpeakerPlusObject chat the given text.

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| Text | string | Yes |

---------------

```lua
SpeakerPlusObject:SetFormattingTable()
```
**Description:** Will apply the given FormattingTable to the SpeakerPlusObject.

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| FormattingTable | array | Yes |

---------------

<br>

### Properties

---------------

```lua
SpeakerPlusObject.Speaker
```
**Description:** Is a direct reference to the [ChatSpeaker](https://developer.roblox.com/en-us/articles/Lua-Chat-System/API/ChatSpeaker) object used.

---------------

<br>

## Code Sample

Not sure how to use the SpeakerPlus API? No problem! Below is a example of how to get started.

```lua
-- First you will want to require SpeakerPlus and replace whats in the require currently with the path to the SpeakerPlus module (wherever it is for you)
local SpeakerPlus = require(Path.To.SpeakerPlus)

-- Then, create a SpeakerPlusObject with the first argument being the name in the chat and the second being a FormattingTable (which is optional)
local ReallyCoolDude = SpeakerPlus.new("Really Cool Dude", {{"NameColor", Color3.fromRGB(255, 0, 0)}})

-- Next, you can have the SpeakerPlusObject chat! It's as simple as passing in a string to be said.
ReallyCoolDude:Chat("Hey, I'm really cool.")

-- You can also modify the formatting of the SpeakerPlusObject after creation with a FormattingTable!
ReallyCoolDude:SetFormattingTable({{"NameColor", Color3.fromRGB(0, 255, 0)}})

-- We can have the SpeakerPlusObject again to see the formatting changes.
ReallyCoolDude:Chat("Woah! My name is green now!")
```