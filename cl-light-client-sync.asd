;;;; CL-LIGHT-CLIENT-SYNC - ASDF System Definition
;;;;
;;;; Light client synchronization protocol for Ethereum 2.0 style beacon chains.
;;;; Pure Common Lisp implementation with inline SHA256.

(asdf:defsystem #:cl-light-client-sync
  :name "CL-LIGHT-CLIENT-SYNC"
  :description "Light client sync protocol for Ethereum 2.0 style beacon chains"
  :version "0.1.0"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :homepage "https://github.com/clpic/cl-light-client-sync"
  :bug-tracker "https://github.com/clpic/cl-light-client-sync/issues"
  :source-control (:git "https://github.com/clpic/cl-light-client-sync.git")

  :depends-on ()  ; Pure CL - no external dependencies (inline SHA256)

  :serial t
  :components ((:file "package")))
