# Doom Emacs

### mu4e

**KeyBindings**  

|Key|Description|
|--- |--- |
|n,p|view the next, previous message|
|],[|move to the next, previous unread message|
|y|select the message view (if it’s visible)|
|RET|open the message at point in the message view|

**Searching**  

|Key|Description|
|--- |--- |
|s|search|
|S|edit last query|
|||narrow the search|
|b|search bookmark|
|B|edit bookmark before search|
|j|jump to maildir|
|M-left,\|previous query|
|M-right|next query|
|O|change sort order|
|P|toggle threading|
|Q|toggle full-search|
|V|toggle skip-duplicates|
|W|toggle include-related|

**Marking**  

|Key|Description|
|--- |--- |
|d|mark for moving to the trash folder|
|=|mark for removing trash flag (’untrash’)|
|DEL,D|mark for complete deletion|
|m|mark for moving to another maildir folder|
|r|mark for refiling|
|+,-|mark for flagging/unflagging|
|?,!|mark message as unread, read|
|u|unmark message at point|
|U|unmark all messages|
|%|mark based on a regular expression|
|T,t|mark whole thread, subthread|
|<insert>,|mark for ’something’ (decide later)|
|#|resolve deferred ’something’ marks|
|x|execute actions for the marked messages|

**Composition**  

|Key|Description|
|--- |--- |
|R,F,C|reply/forward/compose|
|E|edit (only allowed for draft messages)|

**Misc**   

|Key|Description|
|--- |--- |
|a|execute some custom action on a header|
|\|pipe message through shell command|
|C-+,C–|increase / decrease the number of headers shown|
|H|get help|
|C-S-u|update mail & reindex|
|q,z|leave the headers buffer|

**Useful keybindings mu4e’s editor view**   

|Key|Description|
|--- |--- |
|C-c C-c|send message|
|C-c C-d|save to drafts and leave|
|C-c C-k|kill the message|
|C-c C-a|attach a file (pro-tip: drag & drop works as well)|
|(mu4e-specific)||
|C-S-u|update mail & reindex|
