;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;;(require 'smtpmail)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jose Perez"
      user-mail-address "jose.perez@vertilux.com"

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

(load "~/.doom.d/email")

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

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Customs variables
;;
;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(90 95))
(add-to-list 'default-frame-alist '(alpha 90 95))

(after! org
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-directory "~/Org/"
        org-agenda-files '("~/Org/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-log-done 'time
        org-journal-dir "~/Org/journal/"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"
        org-hide-emphasis-markers t
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "GYM(g)"            ; Things to accomplish at the gym
             "PROJ(p)"           ; A project that contains other tasks
             "VIDEO(v)"          ; Video assignments
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" ))) ; Task has been cancelled

  ; Set auth-resource default source as .authinfo
  (setq auth-sources
        '((:source "~/.authinfo"))))

(defun apis_auth (&rest search-spec)

  (dolist (default '((:max . 1) (:require . (:secret))))
    (plist-put search-spec (car default) (cdr default)))

  (let ((entry (nth 0 (apply 'auth-source-search search-spec))))
    (mapcar (lambda (e)
              (let ((prop  (car e))
                    (value (if (functionp (cadr e))
                               (funcall (cadr e))
                             (cadr e))))
                (cons prop value)))
            (seq-partition entry 2))))


(use-package slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config
  (slack-register-team
   :name "vertilux"
   :default t
   :token "xoxc-215631003570-218617134611-2409437850770-538b64ae6414b127e5d9cba57280d6bd72faa77157d51e63c5815941f1f71c91"
   :subscribed-channels '(vertilux)
   :full-and-display-names t))
