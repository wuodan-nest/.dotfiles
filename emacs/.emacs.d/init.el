;; .           ..         .           .       .           .           .
;;       .         .            .          .       .
;;             .         ..xxxxxxxxxx....               .       .             .
;;     .             MWMWMWWMWMWMWMWMWMWMWMWMW                       .
;;               IIIIMWMWMWMWMWMWMWMWMWMWMWMWMWMttii:        .           .
;;  .      IIYVVXMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWxx...         .           .
;;      IWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMx..
;;    IIWMWMWMWMWMWMWMWMWBY%ZACH%AND%OWENMWMWMWMWMWMWMWMWMWMWMWMWMx..        .
;;     ""MWMWMWMWMWM"""""""".  .:..   ."""""MWMWMWMWMWMWMWMWMWMWMWMWMWti.
;;  .     ""   . `  .: . :. : .  . :.  .  . . .  """"MWMWMWMWMWMWMWMWMWMWMWMWMti=
;;         . .   :` . :   .  .'.' '....xxxxx...,'. '   ' ."""YWMWMWMWMWMWMWMWMWMW+
;;      ; . ` .  . : . .' :  . ..XXXXXXXXXXXXXXXXXXXXx.    `     . "YWMWMWMWMWMWMW
;; .    .  .  .    . .   .  ..XXXXXXXXWWWWWWWWWWWWWWWWXXXX.  .     .     """""""
;;         ' :  : . : .  ...XXXXXWWW"   W88N88@888888WWWWWXX.   .   .       . .
;;    . ' .    . :   ...XXXXXXWWW"    M88N88GGGGGG888^8M "WMBX.          .   ..  :
;;          :     ..XXXXXXXXWWW"     M88888WWRWWWMW8oo88M   WWMX.     .    :    .
;;            "XXXXXXXXXXXXWW"       WN8888WWWWW  W8@@@8M    BMBRX.         .  : :
;;   .       XXXXXXXX=MMWW":  .      W8N888WWWWWWWW88888W      XRBRXX.  .       .
;;      ....  ""XXXXXMM::::. .        W8@889WWWWWM8@8N8W      . . :RRXx.    .
;;          ``...'''  MMM::.:.  .      W888N89999888@8W      . . ::::"RXV    .  :
;;  .       ..'''''      MMMm::.  .      WW888N88888WW     .  . mmMMMMMRXx
;;       ..' .            ""MMmm .  .       WWWWWWW   . :. :,miMM"""  : ""`    .
;;    .                .       ""MMMMmm . .  .  .   ._,mMMMM"""  :  ' .  :
;;                .                  ""MMMMMMMMMMMMM""" .  : . '   .        .
;;           .              .     .    .                      .         .
;; .                                         .          .         .

;; woudan emacs config file

;; author      : wuodan aka Sudhanshu Selvan
;; version     : 2.10.01
;; date        : 22-12-24
;; os          : primarily linux. edit file config to make it work on windows or server setup
;; description : custom configuration file for the text editor emacs that is written in emacs lisp or elisp
;; usage       : place the file under ~/.emacs.d/ or ~/.config/emacs/ directory or specify unique path

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DO NOT RUN THIS WITHOUT KNOWING WHAT IT EXECUTES ; RUN AT YOUR OWN RISK!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Startup Performance
;; -*- lexical-binding: t; -*-
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))
;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s seconds with %d garbage collections."
                     (emacs-init-time "%.2f")
                     gcs-done)))

