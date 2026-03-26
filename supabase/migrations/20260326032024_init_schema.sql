-- ─────────────────────────────────────────────
-- Faqarsar.com — Initial Schema
-- ─────────────────────────────────────────────

-- Members table (mirrors singh-family.json schema)
create table if not exists public.members (
  id            text primary key,           -- e.g. "p1"
  first_name    text,
  middle_name   text,
  last_name     text,
  gender        text check (gender in ('male', 'female', '')),
  birth         text,
  death         text,
  spouse        text,
  parents       text[]  default '{}',
  children      text[]  default '{}',
  notes         text,
  gurmukhi      text,
  created_at    timestamptz default now(),
  updated_at    timestamptz default now()
);

-- Photos table (for modal Slide 2)
create table if not exists public.member_photos (
  id          uuid primary key default gen_random_uuid(),
  member_id   text references public.members(id) on delete cascade,
  url         text not null,
  caption     text,
  storage_path text,
  created_at  timestamptz default now()
);

-- Documents table (for modal Slide 2)
create table if not exists public.member_docs (
  id          uuid primary key default gen_random_uuid(),
  member_id   text references public.members(id) on delete cascade,
  name        text not null,
  emoji       text default '📄',
  url         text,
  storage_path text,
  doc_date    text,
  created_at  timestamptz default now()
);

-- Auto-update updated_at on members
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger members_updated_at
  before update on public.members
  for each row execute function public.set_updated_at();

-- Row Level Security
alter table public.members       enable row level security;
alter table public.member_photos enable row level security;
alter table public.member_docs   enable row level security;

-- Public read access (family tree is public)
create policy "public read members"
  on public.members for select using (true);

create policy "public read photos"
  on public.member_photos for select using (true);

create policy "public read docs"
  on public.member_docs for select using (true);

-- Indexes for common queries
create index if not exists members_parents_idx  on public.members using gin(parents);
create index if not exists members_children_idx on public.members using gin(children);
create index if not exists photos_member_idx    on public.member_photos(member_id);
create index if not exists docs_member_idx      on public.member_docs(member_id);
