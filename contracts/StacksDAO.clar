
;; StacksDAO
(define-constant contract-owner tx-sender)

;; Error codes
(define-constant error-unauthorized (err u100))
(define-constant error-proposal-exists (err u101))
(define-constant error-proposal-not-found (err u102))
(define-constant error-proposal-expired (err u103))
(define-constant error-proposal-not-expired (err u104))
(define-constant error-already-voted (err u105))
(define-constant error-insufficient-tokens (err u106))
(define-constant error-not-proposal-creator (err u107))
(define-constant error-proposal-executed (err u108))
(define-constant error-invalid-proposal-duration (err u109))
(define-constant error-invalid-quorum (err u110))
(define-constant error-not-contract-owner (err u111))
(define-constant error-proposal-not-active (err u112))
(define-constant error-proposal-not-passed (err u113))
(define-constant error-invalid-vote-type (err u114))

;; Vote types
(define-constant vote-type-for u1)
(define-constant vote-type-against u2)
(define-constant vote-type-abstain u3)

;; Proposal status
(define-constant status-active u1)
(define-constant status-passed u2)
(define-constant status-rejected u3)
(define-constant status-executed u4)

;; Data structures
(define-map proposals
  { proposal-id: uint }
  {
    creator: principal,
    title: (string-ascii 64),
    description: (string-ascii 512),
    link: (string-ascii 256),
    start-block: uint,
    end-block: uint,
    quorum-threshold: uint,
    vote-for: uint,
    vote-against: uint,
    vote-abstain: uint,
    status: uint,
    executed-at: (optional uint)
  }
)

(define-map votes
  { proposal-id: uint, voter: principal }
  { 
    weight: uint, 
    vote-type: uint,
    time: uint
  }
)

;; Governance token (simulated)
(define-map token-balances principal uint)

;; Total token supply
(define-data-var total-token-supply uint u10000000)

;; Governance parameters
(define-data-var min-proposal-duration uint u144)  ;; Minimum 144 blocks (roughly 1 day)
(define-data-var default-quorum-threshold uint u2000)  ;; 20% of total tokens
(define-data-var proposal-fee uint u100)  ;; Fee to create proposal
(define-data-var next-proposal-id uint u1)

;; Read-only functions

;; Get proposal details
(define-read-only (get-proposal (proposal-id uint))
  (map-get? proposals { proposal-id: proposal-id })
)

;; Get vote details
(define-read-only (get-vote (proposal-id uint) (voter principal))
  (map-get? votes { proposal-id: proposal-id, voter: voter })
)

;; Check if a proposal exists
(define-read-only (proposal-exists (proposal-id uint))
  (is-some (get-proposal proposal-id))
)

;; Check if a proposal is active
(define-read-only (is-proposal-active (proposal-id uint))
  (match (get-proposal proposal-id)
    proposal (and 
              (is-eq (get status proposal) status-active)
              (< stacks-block-height (get end-block proposal))
            )
    false
  )
)
