;;;; CL-LIGHT-CLIENT-SYNC - ASDF System Definition
;;;;
;;;; Light client synchronization protocol for Ethereum 2.0 style beacon chains.
;;;; Pure Common Lisp implementation with inline SHA256.

(asdf:defsystem #:cl-light-client-sync
  :name "CL-LIGHT-CLIENT-SYNC"
  :description "Light client sync protocol for Ethereum 2.0 style beacon chains"
  :version "0.1.0"
  :author "CLPIC Contributors"
  :license "BSD-3-Clause"
  :homepage "https://github.com/clpic/cl-light-client-sync"
  :bug-tracker "https://github.com/clpic/cl-light-client-sync/issues"
  :source-control (:git "https://github.com/clpic/cl-light-client-sync.git")

  :depends-on ()  ; Pure CL - no external dependencies (inline SHA256)

  :serial t
  :components
  ((:file "package")
   (:module "src"
    :serial t
    :components
    ((:file "util")           ; Utilities (hex encoding, copy-hash)
     (:file "sha256")         ; Inline SHA256 implementation
     (:file "crypto")         ; BLS stubs, domain computation, signing root
     (:file "types")          ; Core type definitions (slots, epochs, headers)
     (:file "merkle")         ; Merkle branch verification
     (:file "bls")            ; BLS public key and signature types
     (:file "sync-committee") ; Sync committee structures and operations
     (:file "header-sync")    ; Header chain management
     (:file "updates")        ; Light client updates
     (:file "finality")       ; Finality tracking and verification
     (:file "store")          ; Light client store
     (:file "config")         ; Configuration
     (:file "manager")        ; Sync manager orchestration
     )))

  :in-order-to ((asdf:test-op (asdf:test-op #:cl-light-client-sync/test))))

(asdf:defsystem #:cl-light-client-sync/test
  :name "CL-LIGHT-CLIENT-SYNC Tests"
  :description "Test suite for cl-light-client-sync"
  :depends-on (#:cl-light-client-sync)
  :serial t
  :components
  ((:module "test"
    :serial t
    :components
    ((:file "package")
     (:file "test-util")
     (:file "test-sha256")
     (:file "test-merkle")
     (:file "test-sync-committee")
     (:file "test-updates")
     (:file "test-finality"))))
  :perform (asdf:test-op (o c)
             (uiop:symbol-call :cl-light-client-sync/test :run-tests)))
