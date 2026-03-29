/**
 * Replaces `const raw = { ... };` in index.html with minified singh-family.json.
 * Run from repo root: node scripts/sync-raw-to-index.js
 */
const fs = require('fs');
const path = require('path');

const root = path.join(__dirname, '..');
const htmlPath = path.join(root, 'index.html');
const jsonPath = path.join(root, 'singh-family.json');

const data = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));
const minified = JSON.stringify(data);
let html = fs.readFileSync(htmlPath, 'utf8');

const marker = 'const raw = ';
const start = html.indexOf(marker);
if (start === -1) throw new Error('const raw = not found in index.html');

let i = start + marker.length;
while (html[i] !== '{') i++;
let depth = 0;
let j = i;
for (; j < html.length; j++) {
  const c = html[j];
  if (c === '{') depth++;
  else if (c === '}') {
    depth--;
    if (depth === 0) {
      j++;
      break;
    }
  }
}

const newHtml = html.slice(0, start + marker.length) + minified + html.slice(j);
fs.writeFileSync(htmlPath, newHtml);
console.log('Synced singh-family.json -> index.html const raw (' + minified.length + ' chars)');
