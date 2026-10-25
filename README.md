# Pesquisas Eleitorais 2026

Painel de pesquisas para Presidente: média diária, institutos, comparação entre pesquisas e pesquisa × resultado oficial.

- **Site:** `index.html`, estático e pronto para GitHub Pages.
- **Banco:** Supabase. O site lê com a chave *publishable*, e as tabelas só permitem leitura pública (RLS).
- **Estrutura do banco:** `supabase/schema.sql`.

## Apuração e Supabase Free

- O placar nacional e os estados são lidos diretamente dos arquivos oficiais do TSE. Esses dados não são copiados para o Supabase.
- O Supabase é usado no painel de apuração apenas pelo chat. A conversa abre por padrão e pode ser fechada pelo visitante.
- A página busca no máximo 60 mensagens e verifica novidades a cada 12 segundos. Em falhas, o intervalo aumenta gradualmente até 60 segundos; em aba oculta, chat fechado ou outra página, as consultas param.
- Rode `supabase/chat.sql` no SQL Editor para criar/atualizar o chat. O script mantém o histórico abaixo de 2.100 mensagens e faz a limpeza a cada 100 inserções, limitando o armazenamento sem depender de cron.

## Atualizar os dados

Na pasta de trabalho, onde ficam `pesquisas_tse.py`, `gerar_base.py`, `enviar_supabase.py` e o `.env` com a chave secreta:

```
python gerar_base.py --perfil     # baixa TSE + PollingData + Poder360 e monta base_site/
python enviar_supabase.py         # recarrega as tabelas no Supabase
```

A chave `service_role`/secreta fica **só** no `.env` local. Nunca vai para este repositório.

## Fontes

TSE (dados abertos: registros, candidatos, resultados, perfil do eleitorado), PollingData (percentuais por candidato) e Poder360 (pesquisas dos últimos dias). Fotos: Ricardo Stuckert/PR e Agência Senado.
