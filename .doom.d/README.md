# Doom Emacs

## Install

```
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
```

## Cheatsheet
```
SPC
    SPC: find file
    , switch buffer
    . browse files
    : MX
    ; EX
    < switch buffer
    ` eval
    u universal arg
    x pop up scratch
    ~ toggle last popup
    TAB workspace
        TAB Display tab bar
        . switch workspace
        0 last workspace
        1-9 : x workspace
        L load session
        S autosave current session
        X delete sessions
        [ previous workspace
        ] next workspace
        d delete workspace
        l load workspace from file
        n workspace
        s save workspace to file
        x kill all buffers'
    / search
        i symbols
        I symbols accr. buffers
        b buffer
        d directory
        o Online providers
        p project
    [ prev
        S spelling corr
        [ text size
        b buffer
        d diff
        e error
        h smart jump
        s spelling error
        t todo
        w workspace
    ] next
        S spelling corr
        [ text size
        b buffer
        d diff
        e error
        h smart jump
        s spelling error
        t todo
        w workspace
    b buffer
        B switch buffer
        S sudo edit
        [ prev
        ] next
        b switch ws buffer
        k kill buffer
        n new empty buffer
        o kill other buffers
        s save buffer
        x pop scratch buffer
        z burry buffer
    c code
        d jump to def
        D jump to ref
        e evaluate buffer
        E evaluate and replace
        b build
        r repl
        x list errors
    f file
        . find file
        / find file in project
        > sudo find file
        ? find file from here
        E Browse emacs.d
        P browse private config
        R recent project files
        a find other file
        c open project editor config
        d find dir
        e find file in emacs.d
        p find file in private config
        r recent files
        y yank filename
    g git
        c magit commit
        C magit clone
        G list gists
        L list reps
        P magic pull popup
        R git revert
        S git stage
        U git unstange hunk
        [ previous
        ] next
        b magic blame
        d magic dispatch
        f magic find
        g magit status
        i init repo
        l magit buffer log
        p push popup
        r git revert hunk
        s git status
        t git time matchine
    o open
        M mail
        N neotree
        O reveal proj finder
        b browser
        d debugger
        n neotree
        o reveal in finder
        r repl
        t terminal
    p project
        ! run cmd in project root
        . browse
        / find in project
        c compile project
        o find other file
        p switch project
        r recent project files
        t list project tasks
        x invalidate cache
    q quit
        q save and quit
        Q quit
    r remote
        . browse remote files
        > detect remote changes
        D diff local and remote
        U upload local
        d download remote
        u upload local
    s snippets
        S find snippet
        i insert snippet
        n new snippet
        s find snippet for mode
    t toggle
        F frame fullscreen
        I indente
        b big mode
        f flycheck
        g evil goggles
        h impatient modei indet guides
        l line numbers
        p org-tree-slide-mode
        s flyspell
    w window
        + increase height
        - descr height
        < dec width
        = balance windows
        > incr width
        H move left
        J move down
        K move up
        L move right
        R rotate up
        S split
        W prev
        _ set height
        b bottom right
        c close window
        h left
        j down
        k up
        l right
        n new
        o enlargen
        p mru
        q quit
        r rotate down
        s split
        t top left
        u winner undo
        v vsplit
        w next
        | set width
```

## mu4e

### Setting Up mu4e

**Required packages:**   
- mu   
- isync or mbsync

From the AUR: `yay -S mu mbsync`.   
From oficial repository: `sudo pacman -S mu isync`.   

Create a file called `.mbsyncrc` inside the home directory and add the folloing configuration:   

```
# Setting up Gmail
IMAPAccount vertilux
Host imap.gmail.com
User email@vertilux.com
Pass PASSWORD
# Alternatively password can be encrypted and retrieve it with:
# PassCmd "gpg2 -q --for-your-eyes-only --no-tty -d ~/.config/mu4e/gmail-passwd.gpg"
AuthMechs LOGIN
SSLType IMAPS
SSLVersions TLSv1.2
CertificateFile /etc/ssl/certs/ca-certificates.crt

IMAPStore vertilux-remote
Account vertilux

MaildirStore vertilux-local 
Path ~/Maildir/vertilux/
Inbox ~/Maildir/vertilux/INBOX
# Required only if want to download all subfolders; syncing may slow down.
# SubFolders Verbatim

Channel vertilux
Master :vertilux-remote:
Slave :vertilux-local:
Patterns "INBOX"
Create Both
Expunge Both
SyncState *

Channel gmail-draft
Master :vertilux-remote:"[Gmail]/Drafts"
Slave :vertilux-local:draft
Create Both
Expunge Both
SyncState *

Channel gmail-trash
Master :vertilux-remote:"[Gmail]/Trash"
Slave :vertilux-local:trash
Create Both
Expunge Both
SyncState *

Channel gmail-sent
Master :vertilux-remote:"[Gmail]/Sent Mail"
Slave :vertilux-local:sent
Create Both
Expunge Both
SyncState *

Group gmail
Channel vertilux
Channel gmail-sent
Channel gmail-trash
Channel gmail-draft

#===============================================
# Setting up another protonmail

IMAPAccount protonmail
Host 127.0.0.1
Port 1143
User email@protonmail.com
Pass PASSWORD 
# Alternatively password can be encrypted and retrieve it with:
# PassCmd "gpg2 -q --for-your-eyes-only --no-tty -d ~/.config/mu4e/protonmail-passwd.gpg"
AuthMechs LOGIN
SSLType None

IMAPStore protonmail-remote
Account protonmail

MaildirStore protonmail-local 
Path ~/Maildir/protonmail/
Inbox ~/Maildir/protonmail/INBOX

Channel inbox
Master :protonmail-remote:
Slave :protonmail-local:
Patterns *
Create Slave
SyncState *

Group protonmail
Channel inbox
```   

Make sure directories for all accounts are created inside home directory: Ex: `mkdir -p ~/Maildir/vertilux`.   
Then run:   
- time mu init --maildir=~/Maildir --my-address='email@vertilux.com'   
- time mbsync -c ~/.mbsyncrc -a   

Inside Doom Emacs install mu4e package: `nvim .doom.d/packages.el` and add `(package! mu4e)` at the en of the file.   

Update the config.el `nvim .doom.d/config.el`:   

```
(setq user-full-name "Jose Perez"
      user-mail-address "email.perez@vertilux.com"

      mu4e-get-mail-command "mbsync -c ~/.mbsyncrc -a"
      mu4e-update-interval 180
      mu4e-headers-auto-update t
      mu4e-main-buffer-hide-personal-addresses t
      message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      mu4e-sent-folder "/vertilux/sent"
      mu4e-drafts-folder "/vertilux/draft"
      mu4e-trash-folder "/vertilux/trash"
      mu4e-maildir-shortcuts
      '(("/vertilux/Inbox"    . ?i)
        ("/vertilux/sent"     . ?s)
        ("/vertilux/draft"    . ?d)
        ("/vertilux/trash"    . ?t)
        ("/protonmail/INBOX"  . ?p))
)
```

For multiple accounts create a new file inside `.doom.d` directory, `nvim .doom.d/email` and load the from the config adding this line: `(load "~/.doom.d/email")`.   

```
 (defvar my-mu4e-account-alist
   '(("protonmail"
      (mu4e-sent-folder "/protonmail/Sent")
      (mu4e-drafts-folder "/protonamil/Drafts")
      (mu4e-trash-folder "/protonmail/Trash")
      (mu4e-compose-signature
        (concat
          "Lepepe\n"
          "email@protonmail.com\n"))
      (user-mail-address "email@protonmail.com")
      (smtpmail-smtp-server "127.0.0.1")
      (smtpmail-smtp-user "email@protonmail.com")
      (smtpmail-stream-type starttls)
      (smtpmail-smtp-service 1025))
     ("vertilux"
      (mu4e-sent-folder "/vertilux/sent")
      (mu4e-drafts-folder "/vertilux/draft")
      (mu4e-trash-folder "/vertilux/trash")
      (mu4e-compose-signature
        (concat
          "Jose Perez\n"
          "email@vertilux.com\n"))
      (user-mail-address "email@vertilux.com")
      (smtpmail-default-smtp-server "smtp.gmail.com")
      (smtpmail-smtp-server "smtp.gmail.com")
      (smtpmail-smtp-user "email@vertilux.com")
      (smtpmail-stream-type starttls)
      (smtpmail-smtp-service 587))))
```

**Function to switching between accounts**

Update `config.el` and add the block, this function then needs to be added to mu4e-compose-pre-hook.   

```
(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
    (if mu4e-compose-parent-message
      (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
        (string-match "/\\(.*?\\)/" maildir)
        (match-string 1 maildir))
        (completing-read (format "Compose with account: (%s) "
           (mapconcat #'(lambda (var) (car var))
              my-mu4e-account-alist "/"))
           (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
           nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
  (if account-vars
    (mapc #'(lambda (var)
      (set (car var) (cadr var)))
        account-vars)
    (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
```

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
|pipe symbol|narrow the search|
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
|`\`|pipe message through shell command|
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

