;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; CL-LIGHT-CLIENT-SYNC - ASDF System Definition
;;;;
;;;; Light client synchronization protocol for Ethereum 2.0 style beacon chains.
;;;; Pure Common Lisp implementation with inline SHA256.

(asdf:defsystem #:cl-light-client-sync
  :name "CL-LIGHT-CLIENT-SYNC"
  :description "Light client sync protocol for Ethereum 2.0 style beacon chains"
  :version "0.1.0"
  :author "Parkian Company LLC"
  :license "Apache-2.0"
  :homepage "https://github.com/parkianco/cl-light-client-sync"
  :bug-tracker "https://github.com/parkianco/cl-light-client-sync/issues"
  :source-control (:git "https://github.com/parkianco/cl-light-client-sync.git")

  :depends-on ()  ; Pure CL - no external dependencies (inline SHA256)

  :serial t
  :components ((:file "package")))

(asdf:defsystem #:cl-light-client-sync/test
  :description "Tests for cl-light-client-sync"
  :depends-on (#:cl-light-client-sync)
  :serial t
  :components ((:module "test"
                :components ((:file "test-light-client-sync"))))
  :perform (asdf:test-op (o c)
             (let ((result (uiop:symbol-call :cl-light-client-sync.test :run-tests)))
               (unless result
                 (error "Tests failed")))))
