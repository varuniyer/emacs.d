(require 'package)
(add-to-list 'package-archives
	         '("melpa" . "http://melpa.org/packages/")
	         '("marmalade" . "https://marmalade-repo.org/packages/"))
(package-initialize)

(global-undo-tree-mode)

(setq x-alt-keysym 'meta)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
(defun reload-pdf ()
  (interactive
  (let* ((fname buffer-file-name)
        (fname-no-ext (substring fname 0 -4))
        (pdf-file (concat fname-no-ext ".pdf"))
        (cmd (format "pdflatex %s" fname)))
    (delete-other-windows)
    (split-window-horizontally)
    (split-window-vertically)
    (shell-command cmd)
    (other-window 2)
    (find-file pdf-file)
    (balance-windows))))

(use-package pdf-tools
  :config
 ;; initialise
 (pdf-tools-install)
 ;; open pdfs scaled to fit page
 (setq-default pdf-view-display-size 'fit-page)
 ;; automatically annotate highlights
 (setq pdf-annot-activate-created-annotations t)
 ;; use normal isearch
 (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))


(global-set-key "\C-x\p" 'reload-pdf)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq tab-stop-list (number-sequence 4 200 4))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

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
(setq pdf-view-resize-factor 1.1)

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
   '(auctex smooth-scroll sublimity exec-path-from-shell zygospore zenburn-theme ws-butler wakatime-mode volatile-highlights undo-tree smartparens nlinum monokai-theme jabber iedit helm-swoop helm-projectile gradle-mode ggtags flycheck duplicate-thing dtrt-indent company-emacs-eclim comment-dwim-2 clean-aindent-mode anzu ac-emacs-eclim))
 '(pdf-view-midnight-colors '("white" . "black")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
