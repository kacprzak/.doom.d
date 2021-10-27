;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-molokai)

(global-unset-key (kbd "C-x f")) ;; fill-column
(global-unset-key (kbd "C-/")) ;; undo

(setq enable-local-variables t)

(use-package! projectile
  :init
  (setq projectile-enable-cmake-presets t)
  :bind (("<f5>" . projectile-run-project)
         ("<f6>" . projectile-compile-project)
         ("<f7>" . projectile-test-project))
  :bind-keymap
  ("s-p" . projectile-command-map))

(use-package! key-chord
  :config
  (key-chord-mode t)
  (key-chord-define-global "jj" 'avy-goto-word-1)
  (key-chord-define-global "jk" 'avy-goto-char)
  (key-chord-define-global "jl" 'avy-goto-line)
  (key-chord-define-global "jw" 'ace-window)
  (key-chord-define-global "uu" 'undo-tree-visualize))

(use-package! guru-mode
  :diminish guru-mode
  :config
  (guru-global-mode))

(use-package! clang-format
  :bind
  (:map c-mode-map
   ("C-M-\\" . clang-format-buffer)
   :map c++-mode-map
   ("C-M-\\" . clang-format-buffer)
   :map glsl-mode-map
   ("C-M-\\" . clang-format-buffer)))

(use-package! lsp-mode
  :config
  (setq lsp-symbol-highlighting-skip-current t)
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  :bind-keymap
  ("s-l" . lsp-command-map))

(setq-default flycheck-disabled-checkers '(c/c++-gcc))

(use-package! dap-mode
  :after lsp-mode
  :defines dap-lldb-debug-program
  :init
  (require 'dap-lldb)
  (require 'dap-python)
  :config
  (setq dap-lldb-debug-program '("/usr/bin/lldb-vscode-10"))
  (setq dap-auto-configure-features '(sessions locals breakpoints))
  (dap-auto-configure-mode)
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra)))
  ;; Set fringe to default (8px) size to make breakpoints visible.
  (add-hook 'dap-mode-hook
            (lambda () (fringe-mode nil)))
  :bind
  (("C-<f5>" . dap-debug-last)))

(defun my/kill-current-buffer ()
  "Kill current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'my/kill-current-buffer)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p custom-file)
    (load custom-file))
