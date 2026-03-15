;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(asdf:defsystem #:cl-light-client-sync
  :description "Light client sync protocol for Ethereum 2.0 style beacon chains"
  :author "Park Ian Co"
  :license "Apache-2.0"
  :version "0.1.0"
  :serial t
  :components
  ((:module "src"
            :serial t
            :components
            ((:file "package")
             (:file "conditions")
             (:file "types")
             (:file "cl-light-client-sync"))))
  :in-order-to ((asdf:test-op (test-op #:cl-light-client-sync/test))))

(asdf:defsystem #:cl-light-client-sync/test
  :description "Tests for cl-light-client-sync"
  :author "Park Ian Co"
  :license "Apache-2.0"
  :depends-on (#:cl-light-client-sync)
  :serial t
  :components
  ((:module "test"
    :serial t
    :components
    ((:file "package")
     (:file "test"))))
  :perform (asdf:test-op (o c)
             (let ((result (uiop:symbol-call :cl-light-client-sync.test :run-tests)))
               (unless result
                 (error "Tests failed")))))
