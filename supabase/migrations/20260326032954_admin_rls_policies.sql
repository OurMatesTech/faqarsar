-- ─────────────────────────────────────────────
-- Admin write policies (authenticated users only)
-- ─────────────────────────────────────────────

-- members: admins can insert/update
create policy "auth insert members"
  on public.members for insert
  to authenticated
  with check (true);

create policy "auth update members"
  on public.members for update
  to authenticated
  using (true);

-- photos: admins can insert/delete
create policy "auth insert photos"
  on public.member_photos for insert
  to authenticated
  with check (true);

create policy "auth delete photos"
  on public.member_photos for delete
  to authenticated
  using (true);

-- docs: admins can insert/delete
create policy "auth insert docs"
  on public.member_docs for insert
  to authenticated
  with check (true);

create policy "auth delete docs"
  on public.member_docs for delete
  to authenticated
  using (true);

-- Storage: allow authenticated users to upload to member-media bucket
insert into storage.buckets (id, name, public)
  values ('member-media', 'member-media', true)
  on conflict (id) do nothing;

create policy "auth upload member-media"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'member-media');

create policy "public read member-media"
  on storage.objects for select
  using (bucket_id = 'member-media');

create policy "auth delete member-media"
  on storage.objects for delete
  to authenticated
  using (bucket_id = 'member-media');
