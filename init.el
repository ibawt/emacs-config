(setq user-emacs-directory "~/.emacs.d")
(setenv "PATH" (concat (getenv "PATH") ":/opt/boxen/homebrew/shims"))
(setq exec-path (append '("/opt/boxen/homebrew/bin" "/opt/boxen/homebrew/shims") exec-path))
(setq enh-ruby-program "/opt/boxen/homebrew/shims/ruby")
(add-hook 'before-save-hook 'whitespace-cleanup)
(require 'cl)				; common lisp goodies, loop
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/elpa")
(package-initialize)
(setq-default tab-width 2)
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))
(setq minitest-default-env "SHOW_DOTS=1")

(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") `comment-or-uncomment-region)
(global-set-key (kbd "C-+") `text-scale-increase)
(global-set-key (kbd "C--") `text-scale-decrease)
(global-set-key (kbd "<C-tab>") `company-complete)
(show-paren-mode t)
(add-hook 'after-init-hook 'global-company-mode)

(setq package-archives
          '(("marmalade" . "http://marmalade-repo.org/packages/")
            ("melpa" . "http://melpa.milkbox.net/packages/")))
;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes
;; (setq
;;  el-get-sources
;;  '((:name buffer-move			; have to add your own keys
;;		:after (lambda ()
;;       (global-set-key (kbd "<C-S-up>")     'buf-move-up)
;;       (global-set-key (kbd "<C-S-down>")   'buf-move-down)
;;       (global-set-key (kbd "<C-S-left>")   'buf-move-left)
;;       (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

;;   (:name smex				; a better (ido like) M-x
;;		:after (lambda ()
;;       (setq smex-save-file "~/.emacs.d/.smex-items")
;;       (global-set-key (kbd "M-x") 'smex)
;;       (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

;;   (:name goto-last-change		; move pointer back to last change
;;		:after (lambda ()
;;       ;; when using AZERTY keyboard, consider C-x C-_
;;       (global-set-key (kbd "C-x C-/") 'goto-last-change)))))

;; now set our own packages
;; (setq
;;  my:el-get-packages
;;  '(el-get				; el-get is self-hosting
;;   escreen									; screen for emacs, C-\ C-h
;;   php-mode-improved			; if you're into php...
;;   switch-window			; takes over C-x o
;;   auto-complete			; complete as you type with overlays
;;   zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
;;   color-theme										; nice looking emacs
;;   color-theme-tango))									; check out color-theme-solarized
;;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
;; (when (el-get-executable-find "svn")
;;   (loop for p in '(psvn				; M-x svn-status
;;        yasnippet		; powerful snippet mode
;;        )
;;   do (add-to-list 'my:el-get-packages p)))

;; (setq my:el-get-packages
;;			(append
;;       my:el-get-packages
;;       (loop for src in el-get-sources collect (el-get-source-name src))))
;(setq tab-width 2)
;; install new packages and init already installed packages
;(el-get 'sync my:el-get-packages)
(defun coffee-custom ()
  "coffee-mode-hook"
  (make-local-variable 'tab-width)
  (set 'tab-width 2)
  )


(defun js-custom ()
  "coffee-custmo"
  (set 'tab-width 2)
  (setq indent-tabs-mode nil)
  (setq js-indent-level 2)
 )
(add-hook 'js-mode-hook 'js-custom)
(add-hook 'coffee-mode-hook 'coffee-custom)

(defun custom-c++ ()
  "c++ custom"
  (setq indent-tabs-mode nil)
  (c-set-offset 'inextern-lang 0)
  (setq c-basic-offset 4))


(add-hook 'c-mode-common-hook 'custom-c++)
(add-hook 'c++-mode-hook 'custom-c++)

(defun ruby-custom ()
  "ruby-mode-hook"
  (minitest-mode)
  )
(add-hook 'ruby-mode-hook 'ruby-custom)

(defun lua-custom()
  "lua-custom-hook"
  (setq indent-tabs-mode nil))

(add-hook 'lua-mode-hook 'lua-custom)
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

(setq indent-tabs-mode nil)
(add-hook 'html-mode '(progn
      (setq sgml-basic-offset 2)
      (setq indent-tabs-mode nil)
))

(add-hook 'rhtml-mode '(progn
       (setq tab-width 2
             indent-tabs-mode nil
             )
       ))

;; on to the visual settings
(setq inhibit-splash-screen t)		; no splash screen, thanks
(line-number-mode 1)			; have line numbers and
(column-number-mode 1)			; column numbers in the mode line

(tool-bar-mode -1)			; no tool bar with icons
(scroll-bar-mode -1)			; no scroll bars
(unless (string-match "apple-darwin" system-configuration)
  ;; on mac, there's always a menu bar drown, don't have it empty
  (menu-bar-mode -1))

;; choose your own fonts, in a system dependant way
(set-face-font 'default "SourceCodePro-Regular-13")
(global-linum-mode 1)			; add line numbers on the left

;; avoid compiz manager rendering bugs
(add-to-list 'default-frame-alist '(alpha . 100))

;; copy/paste with C-c and C-v and C-x, check out C-RET too
(cua-mode)

;; under mac, have Command as Meta and keep Option for localized input
(when (string-match "apple-darwin" system-configuration)
  (setq mac-allow-anti-aliasing t)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

; winner-mode provides C-<left> to get back to previous window layout
(winner-mode 1)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)
(require 'ansi-color)

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

;; default key to switch buffer is C-x b, but that's not easy enough
;;
;; when you do that, to kill emacs either close its frame from the window
;; manager or do M-x kill-emacs.  Don't need a nice shortcut for a once a
;; week (or day) action.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)
(global-set-key (kbd "C-x f") 'helm-browse-project)
;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)
;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
           (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)
(global-set-key (kbd "C-x C-z") 'magit-status)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes (quote ("f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "a3d519ee30c0aa4b45a277ae41c4fa1ae80e52f04098a2654979b1ab859ab0bf" "65ae93029a583d69a3781b26044601e85e2d32be8f525988e196ba2cb644ce6a" "9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" default)))
 '(erc-modules (quote (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands notifications readonly ring services stamp track)))
 '(pivotal-api-token "b2cc843a05cc0f3114871e845f26a0c1")
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'yasnippet)
(yas-global-mode 1)

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))
(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Clean the whitespace of a buffer"
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(require 'helm-ls-git)
(setq org-agenda-files (list "~/Code/org/work.org"
                             "~/Code/org/home.org"))
(global-set-key (kbd "C-c n") 'cleanup-buffer)
(load-theme 'base16-railscasts)
 (defun gtags-root-dir ()
    "Returns GTAGS root directory or nil if doesn't exist."
    (with-temp-buffer
      (if (zerop (call-process "global" nil t nil "-pr"))
          (buffer-substring (point-min) (1- (point-max)))
        nil)))
(defun gtags-update ()
  "Make GTAGS incremental update"
  (call-process "global" nil nil nil "-u"))
(defun gtags-update-hook ()
  (when (gtags-root-dir)
    (gtags-update)))

(add-hook 'after-save-hook #'gtags-update-hook)
