-- Chat da apuração. Pode rodar de novo: não apaga as pesquisas.
-- Supabase: SQL Editor > New query > Run.

create table if not exists public.chat_apuracao (
  id bigint generated always as identity primary key,
  nome text not null,
  texto text not null,
  criado_em timestamptz not null default now(),
  constraint chat_nome_ok check (char_length(btrim(nome)) between 2 and 24),
  constraint chat_texto_ok check (char_length(btrim(texto)) between 1 and 400)
);

alter table public.chat_apuracao enable row level security;

drop policy if exists "ler chat" on public.chat_apuracao;
drop policy if exists "enviar chat" on public.chat_apuracao;
create policy "ler chat" on public.chat_apuracao
  for select to anon, authenticated using (true);
create policy "enviar chat" on public.chat_apuracao
  for insert to anon, authenticated
  with check (
    char_length(btrim(nome)) between 2 and 24
    and char_length(btrim(texto)) between 1 and 400
  );

revoke all on public.chat_apuracao from anon, authenticated;
grant select, insert on public.chat_apuracao to anon, authenticated;
grant usage, select on sequence public.chat_apuracao_id_seq to anon, authenticated;

create index if not exists chat_apuracao_id_idx on public.chat_apuracao (id);
