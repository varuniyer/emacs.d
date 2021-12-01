(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/")
	     '("marmalade" . "https://marmalade-repo.org/packages/"))
(package-initialize)
(global-undo-tree-mode)
(ac-config-default)
(global-auto-complete-mode)

(setq x-alt-keysym 'meta)

(setq tab-stop-list (number-sequence 4 200 4))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(use-package smooth-scrolling
  :ensure t
  :config (setq smooth-scroll-margin 2)
  :init (smooth-scrolling-mode 1))
(setq mouse-wheel-scroll-amount '(1 ((shift) .1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(sublimity-mode 1)
(setq sublimity-scroll-weight 30
      sublimity-scroll-drift-length 35)

(global-set-key [mouse-4] 'scroll-down-line)
(global-set-key [mouse-5] 'scroll-up-line)

(setq x-select-enable-clipboard t)
(defun xsel-cut-function (text &optional push)
  (with-temp-buffer
    (insert text)
    (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
(defun xsel-paste-function ()
  (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
    (unless (string= (car kill-ring) xsel-output) xsel-output)))

(setq interprogram-cut-function 'xsel-cut-function)
(setq interprogram-paste-function 'xsel-paste-function)
(setq TeX-PDF-mode t)

(load-theme 'monokai t)
(set-face-attribute 'default nil :font "Inconsolata-11")
(set-frame-font "Inconsolata-11" nil t)


;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
					;(setq require-final-newline 'query)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(require 'xt-mouse)
(xterm-mouse-mode)
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))

(setq mouse-wheel-follow-mouse 't)


(xterm-mouse-mode 1)
(tool-bar-mode -1)
(electric-pair-mode 1)
(show-paren-mode 1)
(package-install 'flycheck)

(global-flycheck-mode)
(set-face-attribute 'flycheck-error nil
		    :foreground "#FF3311"
		    :underline "#FF3311")
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(smooth-scroll sublimity exec-path-from-shell zygospore zenburn-theme ws-butler wakatime-mode volatile-highlights undo-tree smartparens nlinum monokai-theme jabber iedit helm-swoop helm-projectile gradle-mode ggtags flycheck duplicate-thing dtrt-indent company-emacs-eclim comment-dwim-2 clean-aindent-mode anzu ac-emacs-eclim)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
