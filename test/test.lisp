;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(defpackage #:cl-light-client-sync.test
  (:use #:cl #:cl-light-client-sync)
  (:export #:run-tests))

(in-package #:cl-light-client-sync.test)

(defun run-tests ()
  (format t "Running professional test suite for cl-light-client-sync...~%")
  
  (let ((client (make-instance 'cl-cl-light-client-sync-client :endpoint "http://localhost")))
    (assert (stringp (send-request client "ping"))))
  (format t "Tests passed!~%")
  t)
