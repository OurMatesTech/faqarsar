# Faqarsar.com — Cursor Project Doc

## Overview
- Village Faqarsar family tree | 394 members | 10 generations
- Single-file HTML (~336KB) | Vanilla JS/CSS | No framework
- Bilingual: English + Punjabi (Gurmukhi) toggle
- Fully responsive: mobile (380px) + tablet (768px) + desktop
- Fonts: Playfair Display + DM Sans | Dark theme #0c0b0f + gold rgba(200,170,120)
- Mapbox GL JS v3.2.0 for migration map

## Views

### 1. Landing Page
- Logo (base64 PNG), title "Family of Faqarsar", stats (394/10/42)
- Three CTAs: "Explore the family tree" / "Browse profiles" / "Migration map 🌐"
- Fixed ਪੰਜਾਬੀ toggle (top-right, z-300)

### 2. Family Tree (z-200 fullscreen overlay)
- Recursive layout | NODE_W:160, NODE_H:80 | SVG bezier curves
- Pan/zoom/pinch-touch | Minimap | Search
- flyToPerson: cinematic (desktop) / instant (mobile)
- Note badges: alias(gold), location(green), death(red), title(blue), info(red)

### 3. Profile Cards (z-200 fullscreen overlay)
- Royal/heritage grid (single column mobile)
- Custom dark dropdown for generation filter + search

### 4. Profile Modal (z-400)
- Gender avatar silhouettes (blue male, pink female)
- Badges, Born/Died/Father/Spouse grid, lineage, children, siblings
- Two footer buttons: "View in tree" + "View on Globe" (only if member has 📍 location)

### 5. Migration Map (z-500 fullscreen overlay)
- Mapbox GL JS, globe projection, dark-v11 default style
- Faqarsar origin: [74.53, 30.22]
- 2 merged routes: Pilibanga [74.08, 29.44] (red, 11 families) + Haryana [76.5, 29.15] (cyan, 1)
- 3-layer lines: glow (blur) + core (solid) + white center highlight
- Traveling animated dots along curved bezier paths
- GeoJSON destination circles (stable on zoom, click for popup)
- Labels: FAQARSAR (gold), PILIBANGA (red)
- Auto-spinning globe (200s/revolution, stops on user interaction)
- Search bar, HUD stats panel, close button
- Style switcher: Satellite / Dark (default) / Terrain
- Mapbox token configured in index.html

### Migration Map Enhancements
**Bundle/Ribbon Effect**: Pilibanga route displays as a unified ribbon containing 11 colored strands (one per family member), with names distributed along the path.

**Fixed Issues**:
- Migration lines now render correctly on initial map load (removed redundant isStyleLoaded() guard)
- Globe rotation stops permanently on any user interaction (click, zoom, pan, scroll)
- Style switching (Dark/Satellite/Terrain) properly redraws all layers

## Data Schema
```json
{
  "id": "p1", "firstName": "Baba", "middleName": "Singha", "lastName": "Singh",
  "gender": "male", "birth": "", "death": "", "spouse": "",
  "parents": [], "children": ["p2"],
  "notes": "📍 Faqarsar, Punjab", "gurmukhi": "ਬਾਬਾ ਸਿੰਘਾ"
}
```

### Notes conventions
- Locations: "📍 Faqarsar, Punjab" (381) / "📍 Pilibanga, Rajasthan" (11) / "📍 Haryana" (1) / "📍 Kheowali" (1)
- Faqarsar, Punjab hidden on tree nodes, shown on profiles/modals
- Aliases: 25 mapped to Gurmukhi (Shotu→ਸ਼ੋਟੂ etc.)
- Titles: Chairman, Doctor, Paathi, Sarpanch 1983-1993
- p1 = "Baba Singha Singh" (firstName: "Baba")
- Gurmukhi fixes: ਮਿੱਤ, ਛਿੰਦਰਪਾਲ, ਗੰਡਾ, ਕੁੰਢਾ, ਫਕਰਸਰ

## Key Functions
| Function | Purpose |
|---|---|
| openTree/closeTree | Tree overlay |
| openProfiles/closeProfiles | Profiles overlay |
| openMap/closeMap | Migration map overlay |
| openModal/closeModal | Profile modal |
| toggleLang() | Switch en/pa |
| flyToPerson(id) | Cinematic zoom (desktop) / instant (mobile) |
| flyFromProfile(id) | Close modal → open map → fly to location |
| mapDrawAllLines() | Draw 2 merged migration routes |
| mapAnimateDots() | Animate traveling dots along curves |
| setMapStyle(id, btn) | Switch map tiles + redraw |

## CSS tokens
- BG: #0c0b0f | Card: #141218 | Surface: #1a1820
- Gold: rgba(200,170,120) | Red: rgba(180,80,60) | Green: rgba(80,180,120) | Blue: rgba(120,160,200) | Pink: rgba(213,115,138)

## Responsive
- 768px: stacked toolbars, single-col profiles, smaller modal, bottom HUD
- 380px: extra tight, single-col info grid
- Mobile map: no nav controls, smaller markers, lower zoom/pitch on flyTo

## Pending Features (all previewed, not implemented)

### Slideable Profile Cards
- Slide 1: Current modal exactly as-is (unchanged)
- Slide 2: Photos (scrollable gallery + add button) + Documents (clickable cards with emoji, name, date)
- Data schema needs: `photos: [{url, caption}]`, `docs: [{name, url, date}]`

### Sibling Scroller
- Horizontal scroll with 50px circles, dark bg, gold initials
- CSS: .sibling-scroll .sib-card .sib-circle

### Village Street Map
- Leaflet.js, Faqarsar at [30.4890, 74.8570], zoom 16

## Files
- faqarsar.html — Complete website (336KB)
- singh-family.json — Data (394 members)
- FAQARSAR_PROJECT.md — This file
