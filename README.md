# PixelPlace - Loja de Jogos Online

Este é um projeto acadêmico para a disciplina de Banco de Dados, focado na criação, gerenciamento e consulta de uma loja virtual de jogos eletrônicos, a "PixelPlace".

O sistema gerencia um catálogo completo de produtos (jogos, expansões, microtransações e assinaturas), usuários, pedidos, promoções e o progresso dos jogadores (horas jogadas e conquistas).

## 🛠️ Tecnologia

* **Banco de Dados:** Oracle SQL
* **Linguagem de Script:** PL/SQL

## 📂 Estrutura de Diretórios

O projeto utiliza uma abordagem híbrida para gerenciamento do banco de dados, combinando migrações evolucionárias (para a estrutura) e scripts de dados (para o povoamento), com uma referência declarativa da arquitetura.

* `/migrations`
    * Contém os scripts de migração de schema. O arquivo `v001__primeira_implantacao.sql` é o script inicial que cria toda a estrutura do banco de dados (todas as tabelas e sequences).
* `/seeds`
    * Contém todos os scripts de povoamento. Cada script é numerado na ordem correta de execução para respeitar as chaves estrangeiras, populando o banco com dados de teste realistas.
* `/tables`
    * Contém a definição declarativa (o "estado final" desejado) de cada tabela em um arquivo `.sql` separado. Serve como uma referência de arquitetura fácil de consultar.
* `/sequences`
    * Contém a definição declarativa de todas as sequences do banco, agrupadas no arquivo `_all_sequences.sql`.

## 🚀 Como Executar

Este projeto é compatível com qualquer ambiente Oracle SQL (incluindo o Oracle Live SQL).

1.  **Criar o Schema:**
    * Execute o script principal de migração para criar todas as tabelas e sequences:
        * `migrations/v001__primeira_implantacao.sql`

2.  **Povoar o Banco:**
    * Execute os scripts da pasta `/seeds` **exatamente na ordem numérica** (de `01_` a `20_`). A ordem é crucial para que as chaves estrangeiras sejam resolvidas corretamente.
