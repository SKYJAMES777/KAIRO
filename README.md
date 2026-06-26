# KAIRO MVP

KAIRO Phase 0 is positioned as a **Crypto Comeback Launchpad**: dormant crypto communities can publish Catalysts, AI Builders can submit comeback demos, and supporters can Boost the strongest revival paths into visible Momentum and leaderboard placement.

The current implementation keeps the existing neon fintech preview experience while adding the scalable MVP structure:

- `src/`: preserved visual mock experience and reusable UI components.
- `client/`: React Router entrypoints and new product pages.
- `shared/`: KAIRO domain types, Zod schemas, and mapping helpers.
- `worker/`: Cloudflare Workers + Hono API, service layer, and D1 migrations.
- `kairo_project_docs/`: product docs, static preview, and original schema reference.

## Product Boundary

Phase 0 focuses on Catalyst discovery, Builder submissions, community Boosts, Momentum ranking, Proof of Support, Funding Status, and public leaderboards.

Phase 0 explicitly does **not** include token swap, investment products, custody, crowdfunding, or a platform token economy. Funding Status is a user-facing reward commitment and verification signal only; do not describe it as custody, escrow, or a KAIRO-held asset service. Frontend copy must display `Reward confirmed by KAIRO` / `奖励已由 KAIRO 确认` instead of escrow or custody language.

## Local Development

Install dependencies:

```bash
npm install
```

Run the local frontend dev server:

```bash
npm run dev
```

Vite starts on port `3000` by default and will pick the next open port if needed.

Useful routes:

- `/`: KAIRO arena dashboard
- `/catalysts`: Catalyst list
- `/catalysts/cat-1`: Catalyst detail deep link
- `/leaderboard`: Leaderboard
- `/builder`: Builder terminal
- `/proof`: Proof of Support
- `/admin`: Admin-oriented Catalyst workspace

## Worker And D1

Run the Cloudflare Worker locally:

```bash
npm run dev:worker
```

Apply local D1 migrations:

```bash
npm run db:migrate:local
```

Seed the local D1 database with demo Phase 0 data:

```bash
npm run db:seed:local
```

Deploy after replacing the placeholder D1/KV IDs in `wrangler.toml`:

```bash
npm run db:migrate:remote
npm run deploy:worker
```

## API Endpoints

Current Worker endpoints are:

### Bounties / Catalysts

- `GET /api/bounties` — list Catalysts ordered by Momentum.
- `GET /api/bounties/:id` — fetch one Catalyst.
- `POST /api/bounties` — create a Catalyst record.

### Submissions

- `GET /api/submissions` — list recent submissions.
- `GET /api/submissions?bountyId=:id` — list submissions for a Catalyst.
- `POST /api/submissions` — create a Builder submission.

### Boost

- `POST /api/boosts` — Boost a Catalyst or submission and create the related support event.

### Support Proof

- `GET /proof` — frontend Proof of Support page for Phase 0 supporter activity.
- Support proof data is generated from `boosts`, `support_events`, and `support_points`; a dedicated Worker endpoint such as `GET /api/support/proof/me` is planned but not yet implemented in this MVP worker.

### Leaderboards

- `GET /api/leaderboard` — return hottest Catalysts and top Builders.

## Verification

```bash
npm run lint
npm run build
```
