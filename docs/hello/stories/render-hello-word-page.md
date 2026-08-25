# Story — Render Hello Word page

## User story
As a Guest, I want load page and see stored text for this product, so that page proves display comes from persisted data.

## In scope
- Render single Hello Word screen for Guest.
- Read displayed text from backend API.
- Show returned value centered horizontally and vertically on plain white background.
- Keep visible text black and exact to stored value.

## Out of scope
- Sign-in, permissions, or user accounts.
- Editing displayed text.
- Extra pages, navigation, controls, or animation.
- Loading or error states in UI.

## UI scope
- One screen only: Hello Word page.
- Approved design section: single centered text screen.
- Default state only.
- No other UI states are part of this story.

## Acceptance criteria
1. Given stored text is `Hello Word`, when Guest loads page, then page shows `Hello Word`.
2. Given stored text is present, when Guest loads page, then frontend uses backend-returned value, not hardcoded constant.
3. Given page loads successfully, when Guest views page, then text is centered both horizontally and vertically.
4. Given page loads successfully, when Guest views page, then background is white and text is black.
5. Given page loads successfully, when Guest views page, then no extra UI, motion, or secondary content appears.

## Dependencies
- Backend API for returning stored text value.
- PostgreSQL row containing displayed text.
- Approved design and design system for plain white screen and centered black text.
