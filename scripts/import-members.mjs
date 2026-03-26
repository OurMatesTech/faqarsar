// scripts/import-members.mjs
// Run: node scripts/import-members.mjs
// Reads singh-family.json and upserts all 394 members into Supabase

import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __dir = dirname(fileURLToPath(import.meta.url));
const raw   = JSON.parse(readFileSync(join(__dir, '../singh-family.json'), 'utf8'));

const SUPABASE_URL  = 'https://rrwutjtgyexwpajerlmt.supabase.co';
const SERVICE_ROLE  = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJyd3V0anRneWV4d3BhamVybG10Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NDQ5NTE0NCwiZXhwIjoyMDkwMDcxMTQ0fQ.FcGHdqnUWD__8Avs_6tx02tBHVST_ygcnlqqGR9gIUo';

const sb = createClient(SUPABASE_URL, SERVICE_ROLE);

const members = Object.values(raw).map(p => ({
  id:          p.id,
  first_name:  p.firstName  || '',
  middle_name: p.middleName || '',
  last_name:   p.lastName   || '',
  gender:      p.gender     || '',
  birth:       p.birth      || '',
  death:       p.death      || '',
  spouse:      p.spouse     || '',
  parents:     p.parents    || [],
  children:    p.children   || [],
  notes:       p.notes      || '',
  gurmukhi:    p.gurmukhi   || '',
}));

console.log(`Importing ${members.length} members…`);

// Batch upsert in chunks of 100
const CHUNK = 100;
for (let i = 0; i < members.length; i += CHUNK) {
  const chunk = members.slice(i, i + CHUNK);
  const { error } = await sb.from('members').upsert(chunk, { onConflict: 'id' });
  if (error) {
    console.error(`Error at chunk ${i}:`, error.message);
    process.exit(1);
  }
  console.log(`  ✓ ${Math.min(i + CHUNK, members.length)} / ${members.length}`);
}

console.log('✅ Import complete!');
