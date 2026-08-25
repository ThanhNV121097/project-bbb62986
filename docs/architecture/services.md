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

Request body: none.

Success `200 text/plain`:

```text
ok
```

Errors: `500` with error envelope when database is not ready.

### `GET /v1/message`

Returns singleton displayed text for Hello Word page.

Request body: none.

Success `200 application/json`:

```json
{
  "displayText": "Hello Word"
}
```

| Field | Type | Notes |
|---|---|---|
| `displayText` | string | Exact `page_messages.display_text` value. |

Errors:

| HTTP | Code | When |
|---|---|---|
| 405 | `method_not_allowed` | Method other than GET. |
| 500 | `internal_error` | Row missing or database read fails. |
