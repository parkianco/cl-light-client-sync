;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: Apache-2.0

;;;; CL-LIGHT-CLIENT-SYNC - Standalone Package Definition
;;;;
;;;; Light client synchronization protocol for Ethereum 2.0 style beacon chains.
;;;; Provides SPV-style header sync using sync committees and aggregate BLS signatures.

(defpackage #:cl-light-client-sync
  (:nicknames #:light-client #:lc)
  (:use #:cl)
  (:export
   #:identity-list
   #:flatten
   #:map-keys
   #:now-timestamp
#:with-light-client-sync-timing
   #:light-client-sync-batch-process
   #:light-client-sync-health-check;; ========== CONSTANTS ==========
   #:+sync-committee-size+
   #:+bls-pubkey-size+
   #:+bls-signature-size+
   #:+slots-per-epoch+
   #:+epochs-per-sync-committee-period+
   #:+finality-branch-depth+
   #:+next-sync-committee-branch-depth+
   #:+current-sync-committee-index+
   #:+next-sync-committee-index+
   #:+finalized-checkpoint-index+

   ;; ========== SLOT/EPOCH TYPES ==========
   #:slot
   #:epoch
   #:sync-committee-period
   #:slot-to-epoch
   #:epoch-to-slot
   #:compute-sync-committee-period

   ;; ========== BLS TYPES ==========
   #:bls-public-key
   #:bls-public-key-p
   #:make-bls-public-key
   #:bls-public-key-bytes
   #:bls-public-key-valid-p

   #:bls-signature
   #:bls-signature-p
   #:make-bls-signature
   #:bls-signature-bytes
   #:bls-signature-valid-p

   #:aggregate-bls-public-keys

   ;; ========== HEADER TYPES ==========
   #:beacon-block-header
   #:beacon-block-header-p
   #:make-beacon-block-header
   #:header-slot
   #:header-proposer-index
   #:header-parent-root
   #:header-state-root
   #:header-body-root
   #:header-hash-tree-root

   #:light-client-header
   #:light-client-header-p
   #:make-light-client-header
   #:lc-header-beacon
   #:light-client-header-valid-p

   ;; ========== SYNC AGGREGATE ==========
   #:sync-aggregate
   #:sync-aggregate-p
   #:make-sync-aggregate
   #:sync-aggregate-bits
   #:sync-aggregate-signature
   #:sync-aggregate-participant-count

   ;; ========== SYNC COMMITTEE ==========
   #:sync-committee
   #:sync-committee-p
   #:make-sync-committee
   #:sync-committee-pubkeys
   #:sync-committee-aggregate-pubkey
   #:sync-committee-period
   #:sync-committee-root
   #:sync-committee-size
   #:sync-committee-valid-p

   #:sync-committee-branch
   #:sync-committee-branch-p
   #:make-sync-committee-branch
   #:verify-sync-committee-branch

   #:sync-committee-tracker
   #:make-sync-committee-tracker
   #:tracker-current-committee
   #:tracker-next-committee
   #:tracker-current-period
   #:tracker-update-committee
   #:tracker-get-committee-for-period

   #:compute-sync-committee-root
   #:aggregate-committee-pubkeys
   #:select-committee-participants
   #:verify-sync-committee-signature
   #:verify-committee-aggregate-signature

   ;; ========== LIGHT CLIENT UPDATE ==========
   #:light-client-update
   #:light-client-update-p
   #:make-light-client-update
   #:update-attested-header
   #:update-next-sync-committee
   #:update-next-sync-committee-branch
   #:update-finalized-header
   #:update-finality-branch
   #:update-sync-aggregate
   #:update-signature-slot
   #:update-valid-p
   #:update-is-finality-update-p
   #:update-is-sync-committee-update-p

   #:process-light-client-update
   #:validate-light-client-update
   #:apply-light-client-update

   #:update-queue
   #:make-update-queue
   #:enqueue-update
   #:dequeue-update
   #:peek-update

   #:update-tracker
   #:make-update-tracker
   #:track-update
   #:get-tracked-updates

   ;; ========== FINALITY ==========
   #:finality-checkpoint
   #:finality-checkpoint-p
   #:make-finality-checkpoint
   #:checkpoint-epoch
   #:checkpoint-root
   #:checkpoint-valid-p

   #:finality-branch
   #:finality-branch-p
   #:make-finality-branch
   #:verify-finality-branch

   #:finality-update
   #:finality-update-p
   #:make-finality-update
   #:verify-finality-update

   #:finality-proof
   #:finality-proof-p
   #:make-finality-proof
   #:verify-finality-proof

   #:finality-tracker
   #:make-finality-tracker
   #:tracker-last-finalized-slot
   #:tracker-last-finalized-root
   #:update-finality
   #:is-finalized-p
   #:get-finality-delay

   ;; ========== HEADER SYNC ==========
   #:header-chain
   #:header-chain-p
   #:make-header-chain
   #:chain-add-header
   #:chain-get-header
   #:chain-get-header-by-root
   #:chain-head
   #:chain-finalized
   #:chain-length

   #:sync-state
   #:sync-state-p
   #:make-sync-state
   #:sync-state-current-slot
   #:sync-state-target-slot
   #:sync-state-progress

   #:sync-manager
   #:make-sync-manager
   #:start-sync
   #:stop-sync
   #:sync-status
   #:request-headers
   #:process-headers

   ;; ========== LIGHT CLIENT STORE ==========
   #:light-client-store
   #:light-client-store-p
   #:make-light-client-store
   #:store-finalized-header
   #:store-optimistic-header
   #:store-current-sync-committee
   #:store-next-sync-committee
   #:get-current-sync-committee
   #:get-next-sync-committee

   ;; ========== CONFIGURATION ==========
   #:light-client-config
   #:light-client-config-p
   #:make-light-client-config
   #:config-genesis-validators-root
   #:config-min-sync-committee-participants
   #:config-slots-per-epoch
   #:config-epochs-per-sync-committee-period

   ;; ========== MERKLE VERIFICATION ==========
   #:merkle-branch
   #:merkle-branch-p
   #:make-merkle-branch
   #:verify-merkle-branch
   #:compute-merkle-root

   ;; ========== UTILITIES ==========
   #:bytes-to-hex
   #:hex-to-bytes
   #:copy-hash
   #:sha256
   #:compute-domain
   #:compute-signing-root
   #:make-fork-version

   ;; ========== CONDITIONS ==========
   #:light-client-error
   #:invalid-update-error
   #:verification-failed-error
   #:sync-error
   #:committee-not-found-error))
