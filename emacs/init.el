;; ########################################################
;; ~/.emacs.d/init.el
;; ########################################################

;; Set the startup vars
(defun set-default-vars()
  (setq my-name "Sam Pewton")
  (setq my-email "s.pewton@outlook.com"))

(defun insert-backslash()
  (insert "\\"))

;; Set the default startup options
(defun set-startup-options()
  (setq inhibit-startup-message t)
  (tool-bar-mode -1)
  (menu-bar-mode t)
  (scroll-bar-mode -1)
  (global-hl-line-mode -1)
  (global-set-key (kbd "C-z") nil)
  (global-set-key (kbd "C-c /") (lambda () (interactive) (insert-backslash)))
  (setq column-number-mode t)
  (display-line-numbers-mode 1)
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers-type 'relative))

;; Set the default `look and feel` of emacs.
(defun set-theme()
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
  (load-theme 'peacock t)
;;  (if (not (equal (shell-command-to-string "fc-list | grep -i Iosevka:style=Regular") ""))
      (add-to-list 'default-frame-alist '(font . "Iosevka-12")))
  ;;  (add-to-list 'default-frame-alist '(font . "Ubuntu-12")))

;; Add a package to the `package-archives` list.
;; # Args
;; - package-archive: (name, url)
(defun add-package-archive (package-archive)
  (add-to-list 'package-archives '('(nth 0 package-archive) . '(nth 1 package-archive)) t))

(set-default-vars)
(set-startup-options)
(set-theme)

;;;; Packages
;;; MELPA https://melpa.org/#/getting-started
(require 'package)
;;(setq list-of-package-archives '(("melpa", "https://melpa.org/packages/"), ("gnu", "http://elpa.gnu.org/packages/")))
;;(mapcar 'add-package-archive list-of-package-archives)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'ansible)
  (package-refresh-contents)
  (package-install 'ansible))

;;(unless (package-installed-p 'ansible-ls)
;;  (package-refresh-contents)
;;  (package-install 'ansible-ls))

;;; use-package
;; prompts commands to help learn
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; for a better json mode
(use-package json-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)
(add-hook 'yaml-mode-hook' '(lambda () (ansible 1)))

;; for git
(use-package magit
  :ensure t)

;; lsp - pip install python-language-server[all]
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (
	 (python-mode . lsp)
         (yaml-mode . lsp)
	 (c++-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration)
	 (ansible-mode . lsp)
	 )
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-show-diagnostics t)
  
  (add-hook 'lsp-mode-hook' 'lsp-ui-mode)

  )

;; Requires manual installation of company `M-x package-install RET company RET`
;;(use-package company-lsp
;;  :config
;;  (push 'company-lsp company-backends))

;; Requires rust-analyzer to be installed `https://robert.kra.hn/posts/rust-emacs-setup/#rust-analyzer`
(use-package rustic
  :ensure t)

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.5)
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	("C-n". company-select-next)
	("C-p". company-select-previous)
	("M-<". company-select-first)
	("M->". company-select-last))
  (:map company-mode-map
	("<tab>". tab-indent-or-complete)
	("TAB". tab-indent-or-complete)))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
	(backward-char 1)
	(if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behaviour 'return-nil))
    (yas/expand)))

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package flycheck
  :ensure)

;; local load
(add-to-list 'load-path "~/.emacs.d/lisp/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(company which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
