;;; packages --- .package-basic.el

;; Copyright (C) 2020 Ricardo Malnati Rosa Lima
;;
;; Author: Ricardo Malnati <ricardomalnati@gmail.com>
;; Homepage: https://github.com/Malnati/.package-basic.el.git
;; Version: 1.0.0
;; Package-Version:
;; Package-Commit: 
;; Package-Requires: ((emacs "24.4") (package))
;; Keywords: package
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;
;;; Commentary:
;;
;; Setup directories of repositories by system-type, for adding use-package.
;;
;; Install:
;;
;; Copy to `.pbl.el' your .emacs.d/ and add
;; `(load-file "~/.emacs.d/.package-basic.el")' to your `~/.emacs' file
;;
;; There are just the functions below, you can use:
;;
;; 1) M-x `package-basic-setup'
;;        "Setup of the package Melpa stable and unstable repositories."
;; 2) M-x `package-basic-setup-dirs'
;;        "Setup location of the package archive by system-type."
;; e) M-x `package-basic-setup-all'
;;        "Setup directories, Melpa repositories for adding use-package."
;;
;;; Code:

(eval-when-compile
(require 'f))

(defgroup package-basic nil
  "Setup directories of repositories by system-type, for adding use-package."
  :group 'package-basic
  :link '(url-link :tag "Homepage" "https://github.com/Malnati/.package-basic.el.git"))

(defcustom package-basic-mswin-sufix "mswin"
  "Defines elpa's mswin sufix path.
It is for using at Microsoft Windows `system-type'."
  :group 'package-basic
  :type 'string)

(defcustom package-basic-mswin-dir (f-join user-emacs-directory package-basic-mswin-sufix)
  "Defines elpa's directory path.
It is for using at Microsoft Windows `system-type'."
  :group 'package-basic
  :type 'string)

(defcustom package-basic-linux-sufix "linux"
  "Defines elpa's linux sufix path.
It is for using at Linux `system-type'."
  :group 'package-basic
  :type 'string)

(defcustom package-basic-linux-dir (f-join user-emacs-directory package-basic-linux-sufix)
  "Defines elpa's directory path.
It is for using at Linux `system-type'."
  :group 'package-basic
  :type 'string)

(defcustom package-basic-macos-sufix "macos"
  "Defines elpa's macos sufix path.
It is for using at Microsoft Windows `system-type'."
  :group 'package-basic
  :type 'string)

(defcustom package-basic-macos-dir (f-join user-emacs-directory package-basic-macos-sufix)
  "Defines elpa's directory path.
It is for using at MacOSX `system-type'."
  :group 'package-basic
  :type 'string)

(defun package-basic-setup-melpa-f
    (interactive)    
  "Setup of the package Melpa stable and unstable repositories."
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("unstable" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("stable" . "https://stable.melpa.org/packages/") t)
  (package-refresh-contents))

(defun package-basic-setup-dirs-f
    (interactive)    
  "Setup location of the package archive."
  (when (member window-system '(pc w32 ms-dos windows-nt cygwin))
    (setq package-user-dir package-basic-macos-dir))
  (when (member system-type '(ns darwin))
    (setq package-user-dir package-basic-macos-dir))
  (when (member system-type '(gnu/linux gnu x))
    (setq package-user-dir package-basic-macos-dir)))

(defun package-basic-setup-f
    (interactive)
  "Setup directories, Melpa repositories for adding use-package."
  (condition-case nil
      (require 'use-package)
    (file-error
     (require 'package)
     (package-basic-setup-dir-f)
     (package-basic-setup-melpa-f)
     (package-install 'use-package)
     (require 'use-package))))

(provide '.package-basic)

;;; .package-basic.el ends here
