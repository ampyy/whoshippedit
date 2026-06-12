# WhoBuiltThis — Complete Design Specification
> Give this entire document to your AI coding assistant. It contains every design decision needed to implement the UI.

---

## 1. Product identity

**Name:** WhoBuiltThis  
**Tagline:** Find what's been built. Validate what should be. See who's winning.  
**Audience:** Indie founders, solo developers, bootstrapped SaaS builders  
**Feeling:** Trusted, clean, community-driven. Like Linear met Indie Hackers. Not corporate, not chaotic.

---

## 2. Design philosophy

- Flat surfaces only. Zero gradients, zero shadows, zero blur, zero glow.
- 0.5px borders everywhere. Nothing heavier.
- Generous whitespace. If it feels tight, add more padding.
- Color is used sparingly — only for badges and semantic meaning.
- Everything else is near-black on white (light) or near-white on near-black (dark).
- Two font weights only: 400 (body) and 500 (labels, headings). Never 600 or 700.
- Sentence case everywhere. Never Title Case, never ALL CAPS.

---

## 3. Typography

**Font:** `Geist` (Vercel's font — clean, technical, readable at all sizes)  
Fallback: `ui-sans-serif, system-ui, sans-serif`

```css
font-family: 'Geist', ui-sans-serif, system-ui, sans-serif;
```

**Scale:**
| Use | Size | Weight | Line height |
|-----|------|--------|-------------|
| Page title (h1) | 22px | 500 | 1.3 |
| Section heading (h2) | 18px | 500 | 1.4 |
| Card title (h3) | 14px | 500 | 1.4 |
| Body text | 13px | 400 | 1.7 |
| Labels / meta | 12px | 400 | 1.5 |
| Badges / tags | 11px | 500 | 1 |
| Tiny hints | 10px | 400 | 1.4 |

**Rule:** Never go below 10px. Never use weight 600 or 700 anywhere.

---

## 4. Color system

### Light mode

```css
/* Backgrounds */
--bg-page:        #F7F7F5;   /* page background — warm off-white, not pure white */
--bg-surface:     #FFFFFF;   /* cards, modals, inputs */
--bg-hover:       #F2F2F0;   /* hover state on cards and rows */
--bg-subtle:      #EBEBEA;   /* secondary surfaces, code blocks */

/* Text */
--text-primary:   #0F0F0E;   /* headings, product names */
--text-secondary: #6B6B68;   /* descriptions, meta, one-liners */
--text-tertiary:  #9B9B97;   /* timestamps, hints, placeholder */
--text-link:      #5B5BD6;   /* links, interactive text */

/* Borders */
--border-default: rgba(0,0,0,0.08);   /* 0.5px — most borders */
--border-medium:  rgba(0,0,0,0.14);   /* hover state borders */
--border-strong:  rgba(0,0,0,0.20);   /* focused inputs */

/* Accent — purple (primary brand) */
--accent:         #5B5BD6;   /* primary buttons, active tabs, links */
--accent-bg:      #EEEEFF;   /* purple badge background */
--accent-text:    #3333A3;   /* purple badge text */
--accent-border:  #C7C7F0;   /* purple badge border */

/* Verified — green */
--verified:       #18794E;   /* verified text */
--verified-bg:    #DFF3EB;   /* verified badge background */
--verified-text:  #166035;   /* verified badge text */
--verified-border:#A8DFC5;   /* verified badge border */

/* Featured — amber */
--featured:       #AD5700;   /* featured text */
--featured-bg:    #FFF1D7;   /* featured badge background */
--featured-text:  #7C3D12;   /* featured badge text */
--featured-border:#F5CC8A;   /* featured badge border */

/* Revenue ranges */
--mrr-0-bg:       #F2F2F0;   /* No revenue / Idea */
--mrr-1k-bg:      #FFF1D7;   /* $1–$1k MRR */
--mrr-10k-bg:     #E8F5FF;   /* $1k–$10k MRR */
--mrr-100k-bg:    #DFF3EB;   /* $10k–$100k MRR */
--mrr-big-bg:     #EEEEFF;   /* $100k+ MRR */

/* Semantic */
--danger-bg:      #FFEFEF;   
--warning-bg:     #FFF8E6;   
```

### Dark mode

```css
@media (prefers-color-scheme: dark) {
  --bg-page:        #0C0C0B;
  --bg-surface:     #141413;
  --bg-hover:       #1C1C1B;
  --bg-subtle:      #242422;

  --text-primary:   #EDEDEC;
  --text-secondary: #A0A09C;
  --text-tertiary:  #6B6B68;
  --text-link:      #8B8BFF;

  --border-default: rgba(255,255,255,0.07);
  --border-medium:  rgba(255,255,255,0.12);
  --border-strong:  rgba(255,255,255,0.18);

  --accent:         #8B8BFF;
  --accent-bg:      #1E1E3F;
  --accent-text:    #ADADFF;
  --accent-border:  #3535A0;

  --verified:       #4CC38A;
  --verified-bg:    #0D2E1F;
  --verified-text:  #4CC38A;
  --verified-border:#1A5738;

  --featured:       #F5A623;
  --featured-bg:    #2A1D00;
  --featured-text:  #F5A623;
  --featured-border:#6B4500;
}
```

---

## 5. Tailwind config

Add this to your `tailwind.config.js`:

```js
module.exports = {
  darkMode: 'media',
  content: [
    "./Views/**/*.cshtml",
    "./Pages/**/*.cshtml",
    "./wwwroot/**/*.html",
    "./wwwroot/**/*.js"
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Geist', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
      colors: {
        page:    'var(--bg-page)',
        surface: 'var(--bg-surface)',
        hover:   'var(--bg-hover)',
        subtle:  'var(--bg-subtle)',
      },
      fontSize: {
        '10': ['10px', { lineHeight: '1.4' }],
        '11': ['11px', { lineHeight: '1.5' }],
        '12': ['12px', { lineHeight: '1.5' }],
        '13': ['13px', { lineHeight: '1.7' }],
        '14': ['14px', { lineHeight: '1.6' }],
      },
      borderWidth: {
        DEFAULT: '0.5px',
        '0': '0',
        '1': '1px',
        '2': '2px',
      },
      borderColor: {
        DEFAULT: 'var(--border-default)',
        medium:  'var(--border-medium)',
        strong:  'var(--border-strong)',
      },
      borderRadius: {
        sm:  '4px',
        md:  '8px',
        lg:  '12px',
        xl:  '16px',
        full: '9999px',
      },
    },
  },
}
```

---

## 6. Core components

### Card
```
bg-surface
border border-default rounded-lg
p-4
hover:border-medium hover:bg-hover
transition-colors duration-150
```
No shadow. Ever. Border only.  
Featured cards get `border-2 border-[var(--accent-border)]` — the only 2px border in the system.

### Badge / pill system

All badges follow this pattern:
```
inline-flex items-center gap-1
text-11 font-medium
px-2 py-0.5
rounded-full
border
```

| Badge | bg | text | border |
|-------|----|------|--------|
| Verified | `--verified-bg` | `--verified-text` | `--verified-border` |
| Featured | `--featured-bg` | `--featured-text` | `--featured-border` |
| Category | `--bg-subtle` | `--text-secondary` | `--border-default` |
| Idea | `#FFEFEF` | `#9B1515` | `#FFCECE` |
| $0 MRR | `#F2F2F0` | `#6B6B68` | `--border-default` |
| $1–$1k MRR | `#FFF1D7` | `#7C3D12` | `#F5CC8A` |
| $1k–$10k MRR | `#E8F5FF` | `#1A5F8A` | `#B3D9F5` |
| $10k–$100k MRR | `#DFF3EB` | `#166035` | `#A8DFC5` |
| $100k+ MRR | `#EEEEFF` | `#3333A3` | `#C7C7F0` |

### Input / search
```
w-full h-9
bg-surface
border border-default rounded-lg
px-3 text-13 text-primary
placeholder:text-tertiary
focus:outline-none focus:border-strong
transition-colors
```

### Upvote button
```
inline-flex items-center gap-1.5
text-12 text-secondary
px-2.5 py-1
rounded-md
border border-default
bg-surface
hover:bg-hover hover:text-primary
transition-colors
```
When voted: `bg-[var(--accent-bg)] text-[var(--accent-text)] border-[var(--accent-border)]`

### Primary button
```
inline-flex items-center gap-1.5
text-12 font-medium text-surface
bg-[var(--accent)]
px-3 py-1.5
rounded-md
hover:opacity-90
transition-opacity
```

### Tabs
```
flex gap-4
border-b border-default
```
Each tab:
```
text-12 text-secondary
pb-2.5 -mb-px
hover:text-primary
transition-colors
```
Active tab:
```
text-primary font-medium
border-b-[1.5px] border-[var(--accent)]
```

---

## 7. Layout + spacing

**Max content width:** 1100px, centered with `mx-auto px-6`  
**Nav height:** 52px  
**Page padding top:** 32px  
**Section gap:** 48px  
**Card grid:** `grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3`  
**Sidebar layout (product page):** `grid-cols-[1fr_280px] gap-8`

**Spacing scale (use only these):**
- 4px (gap-1), 6px (gap-1.5), 8px (gap-2), 12px (gap-3), 16px (gap-4), 24px (gap-6), 32px (gap-8), 48px (gap-12)

---

## 8. Navigation

```
Fixed top. height 52px.
bg-surface/80 backdrop-blur-md
border-b border-default
```

Left: Logo — `text-14 font-medium text-primary` — just text, no icon  
Center: Links — `text-12 text-secondary hover:text-primary` — Directory · Validate · Verified · Submit  
Right: Sign in button — ghost style with border

Logo hover: no underline, slight opacity change only.

---

## 9. Product card — exact spec

```
bg-surface rounded-lg border border-default p-4
hover:border-medium transition-colors cursor-pointer
```

**Inside (top to bottom):**

1. **Header row** — flex justify-between items-start
   - Left: logo (32×32, rounded-md, bg-subtle as fallback with initial letter) + name (text-13 font-medium) + tagline (text-12 text-secondary)
   - Right: upvote button

2. **Badge row** (mt-2.5) — flex gap-1.5 flex-wrap
   - Revenue range badge
   - Category badge
   - Verified badge (if verified)
   - Featured badge (if featured)

3. **Footer row** (mt-2.5) — text-11 text-tertiary
   - "73% would build this · 12 comments"

**Logo fallback:** When no logo — colored square with first letter
Colors rotate by alphabet: A–E = accent-bg, F–J = verified-bg, K–O = featured-bg, P–T = subtle, U–Z = danger-bg

---

## 10. Page backgrounds

**Homepage:** `bg-page` — the warm off-white (#F7F7F5)  
**Product page:** `bg-page`  
**Admin panel:** `bg-page`  
**Cards/surfaces:** always `bg-surface` (#FFFFFF light / #141413 dark)

The slight warmth of `--bg-page` vs pure white makes the white cards pop without any shadow. This is the entire depth system.

---

## 11. Dividers + separators

Always: `border-t border-default` — never a colored or heavy divider.  
Section labels above groups: `text-10 font-medium text-tertiary uppercase tracking-wider mb-2`

---

## 12. What NOT to do

- No `shadow-*` classes anywhere in the codebase
- No `gradient` anywhere
- No font weight above 500
- No ALL CAPS text (except section labels in tracking-wider style)
- No colored backgrounds on full-width sections
- No border-radius above `rounded-xl` (16px)
- No animation except `transition-colors duration-150` and `transition-opacity`
- No emoji in UI
- No text below 10px

---

## 13. Page-by-page implementation notes

### Homepage
- Sticky nav
- Hero: centered search bar (max-w-xl), subtitle text-13 text-secondary below
- Filter row: flex gap-2, all selects same height (h-8), rounded-md
- Tab bar: flush left, border-bottom tab style
- Grid: 3 columns desktop, 2 tablet, 1 mobile
- Right sidebar (desktop only, 260px): milestone feed + "building now" counter

### Product page
- Two-column: content (flex-1) + sidebar (280px fixed)
- All data sections separated by `border-t border-default mt-6 pt-6`
- "Would you build this?" — progress bar: h-1.5 rounded-full bg-subtle, fill with bg-[var(--verified)] at percentage width
- Comments: indented 20px for replies, `border-l border-default ml-4 pl-4`

### Alternatives page
- Single column list (not grid)
- Each row: card style, flex between product info and upvote
- Featured pinned at top with 2px accent border
- Filter pills at top: All / Verified / Free tier / Under $29

### Admin panel
- Full-width table layout
- Row hover: `bg-hover`
- Action buttons: text-11, minimal border style
- Status column: badge system same as public site
- Keyboard shortcut hint shown in header: "A = approve · R = reject"

---

## 14. Animations

**Only two allowed:**
1. `transition-colors duration-150` — on all interactive elements (cards, buttons, inputs)
2. `transition-opacity duration-150` — on primary buttons

No entrance animations. No skeleton loaders (use simple `bg-subtle animate-pulse rounded` placeholders only). No page transitions.

The site should feel instant and native, not animated.

---

## 15. Iconography

Use **Lucide React** (or Lucide icon set). Outline style only. Never filled.

Common icons used:
- `ArrowUp` — upvote
- `ShieldCheck` — verified
- `Star` — featured  
- `MessageSquare` — comments
- `Users` — customers
- `Hammer` — building
- `Search` — search bar
- `ChevronDown` — dropdowns
- `ExternalLink` — website link
- `Copy` — share/copy
- `Check` — success state
- `X` — close/remove
- `Flame` — trending

Size: 14px inline, 16px standalone. `stroke-width={1.5}` always. Never `stroke-width={2}`.

---

## Summary for your AI assistant

> Build WhoBuiltThis using Next.js + Tailwind. Design direction: flat minimal, Linear/Vercel aesthetic, warm off-white page background (#F7F7F5), white surfaces, 0.5px borders, no shadows anywhere. Font: Geist 400/500 only. Color accents: purple (#5B5BD6) for brand/links, green (#18794E) for verified, amber (#AD5700) for featured. Revenue range badges use specific background/text/border color combinations per tier (see section 8). Dark mode via CSS variables and `prefers-color-scheme`. Every card is `bg-surface border border-default rounded-lg` with `hover:border-medium hover:bg-hover transition-colors`. No gradients, no shadows, no animations except color transitions. Two font weights maximum. Sentence case everywhere.
