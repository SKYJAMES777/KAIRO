# KAIRO MVP

KAIRO is a Web3 Catalyst and Boost platform for reviving dormant token ecosystems. The current implementation keeps the existing neon fintech preview experience while adding the scalable MVP structure:

- `src/`: preserved visual mock experience and reusable UI components.
- `client/`: React Router entrypoints and new product pages.
- `shared/`: KAIRO domain types, Zod schemas, and mapping helpers.
- `worker/`: Cloudflare Workers + Hono API, service layer, and D1 migrations.
- `kairo_project_docs/`: product docs, static preview, and original schema reference.

## Local Development

```bash
npm install
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

Deploy after replacing the placeholder D1/KV IDs in `wrangler.toml`:

```bash
npm run db:migrate:remote
npm run deploy:worker
```

## Verification

```bash
npm run lint
npm run build
```

Frontend copy must display `Reward confirmed by KAIRO` / `奖励已由 KAIRO 确认` instead of escrow or custody language.
