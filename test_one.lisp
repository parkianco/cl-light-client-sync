;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(load "cl-light-client-sync.asd")
(handler-case
  (progn
    (asdf:test-system :cl-light-client-sync/test)
    (format t "PASS~%"))
  (error (e)
    (format t "FAIL~%")))
(quit)
