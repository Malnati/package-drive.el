;;; packages --- .package-drive.el
;;
;; Copyright (C) 2020 Ricardo Malnati Rosa Lima
;;
;; Author: Ricardo Malnati <ricardomalnati@gmail.com>
;; Homepage: https://github.com/Malnati/.package-drive.el.git
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
;; Copy to `.package-drive.el' your .emacs.d/ and add
;; `(load-file "~/.emacs.d/.package-drive.el")' to your `~/.emacs' file
;;
;; There are just the functions below, you can use:
;;
;; 1) M-x `pd/setup-melpa-f'
;;        "Setup of the package Melpa stable and unstable repositories."
;; 2) M-x `pd/setup-dirs-f'
;;        "Setup location of the package archive by system-type."
;; 3) M-x `pd/setup-use-package-f'
;;        "Setup use-package."
;; 4) M-x `pd/setup-full-f'
;;        "Setup directories, Melpa repositories for adding use-package."
;;
;;; Code:

(require 'package)
(package-initialize)

(defun pd/setup-melpa-f
  (interactive)    
  "Setup of the package Melpa stable and unstable repositories."
  (add-to-list 'package-archives '("unstable" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("stable" . "https://stable.melpa.org/packages/") t)
  (package-refresh-contents))

(eval-when-compile
  (condition-case nil
    (require 'f)
  (file-error
   '(pd/setup-melpa-f)
   (package-install 'f)
   (require 'f))))

(condition-case nil
  (require 'use-package)
  (file-error
   '(pd/setup-melpa-f)
   (package-install 'use-package)
   (require 'use-package)))

(defgroup package-drive nil
  "Setup directories of repositories by system-type, for adding use-package."
  :group 'package-drive
  :link '(url-link :tag "Homepage" "https://github.com/Malnati/.package-drive.el.git"))

(defcustom pd/mswin-sufix "mswin"
  "Defines elpa's mswin sufix path.
It is for using at Microsoft Windows `system-type'."
  :group 'package-drive
  :type 'string)

(defcustom pd/mswin-dir (f-join user-emacs-directory pd/mswin-sufix)
  "Defines elpa's directory path.
It is for using at Microsoft Windows `system-type'."
  :group 'package-drive
  :type 'string)

(defcustom pd/linux-sufix "linux"
  "Defines elpa's linux sufix path.
It is for using at Linux `system-type'."
  :group 'package-drive
  :type 'string)

(defcustom pd/linux-dir (f-join user-emacs-directory pd/linux-sufix)
  "Defines elpa's directory path.
It is for using at Linux `system-type'."
  :group 'package-drive
  :type 'string)

(defcustom pd/macos-sufix "macos"
  "Defines elpa's macos sufix path.
It is for using at Microsoft Windows `system-type'."
  :group 'package-drive
  :type 'string)

(defcustom pd/macos-dir (f-join user-emacs-directory pd/macos-sufix)
  "Defines elpa's directory path.
It is for using at MacOSX `system-type'."
  :group 'package-drive
  :type 'string)

(defun pd/setup-dirs-f
    (interactive)    
  "Setup location of the package archive."
  (when
      (member system-type '(pc w32 ms-dos windows-nt cygwin))
    (setq package-user-dir pd/mswin-dir))
  (when
      (member system-type '(ns darwin))
    (setq package-user-dir pd/macos-dir))
  (when
      (member system-type '(gnu/linux gnu x))
    (setq package-user-dir pd/linux-dir)))

(defun pd/setup-use-package-f
    (interactive)
  "Setup use-package."
  (condition-case nil
      (require 'use-package)
    (file-error
     (require 'package)
     (pd/setup-melpa-f)
     (package-install 'use-package)
     (require 'use-package))))

(defun pd/setup-full-f
    (interactive)
  "Setup directories, Melpa repositories for adding use-package."
     (pd/setup-dirs-f)
     (pd/setup-melpa-f)
     (dp/setup-use-package-f))

(provide 'package-drive)

;;; .package-drive.el ends here
