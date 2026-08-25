# ERD — hello-word-17

## Tables

### `page_messages`

One row stores visible text for single page.

| Column | Type | Constraints | Purpose |
|---|---|---|---|
| `id` | `integer` | primary key, `id = 1` | Fixed singleton row. |
| `display_text` | `text` | not null, `length(btrim(display_text)) > 0` | Exact text frontend renders. |
| `created_at` | `timestamptz` | not null, default `now()` | Audit creation time. |
| `updated_at` | `timestamptz` | not null, default `now()` | Audit last update time, static for current scope. |

Seed row:

| `id` | `display_text` |
|---|---|
| `1` | `Hello Word` |

### `schema_migrations`

Migration runner state.

| Column | Type | Constraints | Purpose |
|---|---|---|---|
| `version` | `text` | primary key | Migration filename version. |
| `applied_at` | `timestamptz` | not null, default `now()` | Time migration finished. |

## Relationships

No foreign keys. `page_messages` is singleton domain table; `schema_migrations` is infrastructure table.

## Invariants

- Exactly one domain row is valid for current product scope: `page_messages.id = 1`.
- `display_text` is non-empty and returned exactly as stored.
- No write endpoint exists; data changes only through future migrations or manual DB maintenance outside product scope.
