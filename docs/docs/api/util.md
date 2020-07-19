Util is the built-in ChatPlus utility module. It is used mostly used for only internal applications, but it can be used for any situations you might have.

## Global Methods

---------------

```lua
Util.CheckOperatorString()
```
**Description:** Will compare two conditions with a greater or less than symbol in a string.

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| Condition1 | number | Yes |
| Operator | string | Yes |
| Condition2 | number | Yes |

**Returns:**

| Name | Type |
| --- | --- |
| ConditionMet | bool |

---------------

```lua
Util.HasUserChatData()
```
**Description:** Will check if the given player's user id is in the Users dictionary (checks the index for the user id).

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| Player | instance | Yes |
| Users | table | Yes |

**Returns:**

| Name | Type |
| --- | --- |
| ConditionMet | bool |

---------------

```lua
Util.FindHighestPriorityGroup()
```
**Description:** Will find the highest priority group in the Groups dictionary (see function code for more info).

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| Player | instance | Yes |
| Groups | table | Yes |

**Returns:**

| Name | Type |
| --- | --- |
| RelevantGroupId | integer |

---------------

```lua
Util.GetRankTypes()
```
**Description:** Will return a "dynamic" and "static" table with catagorized results from the GroupData (see function code for more info).

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| GroupData | table | Yes |

**Returns:**

| Name | Type |
| --- | --- |
| StaticRanks | table |
| DynamicRanks | table |

---------------

```lua
Util.ApplyChatData()
```
**Description:** Applies the given ChatPlus FormattingTable to a ChatSpeaker object.

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| Speaker | ChatSpeaker | Yes |
| FormattingTable | table | Yes |

---------------

```lua
Util.ConvertDictToInstances()
```
**Description:** Will convert the given dictionary (TableRef) into folders and values with the first parent being Parent.

**Parameters:**

| Name | Type | Required |
| --- | --- | --- |
| TableRef | table | Yes |
| Parent | instance | Yes |

---------------

```lua
Util.CheckChatPlusVersion()
```
**Description:** Will tell you in the output if you are up to date (doesn't print if you are updated fully).

---------------