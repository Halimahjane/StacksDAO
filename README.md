
# StacksDAO - Clarity Governance DAO Contract

This is a decentralized governance smart contract written in [Clarity](https://docs.stacks.co/docs/clarity-language/overview), designed for a token-weighted voting system on the Stacks blockchain. It allows users to propose and vote on governance decisions using a governance token.

## 📋 Features

* Proposal creation with quorum and duration settings
* Voting with `for`, `against`, and `abstain` options
* Automatic status calculation after voting period ends
* Proposal execution logic (simulated)
* Configurable governance parameters by contract owner
* Token minting (for testing/demo purposes)

---

## 🧱 Data Structures

### Proposals

Each proposal includes:

* Creator, title, description, and link
* Start and end block for voting period
* Quorum threshold (minimum votes required)
* Vote tallies: for, against, abstain
* Status: active, passed, rejected, or executed

### Votes

Tracks individual votes per user per proposal:

* Vote type
* Weight (based on token balance)
* Timestamp (block height)

### Token Balances

Simple token balance mapping used for vote weight.

---

## ⚙️ Public Functions

### ✅ Proposal Actions

#### `create-proposal(...)`

Creates a new governance proposal. Requires a fee and valid duration/quorum.

#### `execute-proposal(proposal-id)`

Marks a passed proposal as executed. Cannot be re-executed.

---

### 📊 Read-only Functions

#### `get-proposal(proposal-id)`

Returns proposal details.

#### `get-vote(proposal-id, voter)`

Returns a voter's vote on a proposal.

#### `proposal-exists(proposal-id)`

Checks if a proposal exists.

#### `is-proposal-active(proposal-id)`

Checks if a proposal is currently active.

#### `has-proposal-ended(proposal-id)`

Checks if the voting period has ended.

#### `get-proposal-results(proposal-id)`

Returns voting results and whether it passed/quorum was met.

#### `get-token-balance(account)`

Returns the governance token balance for a user.

#### `get-total-supply()`

Returns total token supply.

#### `get-current-proposal-id()`

Returns the next proposal ID.

---

### 🔐 Admin-Only Functions

(Admin = contract deployer)

#### `mint-tokens(recipient, amount)`

Mints governance tokens for simulation/testing purposes.

#### `update-proposal-fee(new-fee)`

Updates the proposal creation fee.

#### `update-min-proposal-duration(new-duration)`

Sets a new minimum duration for proposals.

#### `update-default-quorum-threshold(new-threshold)`

Updates the default quorum threshold required.

---

## 📌 Constants

### Vote Types

* `vote-type-for`: `u1`
* `vote-type-against`: `u2`
* `vote-type-abstain`: `u3`

### Proposal Status

* `status-active`: `u1`
* `status-passed`: `u2`
* `status-rejected`: `u3`
* `status-executed`: `u4`

---

## 🚨 Error Codes

| Code       | Description               |
| ---------- | ------------------------- |
| `err u100` | Unauthorized              |
| `err u101` | Proposal already exists   |
| `err u102` | Proposal not found        |
| `err u103` | Proposal expired          |
| `err u104` | Proposal not expired      |
| `err u105` | Already voted             |
| `err u106` | Insufficient tokens       |
| `err u107` | Not proposal creator      |
| `err u108` | Proposal already executed |
| `err u109` | Invalid proposal duration |
| `err u110` | Invalid quorum threshold  |
| `err u111` | Not contract owner        |
| `err u112` | Proposal not active       |
| `err u113` | Proposal did not pass     |
| `err u114` | Invalid vote type         |

---
