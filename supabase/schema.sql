-- Gerado por enviar_supabase.py --schema. Rode no Supabase: SQL Editor > New query.
-- Recria as tabelas (apaga os dados; depois rode: python enviar_supabase.py).

drop table if exists public.pesquisas cascade;
create table public.pesquisas (
  id bigint generated always as identity primary key,
  registro text,
  uf text,
  abrangencia text,
  cargos text,
  p_presidente boolean,
  p_governador boolean,
  p_senador boolean,
  p_dep_federal boolean,
  p_dep_estadual boolean,
  instituto_tse text,
  razao_social text,
  cnpj text,
  pesquisa_propria boolean,
  data_registro text,
  inicio_campo text,
  fim_campo text,
  divulgacao text,
  entrevistas bigint,
  valor_rs double precision,
  estatistico text,
  modo_coleta text,
  metodologia text,
  plano_amostral text,
  sistema_controle text,
  info_municipios text,
  amostra_homens double precision,
  amostra_mulheres double precision,
  amostra_idade text,
  amostra_escolaridade text,
  amostra_renda text,
  tem_resultado boolean,
  contratante text
);
alter table public.pesquisas enable row level security;
create policy "leitura publica" on public.pesquisas for select to anon, authenticated using (true);
create index on public.pesquisas (registro);
create index on public.pesquisas (cnpj);
create index on public.pesquisas (uf);

drop table if exists public.amostra cascade;
create table public.amostra (
  id bigint generated always as identity primary key,
  registro text,
  dimensao text,
  faixa text,
  pct double precision
);
alter table public.amostra enable row level security;
create policy "leitura publica" on public.amostra for select to anon, authenticated using (true);
create index on public.amostra (registro);

drop table if exists public.resultados cascade;
create table public.resultados (
  id bigint generated always as identity primary key,
  registro text,
  uf_recorte text,
  turno bigint,
  cenario_id bigint,
  cenario text,
  instituto text,
  data_campo text,
  modo text,
  entrevistas bigint,
  confianca text,
  candidato text,
  voto_total double precision,
  voto_valido double precision,
  fonte text,
  fonte_dado text,
  erro_pp double precision,
  partido text
);
alter table public.resultados enable row level security;
create policy "leitura publica" on public.resultados for select to anon, authenticated using (true);
create index on public.resultados (registro);
create index on public.resultados (uf_recorte, turno);
create index on public.resultados (instituto);
create index on public.resultados (candidato);

drop table if exists public.cenarios cascade;
create table public.cenarios (
  id bigint generated always as identity primary key,
  registro text,
  uf_recorte text,
  turno bigint,
  cenario_id bigint,
  cenario text,
  instituto text,
  data_campo text,
  modo text,
  entrevistas bigint,
  erro_pp double precision,
  n_candidatos bigint,
  nao_valido_pct double precision,
  soma_validos double precision,
  lider text,
  lider_validos double precision,
  segundo text,
  segundo_validos double precision,
  vantagem_pp double precision,
  empate_tecnico boolean,
  cenario_principal boolean
);
alter table public.cenarios enable row level security;
create policy "leitura publica" on public.cenarios for select to anon, authenticated using (true);
create index on public.cenarios (registro);
create index on public.cenarios (uf_recorte, turno);

drop table if exists public.media cascade;
create table public.media (
  id bigint generated always as identity primary key,
  turno bigint,
  data text,
  candidato text,
  media_validos double precision,
  n_institutos bigint
);
alter table public.media enable row level security;
create policy "leitura publica" on public.media for select to anon, authenticated using (true);
create index on public.media (turno, data);

drop table if exists public.candidatos cascade;
create table public.candidatos (
  id bigint generated always as identity primary key,
  nr_turno text,
  ds_cargo text,
  sg_uf text,
  sg_ue text,
  nr_candidato text,
  nm_candidato text,
  nm_urna_candidato text,
  sg_partido text,
  nm_partido text,
  nm_coligacao text,
  ds_composicao_coligacao text,
  ds_genero text,
  dt_nascimento text,
  ds_grau_instrucao text,
  ds_cor_raca text,
  ds_ocupacao text,
  ds_situacao_candidatura text,
  ds_sit_tot_turno text,
  nome_pesquisa text
);
alter table public.candidatos enable row level security;
create policy "leitura publica" on public.candidatos for select to anon, authenticated using (true);
create index on public.candidatos (ds_cargo, sg_ue);

