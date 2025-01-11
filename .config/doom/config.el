;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Font setting
(setq doom-font (font-spec :family "JetBrains Mono" :size 18)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; Theme settings
(setq doom-theme 'doom-gruvbox)

;; Escape with nn
(after! evil-escape
  (setq evil-escape-key-sequence "nn"))

;; Save with C-s
(map! "C-s" #'save-buffer)

(use-package denote
  :ensure t
  :custom
  (denote-directory "~/org")
  ;;(denote-rename-buffer-function 'dw/denote-rename-buffer-with-prefixed-title)
  :config
  ;;(denote-rename-buffer-mode)
  (require 'denote-org-dblock)

  (with-eval-after-load 'org-capture
    (add-to-list 'org-capture-templates
                 '("n" "New note (with Denote)" plain
                   (file denote-last-path)
                   #'denote-org-capture
                   :no-save t
                   :immediate-finish nil
                   :kill-buffer t
                   :jump-to-captured t))))


(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "n" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file"           "d v" #'dired-view-file)))

;;(evil-define-key 'normal dired-mode-map
  ;;(kbd "M-RET") 'dired-display-file
  ;;(kbd "h") 'dired-up-directory
  ;;(kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  ;;(kbd "m") 'dired-mark
  ;;(kbd "t") 'dired-toggle-marks
  ;;(kbd "u") 'dired-unmark
  ;;(kbd "C") 'dired-do-copy
  ;;(kbd "D") 'dired-do-delete
  ;;(kbd "J") 'dired-goto-file
  ;;(kbd "M") 'dired-do-chmod
  ;;(kbd "O") 'dired-do-chown
  ;;(kbd "P") 'dired-do-print
  ;;(kbd "R") 'dired-do-rename
  ;;(kbd "T") 'dired-do-touch
  ;;(kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  ;;(kbd "Z") 'dired-do-compress
  ;;(kbd "+") 'dired-create-directory
  ;;(kbd "-") 'dired-do-kill-lines
  ;;(kbd "% l") 'dired-downcase
  ;;(kbd "% m") 'dired-mark-files-regexp
  ;;(kbd "% u") 'dired-upcase
  ;;(kbd "* %") 'dired-mark-files-regexp
  ;;(kbd "* .") 'dired-mark-extension
  ;;(kbd "* /") 'dired-mark-directories
  ;;(kbd "; d") 'epa-dired-do-decrypt
  ;;(kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))
;;; Code:
(require 'dired)
(require 'evil-collection)

(defvar dired-filter-mark-map)
(defvar dired-filter-map)

(defconst evil-collection-dired-maps '(dired-mode-map
                                       dired-filter-mark-map
                                       dired-filter-map))

;;;###autoload
(defun evil-collection-dired-setup ()
  "Set up `evil' bindings for `dired'."
  (evil-collection-define-key 'normal 'dired-mode-map
    "q" 'quit-window
    "j" 'dired-next-line
    "k" 'dired-previous-line
    [mouse-2] 'dired-mouse-find-file-other-window
    [follow-link] 'mouse-face
    ;; Commands to mark or flag certain categories of files
    "#" 'dired-flag-auto-save-files
    "." 'dired-clean-directory
    "~" 'dired-flag-backup-files
    ;; Upper case keys (except !) for operating on the marked files
    "A" 'dired-do-find-regexp
    "C" 'dired-do-copy
    "B" 'dired-do-byte-compile
    "D" 'dired-do-delete
    "gG" 'dired-do-chgrp ;; FIXME: This can probably live on a better binding.
    "H" 'dired-do-hardlink
    "L" 'dired-do-load
    "M" 'dired-do-chmod
    "O" 'dired-do-chown
    "P" 'dired-do-print
    "Q" 'dired-do-find-regexp-and-replace
    "R" 'dired-do-rename
    "S" 'dired-do-symlink
    "T" 'dired-do-touch
    "X" 'dired-do-shell-command
    "Z" 'dired-do-compress
    "c" 'dired-do-compress-to
    "!" 'dired-do-shell-command
    "&" 'dired-do-async-shell-command
    ;; Comparison commands
    "=" 'dired-diff
    ;; Tree Dired commands
    (kbd "M-C-?") 'dired-unmark-all-files
    (kbd "M-C-d") 'dired-tree-down
    (kbd "M-C-u") 'dired-tree-up
    (kbd "M-C-n") 'dired-next-subdir
    (kbd "M-C-p") 'dired-prev-subdir
    ;; move to marked files
    (kbd "M-{") 'dired-prev-marked-file
    (kbd "M-}") 'dired-next-marked-file
    ;; Make all regexp commands share a `%' prefix:
    ;; We used to get to the submap via a symbol dired-regexp-prefix,
    ;; but that seems to serve little purpose, and copy-keymap
    ;; does a better job without it.
    "%" nil
    "%u" 'dired-upcase
    "%l" 'dired-downcase
    "%d" 'dired-flag-files-regexp
    "%g" 'dired-mark-files-containing-regexp
    "%m" 'dired-mark-files-regexp
    "%r" 'dired-do-rename-regexp
    "%C" 'dired-do-copy-regexp
    "%H" 'dired-do-hardlink-regexp
    "%R" 'dired-do-rename-regexp
    "%S" 'dired-do-symlink-regexp
    "%&" 'dired-flag-garbage-files
    ;; mark
    "*" nil
    "**" 'dired-mark-executables
    "*/" 'dired-mark-directories
    "*@" 'dired-mark-symlinks
    "*%" 'dired-mark-files-regexp
    "*c" 'dired-change-marks
    "*s" 'dired-mark-subdir-files
    "*m" 'dired-mark
    "*u" 'dired-unmark
    "*?" 'dired-unmark-all-files
    "*!" 'dired-unmark-all-marks
    "U" 'dired-unmark-all-marks
    (kbd "* <delete>") 'dired-unmark-backward
    (kbd "* C-n") 'dired-next-marked-file
    (kbd "* C-p") 'dired-prev-marked-file
    "*t" 'dired-toggle-marks
    ;; Lower keys for commands not operating on all the marked files
    "a" 'dired-find-alternate-file
    "d" 'dired-flag-file-deletion
    "gf" 'dired-find-file
    (kbd "C-m") 'dired-find-file
    "gr" 'revert-buffer
    "i" 'dired-toggle-read-only
    "I" 'dired-maybe-insert-subdir
    "J" 'dired-goto-file
    "K" 'dired-do-kill-lines
    "r" 'dired-do-redisplay
    "m" 'dired-mark
    "t" 'dired-toggle-marks
    "u" 'dired-unmark                   ; also "*u"
    "W" 'browse-url-of-dired-file
    "x" 'dired-do-flagged-delete
    "gy" 'dired-show-file-type ;; FIXME: This could probably go on a better key.
    "Y" 'dired-copy-filename-as-kill
    "+" 'dired-create-directory
    ;; open
    (kbd "RET") 'dired-find-file
    (kbd "S-<return>") 'dired-find-file-other-window
    (kbd "M-RET") 'dired-display-file
    "gO" 'dired-find-file-other-window
    "go" 'dired-view-file
    ;; sort
    "o" 'dired-sort-toggle-or-edit
    ;; moving
    "gj" 'dired-next-dirline
    "gk" 'dired-prev-dirline
    "[[" 'dired-prev-dirline
    "]]" 'dired-next-dirline
    "<" 'dired-prev-dirline
    ">" 'dired-next-dirline
    "^" 'dired-up-directory
    "-" 'dired-up-directory
    " " 'dired-next-line
    [?\S-\ ] 'dired-previous-line
    [remap next-line] 'dired-next-line
    [remap previous-line] 'dired-previous-line
    ;; hiding
    "g$" 'dired-hide-subdir ;; FIXME: This can probably live on a better binding.
    (kbd "M-$") 'dired-hide-all
    "(" 'dired-hide-details-mode
    ;; isearch
    (kbd "M-s a C-s")   'dired-do-isearch
    (kbd "M-s a M-C-s") 'dired-do-isearch-regexp
    (kbd "M-s f C-s")   'dired-isearch-filenames
    (kbd "M-s f M-C-s") 'dired-isearch-filenames-regexp
    ;; misc
    [remap read-only-mode] 'dired-toggle-read-only
    ;; `toggle-read-only' is an obsolete alias for `read-only-mode'
    [remap toggle-read-only] 'dired-toggle-read-only
    "g?" 'dired-summary
    (kbd "<delete>") 'dired-unmark-backward
    [remap undo] 'dired-undo
    [remap advertised-undo] 'dired-undo
    ;; thumbnail manipulation (image-dired)
    (kbd "C-t d") 'image-dired-display-thumbs
    (kbd "C-t t") 'image-dired-tag-files
    (kbd "C-t r") 'image-dired-delete-tag
    (kbd "C-t j") 'image-dired-jump-thumbnail-buffer
    (kbd "C-t i") 'image-dired-dired-display-image
    (kbd "C-t x") 'image-dired-dired-display-external
    (kbd "C-t a") 'image-dired-display-thumbs-append
    (kbd "C-t .") 'image-dired-display-thumb
    (kbd "C-t c") 'image-dired-dired-comment-files
    (kbd "C-t f") 'image-dired-mark-tagged-files
    (kbd "C-t C-t") 'image-dired-dired-toggle-marked-thumbs
    (kbd "C-t e") 'image-dired-dired-edit-comment-and-tags
    ;; encryption and decryption (epa-dired)
    ";d" 'epa-dired-do-decrypt
    ";v" 'epa-dired-do-verify
    ";s" 'epa-dired-do-sign
    ";e" 'epa-dired-do-encrypt)

  (when (>= emacs-major-version 30)
    (evil-collection-define-key 'normal 'dired-mode-map
      "E" 'dired-do-open))

  ;; dired-x commands
  (with-eval-after-load 'dired-x
    (evil-collection-define-key 'normal 'dired-mode-map
      "*(" 'dired-mark-sexp
      "*." 'dired-mark-extension
      "*O" 'dired-mark-omitted))

  ;; dired-narrow commands
  (with-eval-after-load 'dired-narrow
    (evil-collection-define-key 'normal 'dired-mode-map
      "s" 'dired-narrow-regexp))

  ;; dired-subtree commands
  (with-eval-after-load 'dired-subtree
    (evil-collection-define-key 'normal 'dired-mode-map
      (kbd "TAB") 'dired-subtree-toggle
      "gh" 'dired-subtree-up
      "gl" 'dired-subtree-down
      (kbd "M-j") 'dired-subtree-next-sibling
      (kbd "M-k") 'dired-subtree-previous-sibling))

  (with-eval-after-load 'dired-filter
    (evil-collection-define-key 'normal 'dired-mode-map
      "*"  dired-filter-mark-map
      "g/" dired-filter-map)))

(provide 'evil-collection-dired)
;;; evil-collection-dired.el ends here
