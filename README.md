# Pesquisas Eleitorais 2026

Painel de pesquisas para Presidente: média diária, institutos, comparação entre pesquisas e pesquisa × resultado oficial.

- **Site:** `index.html`, estático e pronto para GitHub Pages.
- **Banco:** Supabase. O site lê com a chave *publishable*, e as tabelas só permitem leitura pública (RLS).
- **Estrutura do banco:** `supabase/schema.sql`.

## Atualizar os dados

Na pasta de trabalho, onde ficam `pesquisas_tse.py`, `gerar_base.py`, `enviar_supabase.py` e o `.env` com a chave secreta:

```
python gerar_base.py --perfil     # baixa TSE + PollingData + Poder360 e monta base_site/
python enviar_supabase.py         # recarrega as tabelas no Supabase
```

A chave `service_role`/secreta fica **só** no `.env` local. Nunca vai para este repositório.

## Fontes

TSE (dados abertos: registros, candidatos, resultados, perfil do eleitorado), PollingData (percentuais por candidato) e Poder360 (pesquisas dos últimos dias). Fotos: Ricardo Stuckert/PR e Agência Senado.