drop table if exists public.institutos cascade;
create table public.institutos (
  id bigint generated always as identity primary key,
  instituto text,
  instituto_tse text,
  cnpj text,
  registros bigint,
  reg_presidente bigint,
  reg_governador bigint,
  reg_senador bigint,
  ufs text,
  primeira_divulgacao text,
  ultima_divulgacao text,
  amostra_media double precision,
  valor_total_rs double precision,
  modo_principal text,
  pesquisas_com_resultado bigint
);
alter table public.institutos enable row level security;
create policy "leitura publica" on public.institutos for select to anon, authenticated using (true);

drop table if exists public.resultado_oficial cascade;
create table public.resultado_oficial (
  id bigint generated always as identity primary key,
  nr_turno text,
  ds_cargo text,
  abrangencia text,
  nr_partido text,
  sg_partido text,
  nm_urna_candidato text,
  nome_pesquisa text,
  votos bigint,
  pct_validos double precision
);
alter table public.resultado_oficial enable row level security;
create policy "leitura publica" on public.resultado_oficial for select to anon, authenticated using (true);

drop table if exists public.resultado_municipio cascade;
create table public.resultado_municipio (
  id bigint generated always as identity primary key,
  nr_turno text,
  ds_cargo text,
  sg_uf text,
  sg_ue text,
  cd_municipio text,
  nm_municipio text,
  nr_partido text,
  sg_partido text,
  votos bigint,
  nm_urna_candidato text,
  nome_pesquisa text,
  pct_validos double precision
);
alter table public.resultado_municipio enable row level security;
create policy "leitura publica" on public.resultado_municipio for select to anon, authenticated using (true);
create index on public.resultado_municipio (cd_municipio);
create index on public.resultado_municipio (ds_cargo, sg_uf);

drop table if exists public.comparecimento_municipio cascade;
create table public.comparecimento_municipio (
  id bigint generated always as identity primary key,
  nr_turno text,
  ds_cargo text,
  sg_uf text,
  sg_ue text,
  cd_municipio text,
  nm_municipio text,
  qt_aptos bigint,
  qt_comparecimento bigint,
  qt_abstencoes bigint,
  qt_total_votos_validos bigint,
  qt_votos_brancos bigint,
  qt_total_votos_nulos bigint,
  pct_abstencao double precision
);
alter table public.comparecimento_municipio enable row level security;
create policy "leitura publica" on public.comparecimento_municipio for select to anon, authenticated using (true);
create index on public.comparecimento_municipio (cd_municipio);

drop table if exists public.perfil_eleitorado_idade cascade;
create table public.perfil_eleitorado_idade (
  id bigint generated always as identity primary key,
  sg_uf text,
  cd_municipio text,
  nm_municipio text,
  ds_genero text,
  ds_faixa_etaria text,
  eleitores bigint
);
alter table public.perfil_eleitorado_idade enable row level security;
create policy "leitura publica" on public.perfil_eleitorado_idade for select to anon, authenticated using (true);
create index on public.perfil_eleitorado_idade (cd_municipio);

drop table if exists public.perfil_eleitorado_escolaridade cascade;
create table public.perfil_eleitorado_escolaridade (
  id bigint generated always as identity primary key,
  sg_uf text,
  cd_municipio text,
  nm_municipio text,
  ds_grau_escolaridade text,
  eleitores bigint
);
alter table public.perfil_eleitorado_escolaridade enable row level security;
create policy "leitura publica" on public.perfil_eleitorado_escolaridade for select to anon, authenticated using (true);
create index on public.perfil_eleitorado_escolaridade (cd_municipio);

drop table if exists public.perfil_eleitorado_raca cascade;
create table public.perfil_eleitorado_raca (
  id bigint generated always as identity primary key,
  sg_uf text,
  cd_municipio text,
  nm_municipio text,
  ds_raca_cor text,
  eleitores bigint
);
alter table public.perfil_eleitorado_raca enable row level security;
create policy "leitura publica" on public.perfil_eleitorado_raca for select to anon, authenticated using (true);
create index on public.perfil_eleitorado_raca (cd_municipio);

-- Limpa uma tabela antes de recarregar. So o service_role pode chamar.
create or replace function public.limpar_tabela(tabela text) returns void
language plpgsql security definer set search_path = public as $$
begin
  execute format('truncate table public.%I restart identity', tabela);
end $$;
revoke execute on function public.limpar_tabela(text) from public, anon, authenticated;
grant execute on function public.limpar_tabela(text) to service_role;

notify pgrst, 'reload schema';
