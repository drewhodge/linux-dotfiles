;; -*- lexical-binding: t; -*-

; -------------------------------------------------------------------------- ;
; ~/.emacs.d/init.el                                                         ;
; -------------------------------------------------------------------------- ;
; History:                                                                   ;
; 02.Sep.2024    Initial setup.                                              ;
; -------------------------------------------------------------------------- ;


;; Table of contents
;(occur "^;;; ")
;; ------------------------------------------------------------------------- ;
;;; Name, email, int file location
;; ------------------------------------------------------------------------- ;
(setq user-full-name "Drew Hodge"
      user-mail-address "drew@drewhodge.org")

;; ------------------------------------------------------------------------- ;
;;; Package management
;; ------------------------------------------------------------------------- ;
;; Set up repos and package manager
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
			                   ("org" . "https://orgmode.org/elpa/")
                         ("gnu/elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Uncomment this to get a reading on packages that get loaded at startup
; (setq use-package-verbose t)

(require 'use-package)

; Ensures that each package that is configured using ~use-package~ is installed
(setq use-package-always-ensure t)

;; Bootstrap straight.el
;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 6))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))

;; ;; Always use straight to install on systems other than Linux
;; (setq straight-use-package-by-default (not (eq system-type 'gnu/linux)))

;; ;; Use straight.el for use-package expressions
;; (straight-use-package 'use-package)

;; ;; Load the helper package for commands like `straight-x-clean-unused-repos'
;; (require 'straight-x)

;; Add custom emacs lisp libraries to load-path
(push "~/.site-lisp/lisp" load-path)

;; ------------------------------------------------------------------------- ;
;;; Appearance
;; ------------------------------------------------------------------------- ;
;; No startup screen
(setq inhibit-startup-message t)

;; Show line numbers
(global-display-line-numbers-mode)

;; Tab settings
(setq-default tab-width 2)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

;; No blinking cursor.
(blink-cursor-mode -1)

;; Themes
(cond
 ((eq system-type 'gnu/linux)
;; ;; Grubox theme
(use-package gruvbox-theme
    :config
    ;; Load the theme of choice:
    ;(load-theme 'gruvbox-dark-soft :no-confirm)
    (load-theme 'gruvbox-dark-medium :no-confirm)
    ;(load-theme 'gruvbox-dark-hard :no-confirm)
  ))

((eq system-type 'darwin)
;; Ef-themes
;; If you like two specific themes and want to switch between them, you
;; can specify them in `ef-themes-to-toggle' and then invoke the command
;; `ef-themes-toggle'.  All the themes are included in the variable
;; `ef-themes-collection'.
(use-package ef-themes
  :config
  (setq ef-themes-to-toggle '(ef-elea-dark ef-light))

  (setq ef-themes-headings ; read the manual's entry or the doc string
      '((0 fixed-pitch regular 1.2)
        (1 fixed-pitch regular 1.2)
        (2 fixed-pitch regular 1.2)
        (3 fixed-pitch regular 1.2)
        (4 fixed-pitch regular 1.2)
        (5 fixed-pitch regular 1.2)
        (6 fixed-pitch regular 1.2)
        (7 fixed-pitch regular 1.2)
        (t fixed-pitch regular 1.2)))

  ;; They are nil by default...
  (setq ef-themes-mixed-fonts nil
        ef-themes-variable-pitch-ui nil)

  ;; Read the doc string or manual for this one.  The symbols can be
  ;; combined in any order.
  (setq ef-themes-region '(intense no-extend neutral))

  ;; Disable all other themes to avoid awkward blending:
  (mapc #'disable-theme custom-enabled-themes)

  ;; Load the theme of choice:
  (load-theme 'ef-autumn :no-confirm)

  ;; OR use this to load the theme which also calls `ef-themes-post-load-hook':
  ;(ef-themes-select 'ef-autumn)

  ;; The themes we provide are recorded in the `ef-themes-dark-themes',
  ;; `ef-themes-light-themes'.

  ;; We also provide these commands, but do not assign them to any key:
  ;;
  ;; - `ef-themes-toggle'
  ;; - `ef-themes-select'
  ;; - `ef-themes-select-dark'
  ;; - `ef-themes-select-light'
  ;; - `ef-themes-load-random'
  ;; - `ef-themes-preview-colors'
  ;; - `ef-themes-preview-colors-current'
)))

;; Emacs app
(use-package emacs
  :config
  (cond
   ((eq system-type 'darwin)
    (set-frame-size (selected-frame) 180 60)))
  (set-cursor-color "orange")
)

;; Typefaces
;; Set default typeface conditionally (depending on the OS)
(cond
 ((eq system-type 'darwin)
  ;; macOS-specific configuration
  (set-face-attribute 'default nil
                    :font "Aporetic Sans Mono"
                    :weight 'light
                    :height 130)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil
                    :font "Aporetic Sans Mono"
                    :weight 'light
                    :height 130))

 ((eq system-type 'gnu/linux)
  ;; Linux-specific configuration
  (set-face-attribute 'default nil
                    :font "JetBrainsMonoNF"
                    :weight 'light
                    :height 90)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil
                    :font "JetBrainsMonoNF"
                    :weight 'light
                    :height 90)))


;; Modeline
(use-package doom-modeline
  ;:ensure t
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-time-icon t)
  (setq doom-modeline-unicode-fallback nil)
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
  (setq doom-modeline-indent-info nil)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-env-load-string "..."))

; Show column numbers
(setq column-number-mode t)

;; Spacious-padding: increase spacing/padding in windows and frames.
(use-package spacious-padding
  :config

;; These is the default value, but I keep it here for visiibility.
(setq spacious-padding-widths
      '( :internal-border-width 5
         :header-line-width 4
         :mode-line-width 6
         :tab-width 4
         :right-divider-width 30
         :scroll-bar-width 8
         :fringe-width 8))

  ;; Read the doc string of `spacious-padding-subtle-mode-line' as it
  ;; is very flexible and provides several examples.
  (setq spacious-padding-subtle-mode-line
        '(:mode-line-active error))

  (spacious-padding-mode 1)

  ;; Set a key binding if you need to toggle spacious padding.
  (define-key global-map (kbd "<f8>") #'spacious-padding-mode)
  )

;; ------------------------------------------------------------------------- ;
;;; Global settings
;; ------------------------------------------------------------------------- ;

;; Meow-edit (modal editing)
(use-package meow
  :config

  (defun meow-setup ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    (meow-motion-overwrite-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     ;; SPC j/k will run the original command in MOTION state.
     '("j" . "H-j")
     '("k" . "H-k")
     ;; Use SPC (0-9) for digit arguments.
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-delete)
     '("D" . meow-backward-delete)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("I" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("s" . meow-kill)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-line)
     '("X" . meow-goto-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)))

  (meow-setup)
  (meow-global-mode 1)
  )

;; Sow empty lines in a buffer
(setq-default indicate-empty-lines t)

;; Toggle input method -- Greek character input and composition (postfix).
(setq default-input-method "greek-ibycus4")

;; Spelling
(setq ispell-program-name "/usr/local/bin/aspell")
(setq ispell-dictionary "en_GB")
(setq ispell-program-name "aspell")
(setq ispell-silently-savep t)

;; Turn off sounds and enable 'visual bell'.
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; Define prefixed key bindings.
(use-package general
  :config

  (general-create-definer dh/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer dw/ctrl-c-keys
    :prefix "C-c"))

;; Define key bindings for org-mode commands that must be available everywhere
;; in Emacs.
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Line numbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Set fill column.
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Replace yes/no prompts with y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Prefer UTF 8, but don't override current encoding if specified
(prefer-coding-system 'utf-8-unix)

;; Ovwerite/replace the active region just by typing text
(delete-selection-mode 1)

;; Use ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Show tool tips in echo area
(tooltip-mode -1)
(setq tooltip-use-echo-area t)

;; Dictionary
(setq switch-to-buffer-obey-display-actions t)
(add-to-list 'display-buffer-alist
   '("^\\*Dictionary\\*" display-buffer-in-side-window
     (side . left)
     (window-width . 85)))

;; Get overview of keybindings available based on the prefix keys
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Treemacs
;; (use-package treemacs
;;   :ensure t
;;   :defer t
;;   :init
;;   (with-eval-after-load 'winum
;;     (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
;;   :config
;;   (progn
;;     (setq treemacs-buffer-name-function            #'treemacs-default-buffer-name
;;           treemacs-buffer-name-prefix              " *Treemacs-Buffer-"
;;           treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
;;           treemacs-deferred-git-apply-delay        0.5
;;           treemacs-directory-name-transformer      #'identity
;;           treemacs-display-in-side-window          t
;;           treemacs-eldoc-display                   'simple
;;           treemacs-file-event-delay                2000
;;           treemacs-file-extension-regex            treemacs-last-period-regex-value
;;           treemacs-file-follow-delay               0.2
;;           treemacs-file-name-transformer           #'identity
;;           treemacs-follow-after-init               t
;;           treemacs-expand-after-init               t
;;           treemacs-find-workspace-method           'find-for-file-or-pick-first
;;           treemacs-git-command-pipe                ""
;;           treemacs-goto-tag-strategy               'refetch-index
;;           treemacs-header-scroll-indicators        '(nil . "^^^^^^")
;;           treemacs-hide-dot-git-directory          t
;;           treemacs-indentation                     2
;;           treemacs-indentation-string              " "
;;           treemacs-is-never-other-window           nil
;;           treemacs-max-git-entries                 5000
;;           treemacs-missing-project-action          'ask
;;           treemacs-move-files-by-mouse-dragging    t
;;           treemacs-move-forward-on-expand          nil
;;           treemacs-no-png-images                   nil
;;           treemacs-no-delete-other-windows         t
;;           treemacs-project-follow-cleanup          nil
;;           treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
;;           treemacs-position                        'left
;;           treemacs-read-string-input               'from-child-frame
;;           treemacs-recenter-distance               0.1
;;           treemacs-recenter-after-file-follow      nil
;;           treemacs-recenter-after-tag-follow       nil
;;           treemacs-recenter-after-project-jump     'always
;;           treemacs-recenter-after-project-expand   'on-distance
;;           treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
;;           treemacs-project-follow-into-home        nil
;;           treemacs-show-cursor                     nil
;;           treemacs-show-hidden-files               t
;;           treemacs-silent-filewatch                nil
;;           treemacs-silent-refresh                  nil
;;           treemacs-sorting                         'alphabetic-asc
;;           treemacs-select-when-already-in-treemacs 'move-back
;;           treemacs-space-between-root-nodes        t
;;           treemacs-tag-follow-cleanup              t
;;           treemacs-tag-follow-delay                1.5
;;           treemacs-text-scale                      nil
;;           treemacs-user-mode-line-format           nil
;;           treemacs-user-header-line-format         nil
;;           treemacs-wide-toggle-width               70
;;           treemacs-width                           35
;;           treemacs-width-increment                 1
;;           treemacs-width-is-initially-locked       t
;;           treemacs-workspace-switch-cleanup        nil)

;;     ;; The default width and height of the icons is 22 pixels. If you are
;;     ;; using a Hi-DPI display, uncomment this to double the icon size.
;;     ;;(treemacs-resize-icons 44)

;;     (treemacs-follow-mode t)
;;     (treemacs-filewatch-mode t)
;;     (treemacs-fringe-indicator-mode 'always)
;;     (when treemacs-python-executable
;;       (treemacs-git-commit-diff-mode t))

;;     (pcase (cons (not (null (executable-find "git")))
;;                  (not (null treemacs-python-executable)))
;;       (`(t . t)
;;        (treemacs-git-mode 'deferred))
;;       (`(t . _)
;;        (treemacs-git-mode 'simple)))

;;     (treemacs-hide-gitignored-files-mode nil))
;;   :bind
;;   (:map global-map
;;         ("M-0"       . treemacs-select-window)
;;         ("C-x t 1"   . treemacs-delete-other-windows)
;;         ("C-x t t"   . treemacs)
;;         ("C-x t d"   . treemacs-select-directory)
;;         ("C-x t B"   . treemacs-bookmark)
;;         ("C-x t C-t" . treemacs-find-file)
;;         ("C-x t M-t" . treemacs-find-tag)))

;; (use-package treemacs-projectile
;;   :after (treemacs projectile)
;;   :ensure t)

;; (use-package treemacs-magit
;;   :after (treemacs magit)
;;   :ensure t)

;; (use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
;;   :after (treemacs persp-mode) ;;or perspective vs. persp-mode
;;   :ensure t
;;   :config (treemacs-set-scope-type 'Perspectives))

;; (use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
;;   :after (treemacs)
;;   :ensure t
;;   :config (treemacs-set-scope-type 'Tabs))

;; ;; Treemacs icons
;; (use-package treemacs-all-the-icons
;;   ;:ensure t
;;   :config
;;   (treemacs-load-theme "all-the-icons")
;;  )

;; Clean up whitespace automatically.
(use-package ws-butler
  :hook ((text-mode . ws-butler-mode)
         (prog-mode . ws-butler-mode)))

;; Highlight colour strings.
(use-package rainbow-mode
  :defer t
  :hook (org-mode
         emacs-lisp-mode
         web-mode))

;; Match parentheses
(use-package paren
  :config
  (set-face-attribute 'show-paren-match-expression nil :background "#dba11a")
  (show-paren-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Stateful keymaps
(use-package hydra
  :defer 1)

;; Remeber recent files
(recentf-mode 1)

;; Persist history over Emacs restarts.
(use-package savehist
  :init
  (savehist-mode))

;; Remember minibuffer history
(setq history-length 25)
(savehist-mode 1)

;; Change location of 'custom file'
;; Moves customiztion variable to a file other than init.el and loads the file.
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Put backup files in ~/.trash.
(setq backup-directory-alist '((".*" . "~/.Trash")))

;; Enter debug mode when encountering an error.
(setq set-debug-on-error t)

;; Use Prot's Pulsar package (show and highlight current line)
;; Make available the elisp files in the following directory:.
(use-package pulsar
  :config
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.055)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'pulsar-yellow)
  (setq pulsar-highlight-face 'pulsar-yellow)

  (pulsar-global-mode 1)

  ; OR use the local mode for select mode hooks

  (dolist (hook '(org-mode-hook emacs-lisp-mode-hook))
  (add-hook hook #'pulsar-mode))

  ;; pulsar does not define any key bindings.  This is just a sample that
  ;; respects the key binding conventions.  Evaluate:
  ;;
  ;;     (info "(elisp) Key Binding Conventions")
  ;;
  ;; Prot uses C-x l for `pulsar-pulse-line' and C-x L for
  ;; `pulsar-highlight-line'.
  ;;
  ;; You can replace `pulsar-highlight-line' with the command
  ;; `pulsar-highlight-dwim'.
  (let ((map global-map))
    (define-key map (kbd "C-c h p") #'pulsar-pulse-line)
    (define-key map (kbd "C-c h h") #'pulsar-highlight-line))
)

;; Use Prot's Logos package (for easier paging)
(use-package logos
  :config
  ; To use outlines instead of page breaks (the ^L), set the following variable
  ; to 't'. To insert the '^L' page break delimiter, type 'C-q C-l'.
  (setq logos-outlines-are-pages nil)

  ; Default values for page breaks using outlines:
  (setq logos-outline-regexp-alist
        `((emacs-lisp-mode . "^;;;+ ")
          (org-mode . "^\\*+ +")
          (markdown-mode . "^\\#+ +")))

  ; The following settings apply when `logos-focus-mode' is enabled.  Their
  ; values are buffer-local.
  (setq-default logos-hide-cursor nil
                logos-hide-mode-line t
                logos-hide-buffer-boundaries t
                logos-hide-fringe t
                logos-variable-pitch nil
                logos-buffer-read-only nil
                logos-scroll-lock nil
                logos-olivetti nil)

  ; Check the manual for `logos-focus-mode-hook'--it extends `logos-focus-mode'.
  (let ((map global-map))
    (define-key map [remap narrow-to-region] #'logos-narrow-dwim)
    (define-key map [remap forward-page] #'logos-forward-page-dwim)
    (define-key map [remap backward-page] #'logos-backward-page-dwim)
    (define-key map (kbd "<f9>") #'logos-focus-mode))

  ; Consider adding keys to `logos-focus-mode-map'.  They will take
  ; effect when `logos-focus-mode' is enabled.
  )

;; Use Prot's TMR package to set timers.
;; See: https://protesilaos.com/emacs/tmr
(use-package tmr
  :ensure t
  :config
  (define-key global-map (kbd "C-c t") #'tmr-prefix-map)
  (setq tmr-sound-file "~/.emacs.d/timer-terminer-342934.mp3"
        tmr-notification-urgency 'normal
        tmr-description-list 'tmr-description-history)
  (add-to-list 'warning-suppress-types '(tmr)) ; Supress desktop warning.
  )

;; ------------------------------------------------------------------------- ;
;;; Completion
;; ------------------------------------------------------------------------- ;

;; Corfu (in-buffer completion).
(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (text-mode-ispell-word-completion nil)

  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p)
  )

;; Dabbrev
;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\` ")
  ;; Since 29.1, use `dabbrev-ignored-buffer-regexps' on older.
  (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
  (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode)
  )

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)
  :custom
  (vertico-sort-function 'vertico-sort-history-alpha))

;; Persist history over Emacs restarts.
(use-package savehist
  :init
  (savehist-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles partial-completion)))))

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :bind (:map minibuffer-local-map;
	 ("M-A". marginalia-cycle))
  :init
  (marginalia-mode))

;; Consult provides search and navigation commands based on the Emacs completion
;; function completing-read.
(use-package consult
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c q h" . consult-history)
         ("C-c q k" . consult-kmacro)
         ("C-c q m" . consult-man)
         ("C-c q i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

;; Integrate denote with the consult package
;; https://github.com/protesilaos/consult-denote
(use-package consult-denote
  :ensure t
  :bind
  (("C-c n f" . consult-denote-find)
   ("C-c n g" . consult-denote-grep))
  :config
  (consult-denote-mode 1))

;; ------------------------------------------------------------------------- ;
;;; File management (dired)
;; ------------------------------------------------------------------------- ;

;; Specific dired settings
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(use-package all-the-icons-dired
  ;:ensure nil
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  (setq all-the-icons-dired-monochrome nil)
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired nil))
  (setq dired-listing-switches "-la"
        dired-omit-files "^\\.[^.].*"
        dired-omit-verbose nil
        dired-hide-details-hide-symlink-targets nil
        delete-by-moving-to-trash t)
  )

;; Dired sidebar
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Projectile -- project management
(use-package projectile
  :ensure t
  :pin melpa-stable
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

;; ------------------------------------------------------------------------- ;
;;; Org-mode, Markdown, Pandoc LaTeX, ODF, Ref management
;; ------------------------------------------------------------------------- ;

;; Set margins
(defun dh/org-mode-visual-fill ()
  (setq visual-fill-column-width 95
        visual-fill-column-center-text nil)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :defer t
  :hook (org-mode . dh/org-mode-visual-fill))

;; Turn on indentation and auto-fill mode for Org files
(defun dh/org-mode-setup ()
  (org-indent-mode -1)
  ; (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package org
  ;:ensure nil
  :defer t
  :hook (org-mode . dh/org-mode-setup)
  ;:load-path ("~/gitrepos/emacs-org/lisp")
  :config
  (setq org-ellipsis "  ..."
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-startup-folded 'content
        org-cycle-separator-lines 2)

  ;; (setq org-modules
  ;;       '(org-crypt
  ;;         org-habit
  ;;         org-bookmark))

  ;; Ensure the ASCII backend is loaded for org-export.
  (require 'ox-ascii)

  (setq org-refile-targets '((nil :maxlevel . 1)
                             (org-agenda-files :maxlevel . 1)))

  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path t)
  ;; Prevent inadvertent edits of an invisible part of an org-mode buffer.
  (setq org-fold-catch-invisible-edits t)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (lua . t)))

  ;; Fontifycode in code blocks
  (setq org-src-fontify-natively t
        org-src-preserve-indentation t
        org-src-tab-acts-natively t)

  ;; Heading colurs
  (set-face-attribute 'org-level-1 nil :foreground "#6495ed")
  (set-face-attribute 'org-level-2 nil :foreground "#6495ed")
  (set-face-attribute 'org-level-3 nil :foreground "#6495ed")
  (set-face-attribute 'org-level-4 nil :foreground "#6495ed")
  (set-face-attribute 'org-level-5 nil :foreground "#6495ed")
  (set-face-attribute 'org-level-6 nil :foreground "#6495ed")
  (set-face-attribute 'org-level-7 nil :foreground "#6495ed")
  (set-face-attribute 'org-level-8 nil :foreground "#6495ed")

  ;; ;; Increase the size of various headings
  ;; (set-face-attribute 'org-document-title nil :font "JetBrains Mono" :weight 'medium :height 1.2)
  ;; (dolist (face '((org-level-1 . 1.2)
  ;;                 (org-level-2 . 1.1)
  ;;                 (org-level-3 . 1.05)
  ;;                 (org-level-4 . 1.05)
  ;;                 (org-level-5 . 1.05)
  ;;                 (org-level-6 . 1.05)
  ;;                 (org-level-7 . 1.05)
  ;;                 (org-level-8 . 1.05)))
  ;; (set-face-attribute (car face) nil :font "JetBrains Mono" :weight 'medium :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  ;(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

  ;; Get rid of the background on column views
  (set-face-attribute 'org-column nil)
  (set-face-attribute 'org-column-title nil)

  ;; Src-block template.
  ;; Example: type <el then press Tab to expand the template.
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src sh"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
  (add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("json" . "src json"))

  ;; Workflow states
  (setq org-todo-keywords
        (quote
         ((sequence "TODO(@/!)" "IN-PROGRESS(@/!)" "PENDING(P@/!)" "DONE(D@/!)"))))

   (setq org-todo-keyword-faces
        (quote
         (("TODO" . "#cc241d")
          ("IN-PROGRESS" . "#d65d0e")
          ("PENDING" . "#d79921")
          ("DONE" . "#00cd00"))))

  ;; Configure common tags
   (setq org-tag-alist
         '((:Startgroup)
          ; Put mutually exclusive tags here
         (:endgroup)
         ("@home" . ?H)
         ("@work" . ?W)
         ("batch" . ?b)
         ("followup" . ?f)))

  ;; Org journal setup
  (setq org-agenda-files (quote ("~/org/todo.org")))
  (setq org-journal-dir "~/org/journal/")
  (setq org-journal-date-format "%A, %d %B %Y")

  ;; Org capture (Deprecated date/weektree capture templates changed to file+olp+datetree.)
  (setq org-default-notes-file (concat org-directory "~/org/notes/notes.org"))
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("J" "Journal(= (org)" entry (file+olp+datetree "~/org/journal/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("w" "Link from browser" entry (file "~/org//inbox/inbox.org")
           "* %? |- (%:description) :BOOKMARK:\n:PROPERTIES:\n:CREATED: %U\n:Source: %:link\n:END:\n%i\n")
          ("s" "Selection from browser" entry (file "~/org//inbox/inbox.org")
           "* %? :BOOKMARK:\n%(replace-regexp-in-string \"\n.*\" \"\" \"%i\")\n:PROPERTIES:\n:CREATED: %U\n:Source: %:link\n:END:\n%i\n")))
)

;; Auto-tangle
;; Add the option '#+auto_tangle: t' in the org file front matter.
(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

;; Citations
(use-package ivy-bibtex
  ;:ensure t
  :config
  (setq bibtex-completion-bibliography '("~/biblio/core.lib.bib"
                                         "~/biblio/testing.bib")
        bibtex-completion-library-path '("~/biblio/bibtex-pdfs/")
	      bibtex-completion-notes-path "~/biblio/notes/"
      	bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"
	      bibtex-completion-additional-search-fields '(keywords)
	      bibtex-completion-display-formats
        '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
          (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
          (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
	        (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
	        (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
        bibtex-completion-pdf-open-function
        (lambda (fpath)
          (call-process "open" nil 0 nil fpath))))

;; Change the bibtex-dialect variable to biblatex.
(setq bibtex-dialect 'biblatex)

;; Citation management
(use-package citar
  ;:ensure t
  :custom
  (citar-bibliography '("~/biblio/core.lib.bib"))
  (setq citar-templates
        '((main . "${author editor:30%sn} ${date year issued:4} ${title:48}")
          (suffix . " ${=key= id:15} ${=type=:12} ${tags keywords:*}")
          (preview . "${author editor:%etal} (${year issued date}) ${title}, ${journal journaltitle publisher container-title collection-title}.\n")
          (note . "Notes on ${author editor:%etal}, ${title}"))))

(use-package org-ref
  ;:ensure t
  :config
  (require 'bibtex)
  (setq bibtex-autokey-year-length 4
	      bibtex-autokey-name-year-separator "-"
	      bibtex-autokey-year-title-separator "-"
	      bibtex-autokey-titleword-separator "-"
	      bibtex-autokey-titlewords 2
	      bibtex-autokey-titlewords-stretch 1
	      bibtex-autokey-titleword-length 5)
  (define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)
  (define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)
  (define-key org-mode-map (kbd "s-[") 'org-ref-insert-link-hydra/body)
  ;(require 'org-ref-ivy)
  (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
	      org-ref-insert-cite-function 'org-ref-cite-insert-ivy
	      org-ref-insert-label-function 'org-ref-insert-label-link
	      org-ref-insert-ref-function 'org-ref-insert-ref-link
	      org-ref-cite-onclick-function
        (lambda (_) (org-ref-citation-hydra/body))))

;; Org citations--custom code by Protesilaos Stavrou
;; Defines the `prot-org-cite-regexp' variable.
(defvar prot-org-cite-regexp
  "\\(?1:cite: ?\\)?\\(?2:@\\)\\(?:[a-z]+\\)\\(?3:.*?\\)\\(?:[0-9]\\{4,\\}\\)\\(?:[a-z]\\)?"
  "Regular expression matching an Org citation.
Groups 1, 2, and 3 are meant to be hidden when the minor mode
`prot-org-cite-mode' is enabled.")

;; Define a function that overlays.  An "overlay" is an object
;; that covers a certain region in the buffer.
(defun prot-org-cite-add-overlays ()
  "Add invisible overlays to `prot-org-cite-regexp' numbered groups."
  (let ((case-fold-search nil))
    (save-excursion
      (save-restriction
        (widen)
        (goto-char (point-min))
        (while (re-search-forward prot-org-cite-regexp nil t)
          (dotimes (n 4)
            (unless (= n 0)
              (when-let* ((beg (match-beginning n))
                          (end (match-end n))
                          (overlay (make-overlay beg end)))
                (overlay-put overlay 'invisible t)
                ;; NOTE: I am not using the `after-string' in this case,
                ;; but am adding here as it is a useful paradigm in
                ;; general.
                ;;
                ;; (overlay-put overlay 'after-string "")
                (overlay-put overlay 'prot-org-cite-overlay t)))))))))

;; Function to revert `prot-org-cite-add-overlays'.
(defun prot-org-cite-remove-overlays ()
  "Remove all `prot-org-cite-overlay' overlays from the current buffer."
  (when-let* ((overlays (save-restriction
                          (widen)
                          (overlays-in (point-min) (point-max))))
              (our-overlays (seq-filter
                             (lambda (overlay)
                               (overlay-get overlay 'prot-org-cite-overlay))
                             overlays)))
    (mapc #'delete-overlay our-overlays)))

(defface prot-org-cite '((t :inherit shadow))
  "Face for Org citations when `prot-org-cite-mode' is enabled.")

(defvar-local prot-org-cite-face-remap-object nil
  "Object of `face-remap-add-relative' for `prot-org-cite'.")

(defun prot-org-cite-remap-face (&optional unmap)
  "Remap the `org-cite-key' face to `prot-org-cite'.
With optional UNMAP, undo the remapping."
  (if unmap
      (progn
        (face-remap-remove-relative prot-org-cite-face-remap-object)
        (setq-local prot-org-cite-face-remap-object nil))
    (setq-local prot-org-cite-face-remap-object
                (face-remap-add-relative 'org-cite-key 'prot-org-cite))))

;; Simple toggle to do/undo stylistic changes.
(define-minor-mode prot-org-cite-mode
  "Partially hide Org citations and style them with `prot-org-cite'.
More specifically, hide groups 1, 2, and 3 of `prot-org-cite-regexp'."
  :global nil
  (if prot-org-cite-mode
      (progn
        (prot-org-cite-add-overlays)
        (prot-org-cite-remap-face))
    (prot-org-cite-remove-overlays)
    (prot-org-cite-remap-face :unmap-the-face)))

;; Org side tree
(use-package org-side-tree)

;; Pandoc,pandoc-mode and ox-pandoc (for Pandoc export)
;; (use-package pandoc)
;; (use-package ox-pandoc)

;; Markdown
(use-package markdown-mode
  ;:straight t
  :mode "\\.md\\'")

(use-package pdf-tools
  ;:ensure t
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
   :custom
   (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

;; Auctex, TeX, and LaTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; Set up for an  org-static-blog
(use-package org-static-blog
  ;:ensure t
  :config
  (setq org-static-blog-publish-title "My Static Org Blog")
  (setq org-static-blog-publish-url "https://staticblog.org/")
  (setq org-static-blog-publish-directory "~/projects/blog/")
  (setq org-static-blog-posts-directory "~/projects/blog/posts/")
  (setq org-static-blog-drafts-directory "~/projects/blog/drafts/")
  (setq org-static-blog-enable-tags t)
  (setq org-export-with-toc nil)
  (setq org-export-with-section-numbers nil)

  ;; This header is inserted into the <head> section of every page:
  ;;   (you will need to create the style sheet at
  ;;    ~/projects/blog/static/style.css
  ;;    and the favicon at
  ;;    ~/projects/blog/static/favicon.ico)
  (setq org-static-blog-page-header
        "<meta name=\"author\" content=\"John Dow\">
         <meta name=\"referrer\" content=\"no-referrer\">
         <meta name=\"viewport\" content=\"initial-scale=1,width=device-width,minimum-scale=1\">
         <link href= \"static/style.css\" rel=\"stylesheet\" type=\"text/css\" />
         <link rel=\"icon\" href=\"static/favicon.ico\">")

  ;; This preamble is inserted at the beginning of the <body> of every page:
  ;;   This particular HTML creates a <div> with a simple linked headline
  (setq org-static-blog-page-preamble
        "<div class=\"header\">
         <a href=\"https://staticblog.org\">My Static Org Blog</a>
         </div>")

  ;; This postamble is inserted at the end of the <body> of every page:
  ;;   This particular HTML creates a <div> with a link to the archive page
  ;;   and a licensing stub.
  (setq org-static-blog-page-postamble
         "<div id=\"archive\">
          <a href=\"https://staticblog.org/archive.html\">Other posts</a>
          </div>
          <center>
            <a rel=\"license\"
               href=\"https://creativecommons.org/licenses/by-sa/3.0/\">
              <img alt=\"Creative Commons License\"
                   style=\"border-width:0\"
                   src=\"https://i.creativecommons.org/l/by-sa/3.0/88x31.png\" />
            </a>
            <br />
            <span xmlns:dct=\"https://purl.org/dc/terms/\"
                  href=\"https://purl.org/dc/dcmitype/Text\"
                  property=\"dct:title\" rel=\"dct:type\">bastibe.de</span> by
            <a xmlns:cc=\"https://creativecommons.org/ns#\"
               href=\"https://bastibe.de\"
               property=\"cc:attributionName\"
               rel=\"cc:attributionURL\">Bastian Bechtold</a> is licensed under a
            <a rel=\"license\"
               href=\"https://creativecommons.org/licenses/by-sa/3.0/\">
               Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.
          </center>")

  ;; This HTML code is inserted into the index page between the preamble and
  ;;   the blog posts
  (setq org-static-blog-index-front-matter
        "<h1> Welcome to my blog </h1>\n"))

;; Local webserver to test sites under development.
(use-package simple-httpd)

;; Setup org-remark
(use-package org-remark
  ;:ensure t
  :custom
  (org-remark-notes-file-name #'org-remark-notes-file-name-function)
  :config
  (org-remark-global-tracking-mode +1)

  ;; Optional if you would like to highlight websites via eww-mode
  (with-eval-after-load 'eww
    (org-remark-eww-mode +1))

  ;; Key-bind `org-remark-mark' to global-map so that you can call it
  ;; globally before the library is loaded.
  (define-key global-map (kbd "C-c n m") #'org-remark-mark)

  ;; The rest of keybidings are done only on loading `org-remark'
  (with-eval-after-load 'org-remark
    (define-key org-remark-mode-map (kbd "C-c n o") #'org-remark-open)
    (define-key org-remark-mode-map (kbd "C-c n ]") #'org-remark-view-next)
    (define-key org-remark-mode-map (kbd "C-c n [") #'org-remark-view-prev)
    (define-key org-remark-mode-map (kbd "C-c n r") #'org-remark-remove)
    (define-key org-remark-mode-map (kbd "C-c n x") #'org-remark-delete)
    (define-key org-remark-mode-map (kbd "C-c n t") #'org-remark-toggle)
    (define-key org-remark-mode-map (kbd "C-c n 0") #'org-remark-mark-yellow) ; yellow underline (default pen)
    (define-key org-remark-mode-map (kbd "C-c n 1") #'org-remark-mark-red-line) ; red underline (default pen)
    (define-key org-remark-mode-map (kbd "C-c n 2") #'org-remark-mark-highlight-b) ; #1e90ff box
    (define-key org-remark-mode-map (kbd "C-c n 3") #'org-remark-mark-highlight-g) ; #00cd00 box
    (define-key org-remark-mode-map (kbd "C-c n 4") #'org-remark-mark-highlight-r) ; #b22222 box
    (define-key org-remark-mode-map (kbd "C-c n 5") #'org-remark-mark-highlight-y) ; #cd661d box
    )

  ;; Set up custom pens.
  (org-remark-create "highlight-y"
                     '(:box (:color "#cd661d" :style solid))
                     '(CATEGORY "takenote" help-echo "NB"))
  (org-remark-create "highlight-r"
                     '(:box (:color "#b22222"  :style solid))
                     '(CATEGORY "idea" help-echo "Idea/Claim/Statement"))
  (org-remark-create "highlight-b"
                     '(:box (:color "#1e90ff"  :style solid))
                     '(CATEGORY "connection" help-echo "Connection..."))
  (org-remark-create "highlight-g"
                     '(:box (:color "#00cd00"  :style solid))
                     '(CATEGORY "argument-proof" help-echo "Argument/Proof/Conclusioon"))
  ;; Override default pens.
  (org-remark-create "yellow"
                     '(:underline "gold")
                    ; '(:box "gold")
                     '(CATEGORY "important"))
  (org-remark-create "red-line"
                     '(:underline (:color "red" :style solid))
                     '(CATEGORY "review" help-echo "Review this")))


;; Disable linum mode when working with PDFs
(add-hook 'pdf-tools-mode-hook (lambda() (display-line-numbers-mode -1)))
(add-hook 'pdf-view-mode-hook (lambda() (display-line-numbers-mode -1)))

;; ------------------------------------------------------------------------- ;
;;; Notes
;; ------------------------------------------------------------------------- ;

;; Deft
(use-package deft
  :commands (deft)
  :config (setq deft-directory "~/org/deft"
                deft-recursive t
                deft-extensions '("md" "org")))

;; Denote
; [[https://protesilaos.com/emacs/denote#h:a09b70a2-ae0b-4855-ac14-1dddfc8e3241][Denote]]
; Denote aims to be a simple-to-use, focused-in-scope, and effective
; note-taking tool for Emacs.

;(add-to-list 'load-path "~/gitrepos/emacs-denote")
                                        ;(require 'denote)

(use-package denote
  :ensure t
  :hook
  ( ;; If you use Markdown or plain text files, then you want to make
   ;; the Denote links clickable (Org renders links as buttons right
   ;; away)
   (text-mode . denote-fontify-links-mode-maybe)
   ;; Apply colours to Denote names in Dired.  This applies to all
   ;; directories.  Check `denote-dired-directories' for the specific
   ;; directories you may prefer instead.  Then, instead of
   ;; `denote-dired-mode', use `denote-dired-mode-in-directories'.
   (dired-mode . denote-dired-mode))

  :bind
  ;; Define key bindings.
  ( :map global-map
    ("C-c n n" . denote)
    ("C-c n d" . denote-dired)
    ("C-c n g" . denote-grep)
    ;; If you intend to use Denote with a variety of file types, it is
    ;; easier to bind the link-related commands to the `global-map', as
    ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
    ;; `markdown-mode-map', and/or `text-mode-map'.
    ("C-c n l" . denote-link)
    ("C-c n L" . denote-add-links)
    ("C-c n b" . denote-backlinks)
    ("C-c n q c" . denote-query-contents-link) ; create link that triggers a grep
    ("C-c n q f" . denote-query-filenames-link) ; create link that triggers a dired
    ;; Note that `denote-rename-file' can work from any context, not just
    ;; Dired bufffers.  That is why we bind it here to the `global-map'.
    ("C-c n r" . denote-rename-file)
    ("C-c n R" . denote-rename-file-using-front-matter)

    ;; Key bindings specifically for Dired.
    :map dired-mode-map
    ("C-c C-d C-i" . denote-dired-link-marked-notes)
    ("C-c C-d C-r" . denote-dired-rename-files)
    ("C-c C-d C-k" . denote-dired-rename-marked-files-with-keywords)
    ("C-c C-d C-R" . denote-dired-rename-marked-files-using-front-matter))

  :config
  ;; Remember to check the doc strings of those variables.
  (cond
   ((eq system-type 'gnu/linux)
    (setq denote-directory (expand-file-name "~/gitrepos/zettelkasten/denote"))))
  (cond
   ((eq system-type 'darwin)
    (setq denote-directory (expand-file-name "~/zettelkasten/denote"))))
  (setq denote-save-buffers nil)
  (setq denote-known-keywords '("emacs" "philosophy" "theology"))
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-file-type 'markdown-yaml) ; Org is the default, set others here
  (setq denote-prompts '(title keywords))
  (setq denote-excluded-directories-regexp nil)
  (setq denote-excluded-keywords-regexp nil)
  (setq denote-rename-confirmations '(rewrite-front-matter modify-file-name))

  ;; Pick dates, where relevant, with Org's advanced interface:
  (setq denote-date-prompt-use-org-read-date t)

  ;; Automatically rename Denote buffers using the `denote-rename-buffer-format'.
  (denote-rename-buffer-mode 1)

  ;; Specify an org-capture template for a standard Denote note.
  (with-eval-after-load 'org-capture
    (setq denote-org-capture-specifiers "%l\n%i\n%?")
    (add-to-list 'org-capture-templates
                 '("n" "New note (with denote.el)" plain
                   (file denote-last-path)
                   #'denote-org-capture
                   :no-save t
                   :immediate-finish nil
                   :kill-buffer t
                   :jump-to-captured t))))

(use-package denote-journal
  :ensure t
  ;; Bind those to some key for your convenience.
  :commands ( denote-journal-new-entry
              denote-journal-new-or-existing-entry
              denote-journal-link-or-create-entry )
  :hook (calendar-mode . denote-journal-calendar-mode)
  :config
  ;; Use the "journal" subdirectory of the `denote-directory'.  Set this
  ;; to nil to use the `denote-directory' instead.
  (setq denote-journal-directory
        (expand-file-name "journal" denote-directory))
  ;; Default keyword for new journal entries. It can also be a list of
  ;; strings.
  (setq denote-journal-keyword "journal")
  ;; Read the doc string of `denote-journal-title-format'.
  (setq denote-journal-title-format 'day-date-month-year))

(use-package denote-silo
  :ensure t
  ;; Bind these commands to key bindings of your choice.
  :commands ( denote-silo-create-note
              denote-silo-open-or-create
              denote-silo-select-silo-then-command
              denote-silo-dired
              denote-silo-cd )
  :config
  ;; Add your silos to this list.  By default, it only includes the
  ;; value of the variable `denote-directory'.
  (setq denote-silo-directories
        (list denote-directory
              "~/Documents/personal/"
              "~/Documents/work/")))

(use-package denote-markdown
  :ensure t
  ;; Bind these commands to key bindings of your choice.
  :commands ( denote-markdown-convert-links-to-file-paths
              denote-markdown-convert-links-to-denote-type
              denote-markdown-convert-links-to-obsidian-type
              denote-markdown-convert-obsidian-links-to-denote-type ))

(use-package denote-org
  :ensure t
  :commands
  ;; I list the commands here so that you can discover them more
  ;; easily.  You might want to bind the most frequently used ones to
  ;; the `org-mode-map'.
  ( denote-org-link-to-heading
    denote-org-backlinks-for-heading

    denote-org-extract-org-subtree

    denote-org-convert-links-to-file-type
    denote-org-convert-links-to-denote-type

    denote-org-dblock-insert-files
    denote-org-dblock-insert-links
    denote-org-dblock-insert-backlinks
    denote-org-dblock-insert-missing-links
    denote-org-dblock-insert-files-as-headings))

(use-package denote-sequence
  :ensure t
  :bind
  ( :map global-map
    ;; Here we make "C-c n s" a prefix for all "[n]otes with [s]equence".
    ;; This is just for demonstration purposes: use the key bindings
    ;; that work for you.  Also check the commands:
    ;;
    ;; - `denote-sequence-new-parent'
    ;; - `denote-sequence-new-sibling'
    ;; - `denote-sequence-new-child'
    ;; - `denote-sequence-new-child-of-current'
    ;; - `denote-sequence-new-sibling-of-current'
    ;("C-c n s s" . denote-sequence)
    ;("C-c n s f" . denote-sequence-find)
    ;("C-c n s l" . denote-sequence-link)
    ;("C-c n s d" . denote-sequence-dired)
    ;("C-c n s r" . denote-sequence-reparent)
    ;("C-c n s c" . denote-sequence-convert)
    )
  :config
  ;; The default sequence scheme is `numeric'.
  (setq denote-sequence-scheme 'alphanumeric))

  ;; Denote menu
  ;; Loaded from cloned Git repository.
  ;(add-to-list 'load-path "~/gitrepos/denote-menu/")
  ;(require 'denote-menu)

  ; (add-to-list 'load-path "~/projects/denote-menu/")

(use-package denote-menu
  :config
  (setq denote-menu-title-column-width 40)

  (global-set-key (kbd "C-c z") #'list-denotes)

  (define-key denote-menu-mode-map (kbd "c") #'denote-menu-clear-filters)
  (define-key denote-menu-mode-map (kbd "/ r") #'denote-menu-filter)
  (define-key denote-menu-mode-map (kbd "/ k") #'denote-menu-filter-by-keyword)
  (define-key denote-menu-mode-map (kbd "/ o") #'denote-menu-filter-out-keyword)
  (define-key denote-menu-mode-map (kbd "e") #'denote-menu-export-to-dired)


  ;; Add a text to bibliography using an org-template:
  ;; 1. Find interesting paper online
  ;; 2. Copy its BiBTeX entry to clipboard.
  ;; 3. In emacs, open an org-capture template that requests the BibTeX,
  ;;    note title (defaults to the title of the entry), and  tags.
  ;; 4. In the capture window (Denote note with BiBTeX  org source block,
  ;;    write notes; then close the capture window (C-c C-c).
  ;; From https://www.scss.tcd.ie/~sulimanm/posts/denote-bibliography.html
  ;; written by Mohamed Suliman.
  (defun namilus-denote-org-capture-biblio ()
    "Asks for a bibtex entry, title, and keywords; then creates a Denote
    note template with the following content:

    1. Bibtex entry in an org bibtex source block.
    2. The keyword \"biblio\" and the bibtex entry's sanitised key as
       part of the Denote file's tags.

   If the bibtex entry is empty or doesn't match the regexp, adds only the
   \"biblio\" keyword and any other keywords added by the user."
    (let* ((bibtex (namilus-denote-bibtex-prompt))
           (title (denote-title-prompt (namilus-denote-bibtex-title bibtex)))
           (keywords (append (denote-keywords-prompt) (namilus-denote-biblio-keywords bibtex)))
           (front-matter (denote--format-front-matter
                         title (denote--date nil 'org) keywords
                         (format-time-string denote-id-format nil) 'org)))
      (setq denote-last-path
            (denote--path title keywords
                          (file-name-as-directory (denote-directory))
                          (format-time-string denote-id-format) 'org))
      (denote--keywords-add-to-history keywords)
      (concat front-matter (namilus-denote-bibtex-org-block bibtex))))

  ;; Functions that read input from the user, sanitise the BiBTeX, extract
  ;; the key, generate the file tags, and create the org source block.
  (defun namilus-denote-bibtex-prompt (&optional default-bibtex)
    "Ask the user for a bibtex entry. Returns the sanitised
     version. See `namilus-denote-sanitise-bibtex' for details."
    (let* ((def default-bibtex)
           (format (if (and def (not (string-empty-p def)))
                       (format "Bibtex [%s]: " def)
                     "Bibtex: "))
           (sanitised-bibtex (namilus-denote-sanitise-bibtex (read-string format nil nil def))))
      (if sanitised-bibtex
          sanitised-bibtex
        (error "Invalid BiBTeX"))))

  (defun namilus-denote-sanitise-bibtex (bibtex)
    "Returns a santised version of BIBTEX. Sanitisation entails remove
     all non alpha-numeric characters from the bibtex key, and
     returning this updated bibtex entry. If BIBTEX is not a valid
     bibtex entry, returns nil."
    (when (string-match "@.*{\\(.*\\)," bibtex)
      (let* ((key (match-string-no-properties 1 bibtex))
             (sanitised-key (replace-regexp-in-string "[^A-Za-z0-9]" "" key)))
        (replace-regexp-in-string key sanitised-key bibtex))))

  (defun namilus-denote-bibtex-key (bibtex)
    "Returns the bibtex key from BIBTEX."
    (when (string-match "@.*{\\(.*\\)," bibtex)
      (match-string-no-properties 1 bibtex)))

  (defun namilus-denote-bibtex-title (bibtex)
    "Returns the bibtex title from BIBTEX."
    (when (string-match "\\s *title\\s *=\\s *{\\(.*\\)}," bibtex)
      (match-string-no-properties 1 bibtex)))

  (defun namilus-denote-biblio-keywords (bibtex)
    "Returns a list of strings \"biblio\" and the key from the BIBTEX
     entry, otherwise, just returns a list consisting of the string
     \"biblio\"."
    (let ((bibtex-key (namilus-denote-bibtex-key bibtex)))
      (if bibtex-key
          `("biblio" ,bibtex-key)
        '("biblio"))))

  (defun namilus-denote-bibtex-org-block (bibtex)
    "Returns a string representing an org `bibtex' source block
     encompassing BIBTEX, a string of a bibtex entry."
    (concat "#+begin_src bibtex\n" bibtex "\n#+end_src"))

  ;; Org-capture template.
  (add-to-list 'org-capture-templates
               '("B" "Bibliography (with Denote) BibTeX" plain
                 (file denote-last-path)
                 #'namilus-denote-org-capture-biblio
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured nil))

  ;; Mark all biblio tagged entries in denote-directory in Dired and
  ;; extract their BiBTeX entries into a single .bib file.
  (defun namilus-denote-biblio-read-bibtex (file)
    "Reads the bibtex entry from a given Denote FILE. Does so by
     searching for a org bibtex source block and returns the contents
     therein."
    (with-temp-buffer
      (insert-file-contents file)
      (let ((contents (buffer-string)))
        (when (string-match "#\\+begin_src.*bibtex\\(\\(.*\n\\)*\\)#\\+end_src" contents)
          (match-string-no-properties 1 contents)))))

  (defun namilus-denote-generate-bibliography (denote-biblio-files bibliography-file)
    "Writes the org bibtex source blocks located in each of
     DENOTE-BIBLIO-FILES to BIBLIOGRAPHY-FILE."
    (with-temp-file bibliography-file
      (dolist (file denote-biblio-files)
        (let ((bibtex (namilus-denote-biblio-read-bibtex file)))
          (if bibtex
              (insert bibtex))))))

  ;; Interactive function: takes the marked Dired files, asks for a .bib file
  ;; in which to save the BiBTeX entries. This method can also generate .bib
  ;; files for specific bibliography items, e.g those tagged with a specific keyword.
  (defun namilus-denote-bibliography-file-prompt (&optional default-bibliography-file)
    "Ask the user for a bibliography file."
    (let* ((def default-bibliography-file)
           (format (if (and def (not (string-empty-p def)))
                       (format "Bibliography file [%s]: " def)
                     "Bibliography file: ")))
      (expand-file-name (read-file-name format nil def))))

  (defun namilus-denote-dired-generate-bibliography-from-marked ()
    (interactive)
    (namilus-denote-generate-bibliography (dired-get-marked-files nil nil nil t)
                                          (namilus-denote-bibliography-file-prompt))))

;(add-to-list 'load-path "~/gitrepos/emacs-citar-denote")
;  (require 'citar-denote)
(use-package citar-denote
  :config
  (citar-denote-mode)

 ;; Key bindings
  (let ((map global-map))
    (define-key map (kbd "C-c m c c") #'citar-create-note)
    (define-key map (kbd "C-c m c o") #'citar-denote-open-note)
    (define-key map (kbd "C-c m c d") #'citar-denote-dwim)
    (define-key map (kbd "C-c m c a") #'citar-denote-add-citekey)
    (define-key map (kbd "C-c m c k") #'citar-denote-remove-citekey)
    (define-key map (kbd "C-c m c e") #'citar-denote-open-reference-entry)
    (define-key map (kbd "C-c m c r") #'citar-denote-find-reference)
    (define-key map (kbd "C-c m c f") #'citar-denote-find-citation)
    (define-key map (kbd "C-c m c n") #'citar-denote-cite-nocite)
    (define-key map (kbd "C-c m c m") #'citar-denote-reference-nocite)))

;; ------------------------------------------------------------------------- ;
;;; Shells
;; ------------------------------------------------------------------------- ;

;; vterm
(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

;; ------------------------------------------------------------------------- ;
;;; Programming
;; ------------------------------------------------------------------------- ;

; Lisp
(use-package sly
  ; :disabled
  :mode "\\.lisp\\'")

(use-package slime
  ; :disabled
  :mode "\\.lisp\\'")

; Clojure
(use-package cider
  :mode "\\.clj[sc]?\\'")
  ; :config
  ;(evil-collection-cider-setup))

; Rust
(use-package rust-mode
  :mode "\\.rs\\'"
  :init (setq rust-format-on-save t))

(use-package cargo
  ;:straight t
  :defer t)

; HTML
(use-package web-mode
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
  :config
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2))

;; 1. Start the server with `httpd-start'
;; 2. Use `impatient-mode' on any buffer
(use-package impatient-mode)
  ;:straight t)

(use-package skewer-mode)
  ;:straight t)

; YAML
(use-package yaml-mode
  :mode "\\.ya?ml\\'")

; Compilation
(use-package compile
  ;:straight nil
  :custom
  (compilation-scroll-output t))

(defun auto-recompile-buffer ()
  (interactive)
  (if (member #'recompile after-save-hook)
      (remove-hook 'after-save-hook #'recompile t)
      (add-hook 'after-save-hook #'recompile nil t)))

;; Ediff -- keep it in one frame
(setq ediff-diff-options "-w"
      ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain)

;; LSP -- config for using language servers.
;; (use-package lsp-mode
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (markdown-mode . lsp)
;;          ;; if you want which-key integration
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp)

;; ;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)
;; ;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; ;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; ;; optionally if you want to use debugger
;; ;(use-package dap-mode)
;; ;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; ;; optional if you want which-key integration
;; (use-package which-key
;;     :config
;;     (which-key-mode))

;; ------------------------------------------------------------------------- ;
;;; Version control
;; ------------------------------------------------------------------------- ;

;; Git
(use-package magit
  :bind ("C-M-;" . magit-status) ; Or :bind (("C-x g" . magit-status)))
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package git-link
  :commands git-link
  :config
  (setq git-link-open-in-browser t))

(use-package git-gutter
  :hook ((text-mode . git-gutter-mode)
         (prog-mode . git-gutter-mode)))

;; ------------------------------------------------------------------------- ;
;;; Sagemaths
;; ------------------------------------------------------------------------- ;

;; Use sage-shell-mode
(use-package sage-shell-mode
  ;:ensure t
  ; :init
  ;; (custom-set-variables
  ;;  '(sage-shell:use-prompt-toolkit nil)
	;;  '(sage-shell:use-simple-prompt t)
	;;  '(sage-shell:set-ipython-version-on-startup nil)
	;;  '(sage-shell:check-ipython-version-on-startup nil))
  :custom
  (sage-shell:use-prompt-toolkit #'nil)
	(sage-shell:use-simple-prompt #'t)
	(sage-shell:set-ipython-version-on-startup #'nil)
	(sage-shell:check-ipython-version-on-startup #'nil)
  :config
  ;; Run SageMath by M-x run-sage instead of M-x sage-shell:run-sage
  (sage-shell:define-alias)

  ;; Turn on eldoc-mode in Sage terminal and in Sage source files
  (add-hook 'sage-shell-mode-hook #'eldoc-mode)
  (add-hook 'sage-shell:sage-mode-hook #'eldoc-mode))

(use-package ob-sagemath
  ;:ensure t
  :config
  ;; Ob-sagemath supports only evaluating with a session.
  (setq org-babel-default-header-args:sage '((:session . t)
                                             (:results . "output")))

  ;; C-c c for asynchronous evaluating (only for SageMath code blocks).
  (with-eval-after-load "org"
    (define-key org-mode-map (kbd "C-c c") 'ob-sagemath-execute-async))

  ;; Do not confirm before evaluation
  (setq org-confirm-babel-evaluate nil)

  ;; Do not evaluate code blocks when exporting.
  (setq org-export-babel-evaluate nil)

  ;; Show images when opening a file.
  (setq org-startup-with-inline-images t)

  ;; Show images after evaluating code blocks.
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images))

;; ------------------------------------------------------------------------- ;
;;; EWW setup (Emacs web browser)
;; ------------------------------------------------------------------------- ;

;; EWW -- with the navigational comfort and control you get when proficient in
;; emacs, eww is a powerful addition to a VERY powerful research and
;; programming work shop.

(with-eval-after-load 'eww

(setq-local endless/display-images t)

(defun endless/toggle-image-display ()
  "Toggle images display on current buffer."
  (interactive)
  (setq endless/display-images
        (null endless/display-images))
  (endless/backup-display-property endless/display-images))

(defun endless/backup-display-property (invert &optional object)
  "Move the 'display property at POS to 'display-backup.
Only applies if display property is an image.
If INVERT is non-nil, move from 'display-backup to 'display
instead.
Optional OBJECT specifies the string or buffer. Nil means current
buffer."
  (let* ((inhibit-read-only t)
         (from (if invert 'display-backup 'display))
         (to (if invert 'display 'display-backup))
         (pos (point-min))
         left prop)
    (while (and pos (/= pos (point-max)))
      (if (get-text-property pos from object)
          (setq left pos)
        (setq left (next-single-property-change pos from object)))
      (if (or (null left) (= left (point-max)))
          (setq pos nil)
        (setq prop (get-text-property left from object))
        (setq pos (or (next-single-property-change left from object)
                      (point-max)))
        (when (eq (car prop) 'image)
          (add-text-properties left pos (list from nil to prop) object))))))


(defun my/eww-toggle-images ()
  "Toggle whether images are loaded and reload the current page fro cache."
  (interactive)
  (setq-local shr-inhibit-images (not shr-inhibit-images))
  (eww-reload t)
  (message "Images are now %s"
           (if shr-inhibit-images "off" "on")))

(define-key eww-mode-map (kbd "I") #'my/eww-toggle-images)
(define-key eww-link-keymap (kbd "I") #'my/eww-toggle-images)

;; minimal rendering by default
(setq-default shr-inhibit-images t)   ; toggle with `I`
(setq-default shr-use-fonts nil)      ; toggle with `F`

);end with eveal after load eww

;; Put eww functions/keys in a hydra.
(use-package pretty-hydra
  ;:ensure t
  :config
  (setq eww-title '(with-favicon "globe" "Eww Browser Command"))

  ;; Generate hydra
  (pretty-hydra-define eww-browser (:title eww-title :quit-key "q" :color pink )
    ("A"
     (("G" eww "Eww Open Browser")
      ("g" eww-reload "Eww Reload")
      ("6" eww-open-in-new-buffer "Open in new buffer")
      ("l" eww-back-url "Back Url")
      ("r" eww-forward-url "Forward Url")
      ("N" eww-next-url "Next Url")
      ("P" eww-previous-url "Previous Url")
      ("u" eww-up-url "Up Url")
      ("&" eww-browse-with-external-browser "Open in External Browser")
      ("d" eww-download "Download")
      ("w" eww-copy-page-url "Copy Url Page")
      );end theme
     "B"
     (("T" endless/toggle-image-display "Toggle Image Display")
      (">" shr-next-link "Shr Next Link")
      ("<" shr-previous-link "Shr Previous Link")
      ("n" scroll-down-command "Scroll Down")
      ("C" url-cookie-list "Url Cookie List")
      ("v" eww-view-source "View Source")
      ("R" eww-readable "Make Readable")
      ("H" eww-list-histories "List History")
      ("E" eww-set-character-encoding "Character Encoding")
      ("s" eww-switch-to-buffer "Switch to Buffer")
      ("S" eww-list-buffers "List Buffers")
      );end highlighting
     "C"
     (("1" hackernews "Hackernews")
      ("2" hackernews-button-browse-internal "Hackernews browse link eww (t)")
      ("3" hackernews-new-stories "Hackernews New Stories")
      ("5" hackernews-switch-feed "Hackernews Switch Feed")
      ("6" hackernews-best-stories "Hackernews Best Stories")
      ("F" eww-toggle-fonts "Toggle Fonts")
      ("D" eww-toggle-paragraph-direction "Toggle Paragraph Direction")
      ("c" eww-toggle-colors "Toggle Colors")
      ("b" eww-add-bookmark "Add Bookmark")
      ("B" eww-list-bookmarks "List Bookmarks")
      ("=" eww-next-bookmark "Next Bookmark")
      ("-" eww-previous-bookmark "Previous Bookmark")
      ("h" hydra-helm/body "Return To Helm" :color blue )
      ("<SPC>" nil "Quit" :color pink)
      );end other
     );end hydra body
    );end pretty-hydra-eww

  (bind-key "<C-m> z" 'eww-browser/body))

;; ------------------------------------------------------------------------- ;
;;; Artificial Intelligence
;; ------------------------------------------------------------------------- ;

;; ellama package Git repo: https://github.com/s-kostyaev/ellama/tree/main

(use-package ellama
  :bind ("C-c e" . ellama-transient-main-menu)
  :init
  ;; setup key bindings
  ;; (setopt ellama-keymap-prefix "C-c e")
  ;; language you want ellama to translate to
  (setopt ellama-language "English")
  ;; could be llm-openai for example
  (require 'llm-ollama)
  (setopt ellama-provider
	    (make-llm-ollama
	     ;; this model should be pulled to use it
	     ;; value should be the same as you print in terminal during pull
	     :chat-model "llama3.1"
	     :embedding-model "nomic-embed-text"
	     :default-chat-non-standard-params '(("num_ctx" . 8192))))
  ;; (setopt ellama-summarization-provider
	;;     (make-llm-ollama
	;;      :chat-model "qwen2.5:3b"
	;;      :embedding-model "nomic-embed-text"
	;;      :default-chat-non-standard-params '(("num_ctx" . 32768))))
  ;; (setopt ellama-coding-provider
	;;     (make-llm-ollama
	;;      :chat-model "qwen2.5-coder:3b"
	;;      :embedding-model "nomic-embed-text"
	;;      :default-chat-non-standard-params '(("num_ctx" . 32768))))
  ;; Predefined llm providers for interactive switching.
  ;; You shouldn't add ollama providers here - it can be selected interactively
  ;; without it. It is just example.
  (setopt ellama-providers
	    '(("llama3.1" . (make-llm-ollama
			   :chat-model "llama3.1"
			   :embedding-model "llama3.1"))
	      ("llama3.2" . (make-llm-ollama
			    :chat-model "llama3.2"
			    :embedding-model "llama3.2"))))
  ;; Naming new sessions with llm
  (setopt ellama-naming-provider
	    (make-llm-ollama
	     :chat-model "llama3.1"
	     :embedding-model "nomic-embed-text"
	     :default-chat-non-standard-params '(("stop" . ("\n")))))
  (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  ;; Translation llm provider
  (setopt ellama-translation-provider
	  (make-llm-ollama
	   :chat-model "llama3.2"
	   :embedding-model "nomic-embed-text"
	   :default-chat-non-standard-params
	   '(("num_ctx" . 32768))))
  :config
  (setq ellama-sessions-directory "~/.config/emacs/ellama-sessions/"
        ellama-sessions-auto-save t)
  (setq ellama-long-lines-length 80))

;; ------------------------------------------------------------------------- ;
;;; Utility funtions
;; ------------------------------------------------------------------------- ;

; Google queries -- M-x google
(defun google ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))

;; Unfill paragraphs and regions
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))


;;; End init.el
;; ------------------------------------------------------------------------- ;
;; ------------------------------------------------------------------------- ;
