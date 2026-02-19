# DIO_ECOMMERCE_MATERIAIS_ELETRICOS
E-commerce: Projeto Lógico de Banco de Dados (Materiais Elétricos) Este repositório contém o esquema lógico de banco de dados para um sistema de e-commerce focado em materiais elétricos. O projeto foi desenvolvido como parte de um desafio da DIO - Formação SQL Database Specialist para praticar modelagem, normalização e consultas SQL complexas.

# Decisões Técnicas e Evolução do Modelo
O modelo lógico inicial foi concebido no MySQL Workbench utilizando a nomenclatura snake_case. Durante a implementação, identifiquei dificuldades com a extensão dos nomes e erros de sintaxe causados por espaços em branco.
Refino do Script: Tomei a decisão de migrar todo o código para camelCase. Esta mudança melhorou significativamente a legibilidade, facilitou a correção de erros e padronizou os atributos.
Comparação da Evolução
•	Modelo Lógico Inicial: ecommerce.png (Concebido em snake_case).
•	Modelo Lógico Pós-Refino: ecommerceRefino.png (Versão final em camelCase).
________________________________________
# Estrutura do Repositório
Para facilitar a navegação e o teste do projeto, os scripts foram divididos em três arquivos principais:
1.	ecommerceRefinado.sql: Contém o modelo físico (DDL) com a criação de todas as tabelas, definições de tipos de dados e restrições de chaves (Primary e Foreign Keys) utilizando a padronização camelCase.
2.	dadosEcommerce.sql: Script de povoamento (DML) com dados fictícios de materiais elétricos, incluindo clientes (PF/PJ), fornecedores, produtos e simulações de estoque e pedidos.
3.	viewsEcommerce.sql: Conjunto de queries e visões (DQL) criadas para responder às perguntas de negócio, incluindo filtros, agregações com GROUP BY e junções complexas.
________________________________________
# Como rodar o projeto
Para garantir a integridade dos dados e o funcionamento dos relacionamentos, execute os scripts na seguinte ordem:
1.	Execute ecommerceRefinado.sql para criar a estrutura das tabelas.
2.	Execute dadosEcommerce.sql para popular o banco com dados de teste, todos os dados são ficticios, qualquer semelhança com um caso do mundo real é mera coincidencia.
3.	Execute viewsEcommerce.sql para visualizar as análises de negócio e resultados das queries.
