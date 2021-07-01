;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-acario-dark)

;; Set fringe to default (8px) size to make breakpoints visible.
(fringe-mode nil)

(global-unset-key (kbd "C-x f")) ;; fill-column
(global-unset-key (kbd "C-/")) ;; undo

(setq enable-local-variables t)
(setq enable-local-eval t)

(use-package! projectile
  :init
  (setq projectile-enable-cmake-presets t)
  :bind (("<f5>" . projectile-run-project)
         ("<f6>" . projectile-compile-project)
         ("<f7>" . projectile-test-project)))

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

(use-package! god-mode
  :bind (("<escape>" . god-mode-all)
         ("C-x C-1" . delete-other-windows)
         ("C-x C-2" . split-window-below)
         ("C-x C-3" . split-window-right)
         ("C-x C-0" . delete-window))
  :init
  (setq god-mode-enable-function-key-translation nil)
  :config
  (add-to-list 'god-exempt-major-modes 'vterm-mode))

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
  (setq lsp-symbol-highlighting-skip-current t))

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
