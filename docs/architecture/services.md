# Service Design — hello-word-17

## Base rules

- Backend serves JSON over HTTP.
- Contract paths omit `/api`; deploy proxy strips that prefix before backend receives request.
- Versioned product paths start with `/v1`.
- All error responses use shared envelope below.

## Error envelope

```json
{
  "error": {
    "code": "internal_error",
    "message": "Request failed"
  }
}
```

| Field | Type | Notes |
|---|---|---|
| `error.code` | string | Stable machine code. |
| `error.message` | string | Generic user-safe message. |

Current codes:

| Code | HTTP | Meaning |
|---|---|---|
| `method_not_allowed` | 405 | Route exists but HTTP method is unsupported. |
| `not_found` | 404 | Route does not exist. |
| `internal_error` | 500 | Backend could not read required data. |

## Endpoints

### `GET /healthz`

Health endpoint for Compose and runtime. Returns 200 only after migrations have succeeded and `SELECT 1` against PostgreSQL works.

Auth: none.

Request body: none.

Success `200 text/plain`:

```text
ok
```

Errors: `500` with error envelope when database is not ready.

### `GET /v1/message`

Returns singleton displayed text for Hello Word page.

Auth: none.

Request body: none.

Success `200 application/json`:

```json
{
  "displayText": "Hello Word"
}
```

| Field | Type | Notes |
|---|---|---|
| `displayText` | string | Exact `page_messages.display_text` value. Matches reviewed UI mock `HelloWordResponse.displayText`. |

Frontend mock contract:

```ts
export type HelloWordResponse = {
  displayText: string;
};
```

Errors:

| HTTP | Code | When |
|---|---|---|
| 405 | `method_not_allowed` | Method other than GET. |
| 500 | `internal_error` | Row missing or database read fails. |

## Migration plan

### Forward

1. Create `page_messages` table per ERD.
2. Seed singleton row `id = 1`, `display_text = 'Hello Word'`.
3. Backend `GET /v1/message` reads `display_text` from `page_messages` where `id = 1` and returns `{ "displayText": value }`.

### Backward

1. Remove `GET /v1/message` backend route with its query.
2. Drop `page_messages` table if rolling schema back with code.

### Safety on populated tables

Safe for initial empty database. On populated database, route addition is safe. Table creation is safe only when table name is unused. Seed is safe only when `id = 1` is absent; otherwise migration must fail rather than replace existing displayed text silently.
