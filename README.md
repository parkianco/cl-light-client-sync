# cl-light-client-sync

Light client sync protocol for Ethereum 2.0 style beacon chains with **zero external dependencies**.

## Features

- **Sync committee**: Follow sync committee signatures
- **Header verification**: Verify block headers without full state
- **Optimistic updates**: Fast updates with eventual verification
- **Finality tracking**: Track finalized checkpoints
- **Pure Common Lisp**: No CFFI, no external libraries

## Installation

```lisp
(asdf:load-system :cl-light-client-sync)
```

## Quick Start

```lisp
(use-package :cl-light-client-sync)

;; Create light client
(let ((client (make-light-client
               :genesis-validators-root *root*
               :trusted-block-root *checkpoint*)))
  ;; Process update
  (light-client-update client update)
  ;; Get finalized header
  (light-client-finalized-header client))
```

## API Reference

### Light Client

- `(make-light-client &key genesis-validators-root trusted-block-root)` - Create client
- `(light-client-update client update)` - Process sync committee update
- `(light-client-finalized-header client)` - Get finalized header
- `(light-client-optimistic-header client)` - Get optimistic header

### Verification

- `(verify-sync-committee-signature header signature committee)` - Verify signature
- `(verify-finality-proof header finality-branch)` - Verify finality

## Testing

```lisp
(asdf:test-system :cl-light-client-sync)
```

## License

BSD-3-Clause

Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
