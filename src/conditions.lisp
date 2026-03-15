;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-light-client-sync)

(define-condition cl-light-client-sync-error (error)
  ((message :initarg :message :reader cl-light-client-sync-error-message))
  (:report (lambda (condition stream)
             (format stream "cl-light-client-sync error: ~A" (cl-light-client-sync-error-message condition)))))
