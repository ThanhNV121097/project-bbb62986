# Test Cases — Render Hello Word page

Risk: low. One public read-only screen, but it depends on backend and PostgreSQL, so cover data read, rendering, appearance, and contract errors.

## Automated coverage

**Scenario**: AC-1 stored text renders as page text
**Given** PostgreSQL stores one row with `display_text = "Hello Word"` and backend API is running
**When** Guest loads the page
**Then** browser displays exactly `Hello Word`
**Check**: render_url
**Trace**: HELLO-001 AC-1

**Scenario**: AC-2 page uses backend-returned value, not frontend constant
**Given** PostgreSQL stores one row with `display_text = "Hello Word"` and backend API is running
**When** Guest loads the page
**Then** browser displays the text returned by `/v1/message`; no hardcoded fallback text is needed for the page to show the value
**Check**: render_url
**Trace**: HELLO-001 AC-2

**Scenario**: AC-5 no extra UI, motion, or secondary content
**Given** page loads successfully
**When** Guest views page
**Then** browser shows only single text content and no buttons, links, menus, loading spinner, or animation
**Check**: measure_styles
**Trace**: HELLO-002 AC-5

**Scenario**: GET `/v1/message` returns stored text shape
**Given** PostgreSQL stores one row with `display_text = "Hello Word"`
**When** client sends `GET /v1/message`
**Then** response is `200 OK` with JSON body `{ "displayText": "Hello Word" }`
**Check**: fetch_url
**Trace**: HELLO-001 AC-1, HELLO-001 AC-2

**Scenario**: GET `/v1/message` rejects unsupported method
**Given** backend API is running
**When** client sends `POST /v1/message`
**Then** response is `405 Method Not Allowed` with error envelope code `method_not_allowed`
**Check**: fetch_url
**Trace**: service contract /v1/message method rule

**Scenario**: GET `/v1/message` fails when stored row is missing
**Given** `page_messages` has no row
**When** client sends `GET /v1/message`
**Then** response is `500 Internal Server Error` with error envelope code `internal_error`
**Check**: fetch_url
**Trace**: service contract /v1/message failure rule

**Scenario**: GET `/healthz` returns ready only after DB works
**Given** migrations succeeded and PostgreSQL answers `SELECT 1`
**When** client sends `GET /healthz`
**Then** response is `200 OK` with plain text body `ok`
**Check**: fetch_url
**Trace**: service contract /healthz success rule

## Manual / browser-measured coverage

**Scenario**: AC-3 text is centered horizontally and vertically
**Given** page loads successfully
**When** Guest views page
**Then** text sits at viewport center on both axes
**Check**: measure_styles
**Trace**: HELLO-002 AC-3

**Scenario**: AC-4 background is white and text is black
**Given** page loads successfully
**When** Guest views page
**Then** computed page background is `#FFFFFF` and text color is `#000000`
**Check**: measure_styles
**Trace**: HELLO-002 AC-4

**Scenario**: no extra content appears on screen
**Given** page loads successfully
**When** Guest views page
**Then** no secondary content, navigation, or motion appears
**Check**: measure_styles
**Trace**: HELLO-002 AC-5
