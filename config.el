;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-horizon)
(setq doom-themes-treemacs-enable-variable-pitch nil)
(setq display-line-numbers-type 'relative)

(global-unset-key (kbd "C-x f")) ;; fill-column
(global-unset-key (kbd "C-/")) ;; undo

(blink-cursor-mode 1)
(treemacs-project-follow-mode 1)
(pixel-scroll-precision-mode 1)

(use-package! projectile
  :custom
  (projectile-enable-cmake-presets t)
  :bind (("<f6>" . projectile-compile-project)
         ("<f7>" . projectile-test-project))
  :bind-keymap
  ("s-p" . projectile-command-map))

(use-package! dirvish
  :init
  (dirvish-override-dired-mode))

(use-package! glsl-mode)
(use-package! meson-mode)

(use-package! lsp-mode
  :custom
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-position 'top)
  (lsp-enable-snippet nil)
  (lsp-symbol-highlighting-skip-current t)
  :hook
  (lsp-mode-hook . lsp-enable-which-key-integration))

(setq-default flycheck-disabled-checkers '(c/c++-gcc))
(setq-default company-global-modes '(not message-mode eshell-mode))
(setq-default which-key-idle-delay 0.2)

(use-package! dap-mode
  :after lsp-mode
  :defines dap-lldb-debug-program
  :init
  (require 'dap-lldb)
  (require 'dap-python)
  :config
  (setq dap-lldb-debug-program '("/usr/bin/lldb-dap"))
  (dap-auto-configure-mode)
  :bind
  (("<f5>" . dap-debug)
   ("C-<f5>" . dap-debug-last)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p custom-file)
    (load custom-file))
