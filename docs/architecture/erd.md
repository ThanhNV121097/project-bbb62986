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

Frontend mock contract matched by this table:

```ts
export type HelloWordResponse = {
  displayText: string;
};
```

`displayText` maps to `page_messages.display_text`.

### `schema_migrations`

Migration runner state.

| Column | Type | Constraints | Purpose |
|---|---|---|---|
| `version` | `text` | primary key | Migration filename version. |
| `applied_at` | `timestamptz` | not null, default `now()` | Time migration finished. |

## Relationships

No foreign keys. `page_messages` is singleton domain table; `schema_migrations` is infrastructure table.

## Indexes

No secondary indexes. Story reads by `page_messages.id = 1`, served by primary key.

## Invariants

- Exactly one domain row is valid for current product scope: `page_messages.id = 1`.
- `display_text` is non-empty and returned exactly as stored.
- No write endpoint exists; data changes only through future migrations or manual DB maintenance outside product scope.

## Migration plan

### Forward

1. Create `schema_migrations` table if migration runner requires it.
2. Create `page_messages` with columns and constraints listed above.
3. Insert seed row `(id, display_text) = (1, 'Hello Word')`.

### Backward

1. Drop `page_messages`.
2. Leave `schema_migrations` under migration runner ownership unless full backend teardown is requested.

### Safety on populated tables

Safe for empty database. On populated database, creating `page_messages` is safe if table does not exist. Seed insert must use fixed primary key `id = 1`; if row already exists, migration must not overwrite without explicit operator choice.