;; keep .emac.d Clean --
;; change the user-emacs-directory to keep unwanted things out of ~/.emacs.d
(setq user-emacs-directory (expand-file-name "~/.emacs.d/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))
					
;; update load path --
;; a folder of custom emacs lisp libraries which can be added to the load path
;; Add my library path to load-path
;; (push "~/.dotfiles/.emacs.d/lisp" load-path)

;; default coding system - windows --
;; avoid constant errors on windows about the coding system by setting the default to utf-8
;; (set-default-coding-systems 'utf-8)

;; server mode --
;; start the emacs server from this instance so that all emacsclient calls are routed here
;; (server-start)



;;; setting up use-package with straight.el for package management
;; Package Management setup
(unless (featurep 'straight) ;; Install straight.el package manager
  (defvar bootstrap-version) ;; Bootstrap straight.el
  (let ((bootstrap-file
         (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
        (bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage)))

(straight-use-package 'use-package) ;; Use straight.el for use-package expressions
(straight-use-package 'el-patch)    ;; install use-package with straight.el
;; use-package will use straight.el to auto install missing packages
(use-package el-patch
  :straight t)

;; use this as an alternative to use-package
(straight-use-package '(setup :type git :host nil :repo "https://git.sr.ht/~pkal/setup"))
(require 'setup)

;; extra package extensions

;; :disabled -- add the disabled property
;; used to disable a package configuration, similar to :disabled in use-package
(setup-define :disabled
  (lambda ()
    `,(setup-quit))
  :documentation "Always stop evaluating the body.")

;; :load-after -- add the load-after property
;; this keyword causes a body to be executed after other packages/features are loaded:
(setup-define :load-after
    (lambda (features &rest body)
      (let ((body `(progn
                     (require ',(setup-get 'feature))
                     ,@body)))
        (dolist (feature (if (listp features)
                             (nreverse features)
                           (list features)))
          (setq body `(with-eval-after-load ',feature ,body)))
        body))
  :documentation "Load the current feature after FEATURES."
  :indent 1)

;; :delay -- add the delay property
;; delay the loading of a package until a certail amount of idle time has passed
(setup-define :delay
   (lambda (&rest time)
     `(run-with-idle-timer ,(or time 1)
                           nil ;; Don't repeat
                           (lambda () (require ',(setup-get 'feature)))))
   :documentation "Delay loading the feature until a certain amount of idle time has passed.")

;; Use for debugging package loaded in emacs
;; create a new buffer called "require-log" and log the packages as they are loaded by emacs
(defun dw/log-require (&rest args)
  (with-current-buffer (get-buffer-create "*require-log*")
    (insert (format "%s\n"
                    (file-name-nondirectory (car args))))))
;; executes the above function when new package is loaded
(add-to-list 'after-load-functions #'dw/log-require)
:pkg

;; the :pkg keyword will depend on guix-installed emacs packages unless the parameter seems like a straight.el recipe (ALWAYS-A-LIST). checks for guix or other system.
;; Install via Guix if length == 1 or :guix t is present.
(defvar dw/guix-emacs-packages '()
  "Contains a list of all Emacs package names that must be
installed via Guix.")
;; Examples:
;; - (org-roam :straight t)
;; - (git-gutter :straight git-gutter-fringe)

;; modifies packages to use straight package manager if guix system is unavailable.
(defun dw/filter-straight-recipe (recipe)
  (let* ((plist (cdr recipe))
         (name (plist-get plist :straight)))
    (cons (if (and name (not (equal name t)))
              name
            (car recipe))
          (plist-put plist :straight nil))))

;; handle the emacs package installation after checking if the system is guix or not.
(setup-define :pkg
  (lambda (&rest recipe)
    (if (and dw/is-guix-system
             (or (eq (length recipe) 1)
                 (plist-get (cdr recipe) :guix)))
        `(add-to-list 'dw/guix-emacs-packages
                      ,(or (plist-get recipe :guix)
                           (concat "emacs-" (symbol-name (car recipe)))))
      `(straight-use-package ',(dw/filter-straight-recipe recipe))))
  :documentation "Install RECIPE via Guix or straight.el"
  :shorthand #'cadr)



;;; wuodan keyboard bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;; esc cancels all
(global-set-key (kbd "C-c C-c") 'comment-region) ;; comment region
(global-set-key (kbd "C-c c") 'uncomment-region) ;; uncomment region
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop) ;; group indent right force
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop) ;; group indent left force



;;; General settings ; Toggle variables with t and nil
(setq inhibit-startup-message t                  ; Don't show the splash screen
      visible-bell t                             ; Flash the frame to represent a bell 
      use-dialog-box nil                         ; Mouse commands use dialog boxes to ask questions
      global-auto-revert-non-file-buffers t      ; revert dired and other buffers

      default-tab-width 2
      tab-always-indent t)                       ; set default tab width -- experimental

;; Custom ui settings ; Toggle functions with 1 and -1
(tool-bar-mode -1)                    ; Display the tool bar in all graphical frames.
(scroll-bar-mode -1)                  ; Display the vertical scroll bars in all frames
(menu-bar-mode 1)                     ; Display the menu bar in each frame
(global-display-line-numbers-mode 1)  ; Display line numbers in every buffer 
(hl-line-mode 1)                      ; Highlight the current line
(blink-cursor-mode 1)                 ; Blinking cursor
(recentf-mode 1)                      ; Display the most recently edited files
(save-place-mode 1)                   ; Save place in file
(global-auto-revert-mode 1)           ; Revert any buffer associated with a file when the file changes on disk

;; enable line numbers and customize their format
(column-number-mode)
;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))
;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; dont warn for large files (videos)
(setq large-file-warning-threshold nil)

;; dont warn for following symlinked files
(setq vc-follow-symlinks t)

;; dont warn when advice is added for functions
(setq ad-redefinition-action 'accept)



;;; emacs themes !!!!! REWERITE WITH USE_PACKAGE
;; Custom values to be loaded for the selected theme 
;; These variables will act as input when loading the selected theme

; Can use borderless, accented, 3d, moody, padded as multiple aspect variable inputs
(setq modus-themes-mode-line '(moody borderless accented)) ; Control the overall style of the mode line

; Can use accented bg-only no-extend as multiple aspect variable inputs
(setq modus-themes-region '(accented bg-only no-extend))   ; Control the overall style of the active region
; Can use default, moderate, opinionated as single aspect variable inputs
; Control the style of the completion framework ui
(setq modus-themes-completions
      '((matches . (extrabold underline))
        (selection . (semibold italic))))                  
(setq modus-themes-bold-constructs t)                      ; Use bold text in more code constructs
(setq modus-themes-italic-constructs t)                    ; Use italic font forms in more code constructs
; Can use bold, underline, intense as multiple aspect variable inputs
(setq modus-themes-paren-match '(bold intense))            ; Control the style of matching parenthesis
; Can use faint, alt-syntax, green-strings, yellow-comments as multiple aspect variable inputs
(setq modus-themes-syntax '(faint alt-syntax green-strings yellow-comments)) ; Control style of code syntax highlighting
; Can use nil, subtle, intense as single aspect variable input
(setq modus-themes-fringes 'subtle)                        ; Define the visibility of fringes
(setq modus-themes-tabs-accented t)                        ; Toggle accented tab backgrounds
; can use background, intense, gray, bold, italic, nil as multiple aspect variable inputs
(setq modus-themes-prompts '(bold intense background))                ; style minibuffer and REPL prompts
(load-theme 'modus-vivendi t)         ; Load the modus vivendi dark theme

;; Save what you enter into minibuffer prompts
(setq history-length 25)              ; Maximum length of history list before truncation takes place
(savehist-mode 1)                     ; Save the minibuffer history

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)



;;; package-archives
;; setup melpa package-archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)



;;; lsp-mode
;; setup lsp-mode and lsp-deferred 
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :ensure t
  :defer t
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq
   lsp-auto-guess-root t
   lsp-log-io nil
   lsp-restart 'auto-restart	
   lsp-enable-symbol-highlighting nil	
   lsp-enable-on-type-formatting nil	
   lsp-signature-auto-activate nil	
   lsp-signature-render-documentation t
   lsp-eldoc-hook nil
   lsp-eldoc-render-all t
   lsp-inlay-hint-enable t
   lsp-modeline-code-actions-enable nil	
   lsp-modeline-diagnostics-enable nil	
   lsp-headerline-breadcrumb-enable nil	
   lsp-semantic-tokens-enable nil	
   lsp-enable-folding nil	
   lsp-enable-imenu nil	
   lsp-enable-snippet nil	
   read-process-output-max (* 1024 1024) ;; 1MB
   lsp-idle-delay 0.5)
  ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
  :hook
  ((python-mode ;;pyright
    sh-mode ;;bash-language-server
    css-mode ;;css-ls - vscode-langservers-extracted
    scss-mode ;;css-ls - vscode-langservers-extracted
    html-mode ;;html-ls - vscode-langservers-extracted
    js-mode ;;ts-ls - typescript-language-server
    js2-mode ;;ts-ls - modern es6+ support
    js-jsx-mode ;;ts-ls - typescript-language-server
    typescript-mode ;;ts-ls - typescript-language-server
    web-mode ;; ts-ls/html-ls/css-ls
    csharp-mode ;;    
    haskell-mode ;; haskell-language-server
    rust-mode ;; rust-analyzer
    ) . lsp-deferred)
  (lsp-mode . lsp-enable-which-key-integration) ;;which-key with lsp
  (lsp-mode . lsp-lens-enable) ;;lsp lens have to check
  (lsp-mode . lsp-ui-mode) ;; enable lsp-ui
  (lsp-mode . #'lsp-mode-rust-setup) ;; enable lsp-rust-setup function -- below rustic and rust-mode settings
  :bind (:map lsp-mode-map
              ("C-c a" . lsp-execute-code-action)
              ("C-c r" . lsp-rename)
              ("C-c q" . lsp-workspace-restart)
              ("C-c Q" . lsp-workspace-shutdown)))

;; setup lsp-ui for lsp-mode
(use-package lsp-ui
  :ensure t
  :after
  (lsp-mode)
  :hook
  (lsp . lsp-ui-mode)
  :config
  (setq
   ;; doc settings
   lsp-ui-doc-enable t
   lsp-ui-doc-position 'bottom
   lsp-ui-doc-side 'right
   lsp-ui-doc-delay 1
   lsp-ui-doc-show-with-cursor t
   lsp-ui-doc-show-with-mouse t
   ;; sideline settings
   lsp-ui-sideline-show-diagnostics t
   lsp-ui-sideline-show-hover t
   lsp-ui-sideline-show-code-actions t
   lsp-ui-sideline-update-mode 'line
   lsp-ui-sideline-delay 1
   ;; peek settings !! need to be tweaked more with define keys
   lsp-ui-peek-enable t
   lsp-ui-peek-always-show t
   lsp-ui-peek-show-directory t) ;; add lsp ui imenu settings later when we get time
  :bind
  (:map lsp-ui-mode-map
        ("C-c i" . lsp-ui-imenu)
	("C-c d" . lsp-ui-doc-glance)))

;;; Other lsp extensions

;; makes sure the exec-path-from-shell is installed when in macos
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :ensure t
    :init (exec-path-from-shell-initialize)))

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
(use-package general  ;; keybinding wrapper
  :ensure t)

(use-package dap-mode
  :ensure t
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  :custom
  (lsp-enable-dap-auto-configure nil)
  :commands dap-debug
  :config
  (dap-ui-mode 1)
  (dap-ui-controls-mode 1)
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed
  ;; Bind `C-c l d` to `dap-hydra` for easy access
  (general-define-key
    :keymaps 'lsp-mode-map
    :prefix lsp-keymap-prefix
    "d" '(dap-hydra t :wk "debugger")))

;; company auto complete
(use-package company
  :ensure t
  :defer t
  :after
  lsp-mode
  :hook
  (lsp-mode . company-mode)
  (prog-mode . company-mode)
  (text-mode . company-mode)
  :config
  (setq
   global-company-mode t
   indent-tab-mode nil
   company-tooltip-align-annotations t
   company-minimum-prefix-length 2
   company-idle-delay 0.5
   company-begin-commands t)
  :bind
  (:map company-active-map
	("<tab>" . tab-indent-or-complete)
	("TAB" . tab-indent-or-complete)
	("C-n". company-select-next)
	("C-p". company-select-previous)
	("M-<". company-select-first)
	("M->". company-select-last))
  (:map lsp-mode-map
	("<tab>" . tab-indent-or-complete)
	("TAB" . tab-indent-or-complete)))

(use-package company-box
  :ensure t
  :after company
  :hook
  (company-mode . company-box-mode))

;; yasnippet -- have to create our code snippets for diff modes -- <code-snippet><TAB>
(use-package yasnippet
  :ensure t
  :after lsp
  :config
  (yas-reload-all)
  :hook
  (prog-mode . yas-minor-mode)
  (text-mode . yas-minor-mode))

(defun company-yasnippet-or-completion () ;; function to check for snippet or fall back to complete
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()      ;; checks if the current position is suitable for snippet expansion
  (save-excursion              ;; creates a temp buffer to perform checks without modifying current
    (if (looking-at "\\_>") t  ;; checks if the current point is at the end of certain characters
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()                       ;; function attemps to expand a yasnippet
  (let ((yas/fallback-behavior 'return-nil))  ;; fallback to nil if it finds nothing
    (yas/expand)))

(defun tab-indent-or-complete () ;; combined behaviour for <TAB> key: snippet || complete || indent in order
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

;; flycheck linting config
(use-package flycheck
  :ensure t
  :init
  (setq
   global-flycheck-mode t
   flycheck-emacs-lisp-load-path 'inherit)
  :hook
  (lsp-mode . flycheck-mode)
  (prog-mode . flycheck-mode)
  :bind (:map flycheck-mode-map
              ("C-c l" . flycheck-list-errors)))

;; if you are helm user
;; (use-package helm-lsp
;;   :after lsp
;;   :commands helm-lsp-workspace-symbol)

;; if you are ivy user
(use-package lsp-ivy
  :after lsp
  :commands lsp-ivy-workspace-symbol
  )

;; treemacs settings for generic tabs and tree display - look at configuration file in repo for more package integration. 
;; (use-package lsp-treemacs
;;   :after lsp
;;   :defer t
;;   :init
;;   (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
;; 	treemacs-deferred-git-apply-delay        0.5
;; 	treemacs-directory-name-transformer      #'identity
;; 	treemacs-display-in-side-window          f
;; 	treemacs-eldoc-display                   'simple
;; 	treemacs-file-event-delay                2000
;; 	treemacs-file-extension-regex            treemacs-last-period-regex-value
;; 	treemacs-file-follow-delay               0.2
;; 	treemacs-file-name-transformer           #'identity
;; 	treemacs-follow-after-init               t
;; 	treemacs-expand-after-init               t
;; 	treemacs-find-workspace-method           'find-for-file-or-pick-first
;; 	treemacs-git-command-pipe                ""
;; 	treemacs-goto-tag-strategy               'refetch-index
;; 	treemacs-header-scroll-indicators        '(nil . "^^^^^^")
;; 	treemacs-hide-dot-git-directory          t
;; 	treemacs-indentation                     2
;; 	treemacs-indentation-string              " "
;; 	treemacs-is-never-other-window           nil
;; 	treemacs-max-git-entries                 5000
;; 	treemacs-missing-project-action          'ask
;; 	treemacs-move-files-by-mouse-dragging    t
;; 	treemacs-move-forward-on-expand          nil
;; 	treemacs-no-png-images                   nil
;; 	treemacs-no-delete-other-windows         t
;; 	treemacs-project-follow-cleanup          nil
;; 	treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
;; 	treemacs-position                        'left
;; 	treemacs-read-string-input               'from-child-frame
;; 	treemacs-recenter-distance               0.1
;; 	treemacs-recenter-after-file-follow      nil
;; 	treemacs-recenter-after-tag-follow       nil
;; 	treemacs-recenter-after-project-jump     'always
;; 	treemacs-recenter-after-project-expand   'on-distance
;; 	treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
;; 	treemacs-project-follow-into-home        nil
;; 	treemacs-show-cursor                     nil
;; 	treemacs-show-hidden-files               t
;; 	treemacs-silent-filewatch                nil
;; 	treemacs-silent-refresh                  nil
;; 	treemacs-sorting                         'alphabetic-asc
;; 	treemacs-select-when-already-in-treemacs 'move-back
;; 	treemacs-space-between-root-nodes        t
;; 	treemacs-tag-follow-cleanup              t
;; 	treemacs-tag-follow-delay                1.5
;; 	treemacs-text-scale                      nil
;; 	treemacs-user-mode-line-format           nil
;; 	treemacs-user-header-line-format         nil
;; 	treemacs-wide-toggle-width               70
;; 	treemacs-width                           35
;; 	treemacs-width-increment                 1
;; 	treemacs-width-is-initially-locked       t
;; 	treemacs-workspace-switch-cleanup        nil)
  
;;   (treemacs-follow-mode t)
;;   (treemacs-filewatch-mode t)
;;   (treemacs-fringe-indicator-mode 'always)
;;   (treemacs-hide-gitignored-files-mode nil)
;;   :bind
;;   (:map global-map
;;         ("M-0"       . treemacs-select-window)
;;         ("C-x t 1"   . treemacs-delete-other-windows)
;;         ("C-x t t"   . treemacs)
;;         ("C-x t d"   . treemacs-select-directory)
;;         ("C-x t B"   . treemacs-bookmark)
;;         ("C-x t C-t" . treemacs-find-file)
;;         ("C-x t M-t" . treemacs-find-tag))
;;   :commands lsp-treemacs-errors-list)



;;; setting up special language configuration for lsp-mode client
;; eslint for project-specific eslint binary - ensuring compatibility with all projects
;; local binary location is usually 'node_modules/.bin/eslint'
;; (use-package flymake-eslint
;;   :ensure t
;;   :config
;;   ;; If Emacs is compiled with JSON support
;;   (setq flymake-eslint-prefer-json-diagnostics t)
    
;;   (defun lemacs/use-local-eslint ()
;;     "Set project's `node_modules' binary eslint as first priority.
;; If nothing is found, keep the default value flymake-eslint set or
;; your override of `flymake-eslint-executable-name.'"
;;     (interactive)
;;     (let* ((root (locate-dominating-file (buffer-file-name) "node_modules"))
;;            (eslint (and root
;;                         (expand-file-name "node_modules/.bin/eslint"
;;                                           root))))
;;       (when (and eslint (file-executable-p eslint))
;;         (setq-local flymake-eslint-executable-name eslint)
;;         (message (format "Found local ESLINT! Setting: %s" eslint))
;;         (flymake-eslint-enable))))


;;   (defun lemacs/configure-eslint-with-flymake ()
;;     "Enable flymake-eslint for relevant web-dev modes."
;;     (when (memq major-mode
;;                 '(javascript-mode web-mode js-mode js2-mode jsx-mode
;;                   typescript-mode typescriptreact-mode tsx-ts-mode))
;;       (lemacs/use-local-eslint)))
;;   :hook
;;   (lsp-mode . #'lemacs/configure-eslint-with-flymake)
;;   ;; With older projects without LSP or if eglot fails
;;   ;; you can call interactivelly M-x lemacs/use-local-eslint RET
;;   ;; or add a hook like:
;;   (js-ts-mode . #'lemacs/configure-eslint-with-flymake))

;; haskell
(use-package lsp-haskell
  :ensure t
  :after lsp
  :hook
  ((haskell-mode-hook
    haskell-literate-mode-hook
    ) . lsp-deferred))

;; c-sharp
(use-package csharp-mode
  :ensure t
  :after lsp
  :init
  (add-hook 'csharp-mode-hook #'company-mode)
  (add-hook 'csharp-mode-hook #'rainbow-delimiters-mode))

;; rust config -- checkout rust-mode doc for more shortcuts and hacks
(use-package rust-mode ;; rust major mode -- basic mode
  :ensure t
  :after lsp
  :init
  (setq
   indent-tabs-mode nil    ;; electric-indent-mode to be disabled - default is t
   rust-format-on-save t   ;; install rustfmt with cargo
   prettify-symbol-mode t  ;; can config own prettification
   )
  :hook
  (rust-mode . lsp-deferred))

(use-package rustic ;; rust-mode extension built on rust mode itself
  :ensure t
  :after lsp
  :init
  (setq
   indent-tabs-mode nil
   rustic-format-on-save t
   prettify-symbol-mode t)
  :hook
  (rustic-mode . lsp=deferred)
  :bind (:map rustic-mode-map
              ("C-c s" . lsp-rust-analyzer-status)))

(defun lsp-mode-rust-setup ()  ;; rust analyzer setup for lsp-mode
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil))

;; dap-mode for rust -- independent of the original setup
(setq dap-cpptools-extension-version "1.5.1")
(with-eval-after-load 'lsp-rust
  (require 'dap-cpptools))
(with-eval-after-load 'dap-cpptools
  ;; Add a template specific for debugging Rust programs.
  ;; It is used for new projects, where I can M-x dap-edit-debug-template
  (dap-register-debug-template "Rust::CppTools Run Configuration"
                               (list :type "cppdbg"
                                     :request "launch"
                                     :name "Rust::Run"
                                     :MIMode "gdb"
                                     :miDebuggerPath "rust-gdb"
                                     :environment []
                                     :program "${workspaceFolder}/target/debug/hello / replace with binary"
                                     :cwd "${workspaceFolder}"
                                     :console "external"
                                     :dap-compilation "cargo build"
                                     :dap-compilation-dir "${workspaceFolder}")))
(with-eval-after-load 'dap-mode
  (setq dap-default-terminal-kind "integrated") ;; Make sure that terminal programs open a term for I/O in an Emacs buffer
  (dap-auto-configure-mode +1))

(use-package cargo
  :ensure t
  :diminish cargo-minor-mode
  :hook (rust-mode . cargo-minor-mode))

(use-package rust-playground
  :ensure t)

;;; have to check if this package works or if it is conflicting with lsp-mode. have to see if we have to make flycheck-rust-setup funciton as well -------!!!!!
;; (use-package flycheck-rust
;;   :ensure t
;;   :after flycheck
;;   :hook
;;   (flycheck-rust-mode . #'flycheck-rust-setup))

;; toml setup -- can edit more
(use-package toml-mode
  :ensure t
  :after lsp)
  


;;; other packages for quality of life
;; font settings
(let ((mono-spaced-font "Monospace")
      (proportionately-spaced-font "Sans"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 100)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.0))

;; optional if you want which-key integration
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; enable icons
;; Remember to do M-x and run `nerd-icons-install-fonts' to get the
;; font files.  Then restart Emacs to see the effect.
(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; Configure the minibuffer and completions
(use-package vertico ;; minibuffer completion - helm, ivy alternative
  :ensure t
  :hook (after-init . vertico-mode)
  :config
  (setq vertico-cycle t
	vertico-resize nil
	vertico-mode t))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode)
  :config
  (marginalia-mode t))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package savehist ;; minibuffer histories
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode)
  :config
  (savehist-mode t))

(use-package recentf ;; track recent files
  :ensure nil ; it is built-in
  :hook (after-init . recentf-mode)
  :config
  (recentf-mode t))

(use-package corfu ;; minibuffer completion - company alternative
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5)
	corfu-popupinfo-mode t) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (setq corfu-history-mode t)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %H:%M:%S"))

(use-package consult ;; enhanced search and navigation commands
  :ensure t
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

(use-package embark ;; enhanced action manager
  :ensure t
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

(use-package embark-consult ;; embark with consult
  :ensure t)

(use-package wgrep ;; sed alternative
  :ensure t
  :bind ( :map grep-mode-map
          ("e" . wgrep-change-to-wgrep-mode)
          ("C-x C-q" . wgrep-change-to-wgrep-mode)
          ("C-c C-c" . wgrep-finish-edit)))

(use-package page-break-lines
  :ensure t
  :config
  (setq
   global-page-break-lines-mode t
   ))



;;; The file manager (Dired)

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))



;;; org mode ;; can add org-roam for enabling database for unordered note taking ;; cant try denote new one
(use-package org
  :ensure t
  )
