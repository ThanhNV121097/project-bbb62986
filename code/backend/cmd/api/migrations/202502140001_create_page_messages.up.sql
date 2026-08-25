CREATE TABLE IF NOT EXISTS page_messages (
  id integer PRIMARY KEY,
  display_text text NOT NULL CHECK (length(btrim(display_text)) > 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT page_messages_singleton CHECK (id = 1)
);

INSERT INTO page_messages (id, display_text)
VALUES (1, 'Hello Word')
ON CONFLICT (id) DO NOTHING;
