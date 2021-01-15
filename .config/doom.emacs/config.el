;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Norman Salunga"
      user-mail-address "salunga.norman@gmail.com")

;; "monospace" means use the system default. However, the default is a bit larger
;; than I'd like, so I specify size 12 here.
(setq doom-font (font-spec :family "monospace" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; Set frame information
(setq frame-title-format `("Emacs ",(user-login-name) "@" ,(system-name)))

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Set projectile search directory based on system hostname
(if (string= (system-name) "Heimdall")
    (setq projectile-project-search-path '("/mnt/ssd01/WORK_ARCHIVE" "/mnt/ssd01/WORKSPACE"))
    (setq projectile-project-search-path '("~/WORKSPACE"))
  )

;; Personalize org-mode item tags and behavior
(after! org
    (setq
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("•")
        org-todo-keywords
        (quote ((sequence "TODO(t)" "ONGOING(o)" "|" "DONE(d)")
                (sequence "WAITING(W)" "PENDED(p)" "|" "CANCELLED(c)")
                (sequence "MEETING(m)" "TRANSFER(T)")))
        org-todo-state-tags-triggers
        (quote (("CANCELLED" ("CANCELLED" . t))           ;; Moving to CANCELLED adds a CANCELLED tag
                ("WAITING" ("WAITING" . t))               ;; Moving to WAITING adds a WAITING tag
                ("PENDED" ("WAITING") ("PENDED" . t))     ;; Moving to PENDED adds WAITING and PENDED tags
                (done("WAITING") ("HOLD"))                ;; Moving to DONE removes WAITING and PENDED tags
                ("TODO" ("WAITING") ("CANCELLED") ("PENDED"))    ;; Moving to TODO removes WAITING, CANCELLED, and PENDED tags
                ("ONGOING" ("WAITING") ("CANCELLED") ("PENDED")) ;; Moving to ONGOING removes WAITING, CANCELLED, and PENDED tags
                ("DONE" ("WAITING") ("CANCELLED") ("PENDED"))    ;; Moving to DONE removes WAITING, CANCELLED, and PENDED tags
                ))
    )
)

;; Select clang for flycheck syntax checker.
;; Include project root in the header file location search.
(defun setup-flycheck-clang-project-path ()
    (let ((root (ignore-errors (projectile-project-root))))
        (when root
            (add-to-list
                (make-variable-buffer-local 'flycheck-clang-include-path)
                 root))))
(add-hook 'c++-mode-hook 'setup-flycheck-clang-project-path)
(add-hook 'c-mode-hook 'setup-flycheck-clang-project-path)
;; Disable flycheck on selected modes
(setq flycheck-global-modes '(not org-mode text-mode))


(defun setup-dumb-jump-backend ()
    (setq xref-backend-functions '(t)))
(add-hook 'c++-mode-hook 'setup-dumb-jump-backend)
(add-hook 'c-mode-hook 'setup-dumb-jump-backend)

;; Disable irony since adding header file needs management of compilation database
;; which is sometimes not practical since build context maybe in a different container
(setq-default flycheck-disabled-checkers '(irony))

;; Workaround to fix indent-guide issue on X11 forwarded displays
(after! highlight-indent-guides
    (highlight-indent-guides-auto-set-faces))

;; Switch to new windows upon split
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Configure counsel-gtags
(add-hook 'c-mode-hook 'counsel-gtags-mode)
(add-hook 'c++-mode-hook 'counsel-gtags-mode)
(with-eval-after-load 'counsel-gtags
    (define-key counsel-gtags-mode-map (kbd "M-t") 'counsel-gtags-find-definition)
    (define-key counsel-gtags-mode-map (kbd "M-r") 'counsel-gtags-find-reference)
    (define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
)
(after! evil
    (define-key evil-normal-state-map (kbd "C-t") 'counsel-gtags-pop)
    (define-key evil-motion-state-map (kbd "C-]") 'counsel-gtags-dwim)
)

;; Personal key bindings
;; Window navigation made easier
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
