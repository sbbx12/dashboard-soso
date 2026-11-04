-- Réparation de la sauvegarde du Carnet. On peut le lancer plusieurs fois sans risque.
create table if not exists public.carnet (user_id uuid not null default auth.uid() references auth.users on delete cascade, key text not null, v jsonb not null, at bigint not null, primary key (user_id, key));
alter table public.carnet enable row level security;
grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.carnet to authenticated;
drop policy if exists "mes donnees" on public.carnet;
create policy "mes donnees" on public.carnet for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
do $$ begin alter publication supabase_realtime add table public.carnet; exception when duplicate_object then null; end $$;
insert into storage.buckets (id, name, public) values ('docs', 'docs', false) on conflict (id) do nothing;
drop policy if exists "mes fichiers" on storage.objects;
create policy "mes fichiers" on storage.objects for all to authenticated using (bucket_id = 'docs' and (storage.foldername(name))[1] = auth.uid()::text) with check (bucket_id = 'docs' and (storage.foldername(name))[1] = auth.uid()::text);
notify pgrst, 'reload schema';
select 'Réparation terminée' as resultat;
