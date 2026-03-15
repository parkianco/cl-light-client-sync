;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-light-client-sync)

;;; Core types for cl-light-client-sync
(deftype cl-light-client-sync-id () '(unsigned-byte 64))
(deftype cl-light-client-sync-status () '(member :ready :active :error :shutdown))
