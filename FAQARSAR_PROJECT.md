# Faqarsar.com — Cursor Project Doc

## Overview
- Village Faqarsar family tree | 394 members | 10 generations
- Single-file HTML (~306KB) | Vanilla JS/CSS | No framework
- Bilingual: English + Punjabi (Gurmukhi) toggle
- Fonts: Playfair Display + DM Sans | Dark theme #0c0b0f + gold rgba(200,170,120)

## Views

### Landing Page
- Logo (base64 PNG), title, stats, two CTAs
- Fixed lang toggle (top-right, z-300)

### Family Tree (z-200 fullscreen overlay)
- Recursive layout: subtreeWidth + layoutTree | NODE_W:160, NODE_H:80
- SVG bezier curves with animated flowing dashes on highlight
- Pan/zoom/touch | Minimap | Search
- Click: ancestors pulse (staggered), descendants glow, rest dims to 15%
- Spotlight: double expanding ring pulse on active node
- flyToPerson(id): cinematic 1.2s zoom from overview to target
- Note badges: alias(gold), location(green), death(red), title(blue), info(red)
- genLabelShort for tree nodes: "Gen 5" / Punjabi ordinals

### Profile Cards (z-200 fullscreen overlay)
- Royal/heritage styled grid | Gold ornamental borders
- Custom dark dropdown for generation filter + search
- Each card: name, gurmukhi, gen, father full name, children/descendants, notes

### Profile Modal (z-400)
- Gender avatar: Option B silhouettes (blue male, pink female)
- Status badges with SVG icons: location, alias, title, death notes
- 2-column grid: Born, Died, Father, Spouse (with SVG icons)
- Lineage path, children, siblings tags
- "View in tree" -> flyToPerson animation
- All labels translate to Punjabi

## Data Schema
```json
{
  "id": "p1",
  "firstName": "",
  "middleName": "Singha",
  "lastName": "Singh",
  "gender": "male",
  "birth": "",
  "death": "",
  "spouse": "",
  "parents": [],
  "children": ["p2"],
  "notes": "📍 Punjab",
  "gurmukhi": "ਬਾਬਾ ਸਿੰਘਾ"
}
```

### Notes conventions
- Aliases: "Alias Shotu" (25 mapped to Gurmukhi)
- Locations: "📍 Punjab/Rajasthan/Haryana/Kheowali" (Punjab hidden on tree)
- Titles: "Chairman", "Doctor", "Paathi", "Sarpanch 1983-1993"
- Death: "Died in a train accident", "Died with no children"
- Family: "Had no children", "Had daughters", "Had 1 daughter"
- Other: "Jaggar Singh received the land/property", "born DD/MM/YYYY", "Passed 10th in 1972"

## Key Functions
| Function | Purpose |
|---|---|
| openTree/closeTree | Tree overlay |
| openProfiles/closeProfiles | Profiles overlay |
| openModal/closeModal | Profile modal |
| toggleLang() | Switch en/pa, updates ALL text |
| flyToPerson(id) | Cinematic zoom + staggered highlights |
| selectPerson(id) | Instant select + spotlight |
| treeNoteBadges(note) | Color-coded note tags on tree nodes |
| displayNote(note) | Translate notes to Punjabi |
| formatNotesHtml/formatCardNotesHtml | Split notes into styled divs |
| genLabel/genLabelShort | Generation labels (full/short) |
| name(id)/fullName(id) | Display name in current lang |
| buildNodes/buildLines | Create tree DOM |
| buildProfileCards/filterProfiles | Profile grid |

## State
- lang, activeId, scale/tx/ty, treeBuilt, profilesBuilt, selectedGen, genMemo, positions

## CSS tokens
- BG: #0c0b0f | Card: #141218 | Surface: #1a1820
- Gold: rgba(200,170,120) | Red: rgba(180,80,60) | Green: rgba(80,180,120) | Blue: rgba(120,160,200) | Pink: rgba(213,115,138)
- Tree badges: .note-tag.alias .info .title .loc .death
- Modal badges: .mbadge-green .mbadge-red .mbadge-gold .mbadge-blue

## Pending features (previewed, not implemented)
- Photo support with gender silhouette placeholders
- Slideable profile cards (2-slide swipe)
- Single card with photo option
- Migration map (Leaflet.js, real coordinates, animated paths)

## Files
- faqarsar.html — Complete website
- singh-family.json — Data (394 members + gurmukhi + gender/birth/death/spouse)
- FAQARSAR_PROJECT.md — This file
