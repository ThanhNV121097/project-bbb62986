# Design System — hello-word-17

> Source of truth: the approved `index.html` (preview: approved design).
> Every value below is extracted from it. Changing a value here without
> changing the approved design is a defect.

Last updated: 2025-02-14

## 1. Foundations

### 1.1 Color

Semantic tokens. Name by job, never by hue.

| Token | Value | Used for |
|---|---|---|
| `--color-bg` | `#FFFFFF` | Page background |
| `--color-text` | `#000000` | Body text |

#### Contrast audit

| Foreground | Background | Ratio | Passes |
|---|---|---|---|
| `--color-text` | `--color-bg` | `21:1` | AA / AA Large |

### 1.2 Spacing

Base unit: `4px`. Layout uses no spacing scale beyond centering via CSS grid.

| Token | Value |
|---|---|
| `--space-0` | `0px` |

### 1.3 Typography

Font families:

- Body: `Arial, Helvetica, sans-serif`
- Headings: `Arial, Helvetica, sans-serif`
- Mono: not used

| Token | Size | Line height | Weight | Used for |
|---|---|---|---|---|
| `--text-xl` | `clamp(2.5rem, 8vw, 6rem)` | `1` | `400` | `h1` |

Heading levels are used in order and never skipped for visual sizing.

### 1.4 Radius, border, shadow, motion

| Token | Value | Used for |
|---|---|---|
| `--radius-sm` | `0` | Not used |
| `--radius-md` | `0` | Not used |
| `--radius-lg` | `0` | Not used |
| `--radius-full` | `0` | Not used |
| `--border-width` | `0` | Not used |
| `--shadow-sm` | `none` | Not used |
| `--shadow-md` | `none` | Not used |
| `--shadow-lg` | `none` | Not used |
| `--duration-fast` | `0ms` | Not used |
| `--duration-base` | `0ms` | Not used |
| `--easing` | `linear` | Not used |

Motion respects `prefers-reduced-motion: reduce`: no motion exists.

### 1.5 Layout and breakpoints

| Name | Min width | Container | Columns | Gutter |
|---|---|---|---|---|
| `sm` | `0px` | `100vw` | `1` | `0px` |
| `md` | `768px` | `100vw` | `1` | `0px` |
| `lg` | `1024px` | `100vw` | `1` | `0px` |
| `xl` | `1280px` | `100vw` | `1` | `0px` |

Z-index scale (only these values are allowed):

| Layer | Value |
|---|---|
| Base | `0` |
| Sticky header | `0` |
| Dropdown | `0` |
| Modal backdrop | `0` |
| Modal | `0` |
| Toast | `0` |

## 2. Components

One subsection per reusable component. Every component lists **all** states.

### 2.1 Page canvas

**Purpose** — Full-screen stage for single centered message.

**Anatomy** — `[body] [main] [h1]`.

**Variants**

| Variant | Tokens | When to use |
|---|---|---|
| Default | `--color-bg`, `--color-text` | Only screen in app |

**Sizes**

| Size | Height | Padding | Text token |
|---|---|---|---|
| Default | `100vh` | `0` | `--text-xl` |

**States** — every row must be filled in.

| State | Visual change | Tokens |
|---|---|---|
| Default | White screen, centered black text | `--color-bg`, `--color-text` |
| Hover | None | None |
| Focus (keyboard) | None | None |
| Active / pressed | None | None |
| Disabled | None; page is not interactive | None |
| Loading | Not used | None |
| Error | Not used | None |
| Empty | Not used | None |

**Accessibility** — semantic `main` landmark, readable `h1`, 44×44px target not applicable because no controls.

## 3. Content and formatting

- Voice and tone: plain, direct, no marketing copy.
- Date, time, number, and currency formats: not used.
- Capitalization rule: sentence case for visible text.
- Empty-state and error-message wording pattern: not used.

## 4. Known deviations

| Where | Deviation | Why it stands | Follow-up |
|---|---|---|---|
| `html, body` | Uses `display: grid` and `place-items: center` instead of a documented spacing token | Needed for exact horizontal and vertical centering | None |
| Typography | Only one text size exists; no full type ramp | Page has one heading only | None |
| Components | No interactive components, loading states, or error states exist | Single static screen | None |
| Breakpoints | Breakpoint rows are present in template but layout does not change by width | Responsive behavior is identical at all widths | None |
| Z-index | All layers are `0` | No layered UI exists | None |
| Motion | No motion tokens used | Design is intentionally static | None |

## 5. Change log

| Date | Change | Design PR |
|---|---|---|
| 2025-02-14 | Initial design system for hello-word-17 | Pending |
