# Test Cases — Render Hello Word page

Risk level: low. One read-only screen, no roles, no writes, no branching flows. Coverage targets exact requirement and contract checks plus visual checks the browser can observe.

## Cases

**Scenario**: AC-1 Stored text renders as page text
**Given**: Backend stores one row with `displayText` value `Hello Word`
**When**: Guest loads Hello Word page
**Then**: Page displays exactly `Hello Word` and no other visible copy replaces it
**Check**: render_url
**Traceability**: HELLO-001 / AC-1

**Scenario**: AC-2 Page uses backend-returned value, not frontend constant
**Given**: Backend stores one row with a non-default value such as `Hello Word` and frontend source contains no hardcoded page text
**When**: Guest loads Hello Word page
**Then**: Browser shows the value returned by `/v1/message`, matching backend data exactly
**Check**: render_url
**Traceability**: HELLO-001 / AC-2

**Scenario**: AC-3 Text is centered horizontally and vertically
**Given**: Page loads successfully
**When**: Guest views Hello Word page
**Then**: Main text sits at viewport center on both axes
**Check**: measure_styles
**Traceability**: HELLO-002 / AC-3

**Scenario**: AC-4 Page background is white and text is black
**Given**: Page loads successfully
**When**: Guest views Hello Word page
**Then**: Computed background is `#FFFFFF` and text color is `#000000`
**Check**: measure_styles
**Traceability**: HELLO-002 / AC-4

**Scenario**: AC-5 No extra UI, motion, or secondary content appears
**Given**: Page loads successfully
**When**: Guest views Hello Word page
**Then**: Page shows only centered displayed text, with no navigation, controls, secondary content, or animation
**Check**: measure_styles
**Traceability**: HELLO-002 / AC-5

**Scenario**: API returns stored text value
**Given**: Stored row exists in PostgreSQL
**When**: Client sends `GET /v1/message`
**Then**: Response status is `200`, content type is JSON, and body is `{ "displayText": "Hello Word" }` with exact stored value
**Check**: fetch_url
**Traceability**: HELLO-001; service contract `/v1/message` success shape

**Scenario**: API rejects unsupported method on message route
**Given**: `/v1/message` route exists
**When**: Client sends a non-GET method to `/v1/message`
**Then**: Response status is `405` and body uses shared error envelope with code `method_not_allowed`
**Check**: fetch_url
**Traceability**: service contract `/v1/message` error handling

**Scenario**: API surfaces backend read failure as internal error
**Given**: Stored text row is missing or database read fails
**When**: Client sends `GET /v1/message`
**Then**: Response status is `500` and body uses shared error envelope with code `internal_error`
**Check**: fetch_url
**Traceability**: service contract `/v1/message` failure path

**Scenario**: Page does not add extra loading or error UI
**Given**: Page loads successfully
**When**: Guest views Hello Word page
**Then**: No loading indicator, error banner, or fallback copy appears in normal success state
**Check**: manual
**Traceability**: HELLO-002 / design-only static screen
