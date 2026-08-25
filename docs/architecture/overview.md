# Architecture Overview — hello-word-17

## Stack

- Shape: fullstack — Next.js UI, Go API, PostgreSQL persistence.
- Frontend: Next.js 15 App Router, TypeScript, Tailwind v3, ESLint.
- Backend: Go 1.22 HTTP server using PostgreSQL driver `github.com/jackc/pgx/v5`.
- Database: PostgreSQL 16; backend self-applies SQL migrations on boot.
- Containers: existing repo Docker Compose and service Dockerfiles build `code/frontend/` and `code/backend/`.
- CI gate: `.github/workflows/ci.yml` runs Go build/vet/test, npm ci/lint/build/test, and CSS token checks.

## Folder layout

```text
code/backend/
  cmd/api/main.go          # one main package and HTTP entrypoint
  internal/migrations/     # embedded SQL migrations and runner
  migrations/              # timestamped SQL up/down files
  .env.example             # backend env keys
code/frontend/
  app/layout.tsx           # App Router layout
  app/page.tsx             # composition root only; stories mount components here
  app/globals.css          # frozen shared design tokens and base styles
  .env.example             # frontend env keys
docs/architecture/
  overview.md              # this file
  erd.md                   # tables and relationships
  services.md              # API contracts
```

## Runtime flow

1. PostgreSQL starts with empty database.
2. Backend reads `DATABASE_URL`, applies pending `code/backend/migrations/*.up.sql` once, verifies DB with `SELECT 1`, then listens on `PORT`, `APP_PORT`, or `8080`.
3. `/healthz` returns 200 only after migrations and DB ping succeed.
4. Frontend reads `NEXT_PUBLIC_API_URL` and later story code calls backend API for displayed text.

## Env vars

| Service | Key | Required | Notes |
|---|---|---|---|
| backend | `DATABASE_URL` | yes | Full PostgreSQL URL injected by runtime/compose. |
| backend | `PORT` | no | Preferred listen port; default `8080`. |
| backend | `APP_PORT` | no | Fallback listen port. |
| frontend | `NEXT_PUBLIC_API_URL` | yes | Browser-visible backend base URL. |
| root compose | `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` | yes | Local Postgres bootstrap values. |

## Conventions

- Backend route paths use `/v1/...`; never mount product routes under `/api`.
- API errors use one JSON envelope, documented in `services.md`.
- SQL migrations are timestamped pairs and tracked in `schema_migrations`; reruns are no-ops.
- Frontend `app/page.tsx` stays Server Component and only composes story components.
- React components use `export default function ComponentName()`.
- Story-owned frontend files remain under `code/frontend/components/` and `code/frontend/lib/mock/` until API replacement.
- Shared CSS values must come from `app/globals.css`; no token fallbacks.

## Decisions

| Decision | Rejected alternative | Tradeoff |
|---|---|---|
| Use Go stdlib `net/http` with pgx. | Add Gin/Fiber. | Less code and dependency surface; no routing complexity needed for one read endpoint. |
| Backend self-migrates on boot. | External migration job. | Works with empty runtime DB; startup carries migration responsibility. |
| Store one row in `page_messages`. | Hardcode frontend string or config file. | Satisfies persistence proof; adds DB dependency required by brief. |
| Keep `page.tsx` empty shell now. | Implement Hello Word screen in scaffold. | Avoids feature work in architecture task; story owns UI and API wiring. |
| Plain Tailwind setup with CSS tokens. | Component library. | Minimal UI needs no library; story code must still use tokens. |

## Run and check

```bash
cp .env.example .env
docker compose --profile local up --build
```

Local checks match CI:

```bash
cd code/backend && go build ./... && go vet ./... && go test ./...
cd code/frontend && npm ci && npm run lint && npm run build && npm test --if-present
```

## Risks and unknowns

- Product has no approved user-facing error screen; frontend story should keep failure handling minimal and non-visual unless PM revises design.
- One-row invariant lives in DB seed migration and API query; changing to multiple messages needs SRS, ERD, and service contract update.
