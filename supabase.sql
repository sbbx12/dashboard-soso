create table public.carnet (user_id uuid not null default auth.uid() references auth.users on delete cascade, key text not null, v jsonb not null, at bigint not null, primary key (user_id, key));
alter table public.carnet enable row level security;
create policy "mes donnees" on public.carnet for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
alter publication supabase_realtime add table public.carnet;
insert into storage.buckets (id, name, public) values ('docs', 'docs', false);
create policy "mes fichiers" on storage.objects for all using (bucket_id = 'docs' and (storage.foldername(name))[1] = auth.uid()::text) with check (bucket_id = 'docs' and (storage.foldername(name))[1] = auth.uid()::text);
