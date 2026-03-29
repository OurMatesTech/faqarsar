-- Run in Supabase: SQL Editor → New query → paste → Run.
-- Fixes: "Could not find the table 'public.heritage_site' in the schema cache"

create table if not exists public.heritage_site (
  id uuid primary key default gen_random_uuid(),
  url text not null,
  caption text default '',
  caption_pa text default '',
  year text,
  storage_path text,
  created_at timestamptz not null default now()
);

alter table public.heritage_site enable row level security;

drop policy if exists "heritage_site_select_public" on public.heritage_site;
drop policy if exists "heritage_site_insert_authenticated" on public.heritage_site;
drop policy if exists "heritage_site_delete_authenticated" on public.heritage_site;

create policy "heritage_site_select_public"
  on public.heritage_site for select
  to anon, authenticated
  using (true);

create policy "heritage_site_insert_authenticated"
  on public.heritage_site for insert
  to authenticated
  with check (true);

create policy "heritage_site_delete_authenticated"
  on public.heritage_site for delete
  to authenticated
  using (true);
