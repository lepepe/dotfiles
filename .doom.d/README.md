# Doom Emacs

### mu4e

#### Setting Up mu4e

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

Make sure directories for all accounts are inside home directory: Ex: `mkdir -p ~/Maildir/vertilux`.   
Then run:   
Initialized mu:   
- time mu init --maildir=~/Maildir --my-address='email@vertilux.com'   
Sync emails with:   
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
