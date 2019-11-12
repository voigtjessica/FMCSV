## SIMEC

**Arquivo "fnde_list.Rdata"**: É uma lista que contém 20 planilhas do SIMEC colhidas entre 2016 e 2019. Cada um dos dataframes contém as informações sobre o andamento das obras de escolas e creches pactuadas. Essa informação é inserida periodicamente pelos entes executores para a garantia dos repasses para a execução da obra.

**Fonte:** [http://simec.mec.gov.br/painelObras/index.php](http://simec.mec.gov.br/painelObras/index.php) 

**Órgão responsável:** FNDE

**Abrangência:** nacional

**Problemas encontrados:** Dados disponíveis sobre as etapas de execução das obras, valores dos repasses, endereços das construções, datas de assinatura de contrato e previsão de entrega são muitas vezes imprecisos ou estão ausentes. Como esses dados também embasam o projeto "Tá de Pé", já realizamos dois estudos sobre esses dados, o primeiro 2m 2017 mais focado nas [inconsistências dos dados do SIMEC](https://www.transparencia.org.br/downloads/publicacoes/RelatorioTadePe23082017.pdf) e outro em 2018 que tratou das [obras com problemas](https://www.transparencia.org.br/downloads/publicacoes/Relat%C3%B3rio_campanha%20TdP_final.pdf) (obras não iniciadas, paralisadas, atrasadas e sem endereço).

### Codebook: 
Nessa planilha foram inseridas algumas informações adicionais que permitem verificar se a obra, no momento da 


| Nome variável      | Descrição   |
| :-------------: |:-------------:|
| id    | Id da obra, gerado pelo FNDE |
| nome| Nome da obra, de acordo com o acordo firmado com o FNDE (pode ser que a escola / creche tenha adotado um outro nome ) |
| situacao | Situação oficial da obra, de acordo com o FNDE (ver abaixo) |
| municipio | Município onde se localiza a obra |
| uf | UF onde se localiza a obra |
| cep | CEP onde se localiza a obra, de acordo com ente executor |
| logradouro | Logradouro onde se localiza a obra , de acordo com ente executor |
| bairro | Bairro onde se localiza a obra , de acordo com ente executor |
|termo_convenio| Termo ou convênio que pactuou a obra. Um convênio pode conter mais de uma obra|
|fim_da_vigencia_termo_convenio | Data para fim da vigência do termo/convênio|
|situacao_do_termo_convenio| Assume dois valores: "Vigente" e "Vencido"|
|percentual_de_execucao| Percentual de execução da obra, de acordo com o ente executor
| data_prevista_de_conclusao_da_obra | Data prevista de conclusão da obra oficial |
|tipo_de_ensino_modalidade| Tipo de ensino que a obra vai atender|
| tipo_do_projeto | Projeto arquitetônico da obra |                   
|tipo_da_obra | Categoria mais geral da obra, assume os seguintes valores "Construção", "Ampliação", "Ampliação/Reforma", "Reforma", "Instalações"|
| classificacao_da_obra | A qual região a obra atende, assume os valores "Urbana", "Rural", "Indigena" e "Quilombo"|
|valor_pactuado_pelo_fnde| Valor (corrente) pactuado com o FNDE para essa obra. Percebemos que esse valor às vezes representa o valor para todo o convênio, e não apenas para a obra descrita naquela linha |
|rede_de_ensino_publico| Rede de ensino público para a qual aquela obra vai atender|
|cnpj| CNPJ do ente executor|
|inscricao_estadual | Inscrição Estadual do ente executor|
|nome_da_entidade| Nome do ente executor|
|razao_social| Razão Social do ente executor|
|email| Email do ente executor|
|sigla| Sigla do ente executor |
|telefone_comercial l| Telefone Comercial do ente executor|
|fax| Fax do ente executor|
|cep_entidade| CEP do ente executor|
|logradouro_entidade | Logradouro do ente executor|
|complemento_entidade| Complemento do endereço do ente executor|
|numero_entidade| Número do endereço do ente executor|
|bairro_entidade| Bairro do endereço do ente executor|
|uf_entidade | UF do ente executor|
|municipio_entidade | Município ente executor|
|modalidade_de_licitacao | Modalidade da licitação da obra. Assume os valores: "Tomada de Preço", "Convite", "Concorrência", "Pregão", "Dispensa", "RDC", "Inexigibilidade"|
|numero_da_licitacao| Número da Licitação|
|homologacao_da_licitacao | Data da homologação da licitação|
|empresa_contratada| Nome da empresa contratada|
|data_de_assinatura_do_contrato| Data em que o contrato com a empresa foi assinado|
|prazo_de_vigencia | Prazo de vigência do contrato entre o ente executor e a empresa|
|data_de_termino_do_contrato| Data de término do contrato entre o ente executor e a empresa|
|valor_do_contrato| Valor do contrato entre o ente executor e a empresa. Assim como no valor pactuado, não está claro se o valor contempla uma ou mais obras|
|valor_pactuado_com_o_fnde| Aparentemente é uma coluna repetida|
|data_da_ultima_vistoria_do_estado_ou_municipio| Informação inserida pelo engenheiro que faz a vistoria|
|situacao_da_vistoria | Em tese, essa coluna deve ser igual a coluna situação|
|obs| Observações feitas pelo técnico responsável pela vistoria ou ente executor|
|total_pago| Total pago do FNDE para o ente executor, também não está claro se diz respeito ao valor por obra ou por convênio|
|percentual_pago| Percentual do valor total pactuado|
|banco| Banco em que foi depoistado o pagto|
|agencia| |
|conta| |
|data| Não está claro se é a data do último depósito ou a data da última atualização|
|saldo_da_conta| |
|saldo_fundos| |
|saldo_da_poupanca| |
|saldo_cdb| | |
|saldo_total| |
|data_arquivo| data em que o arquivo foi gerado (mês e ano)|
|nao_iniciada|Se 1, obra ainda não havia sido iniciada, se 0 a obra já tinha sido iniciada |
|paralisada | Se 1, a obra está paralisada (oficialmente ou não), se 0 a obra não está paralisada|


### Observações

#### Situação

Pode assumir os seguintes valores:

* Concluída
* Inacabada : obra iniciada e que cujo termo/convênio expirou e não foi concluída, pendendo de um novo termo/convênio
* Obra Cancelada: obra não iniciada que não será mais executada (pode ter tido transferência mas não houve uso do dinheiro) 
* Planejamento pelo proponente: fase pré-licitação, de elaboração / escolha do projeto
* Execução: obra com execução normal
* Paralisada: obra iniciada, paralisada e que deverá ser retomada pelo ente executor                  
* Licitação: Obra está sendo licitada
* Contratação: Licitação já foi realizada e o contrato está sendo feito
* Em Reformulação: Quando há interrupção do contrato. Nunca ficou claro se as obras com esse status já teriam sido iniciadas ou se obras não iniciadas também poderiam ter esse status.

#### Paralisada

A coluna `situação` mostra apenas a classificação oficial. Como foi abordado no [relatório da Transparência Brasil em 2017](https://www.transparencia.org.br/downloads/publicacoes/RelatorioTadePe23082017.pdf), o FNDE sobrescreve as informações das obras, o que implica que uma obra que foi iniciada, paralisou e está em um novo processo de licitação, por exemplo, tem sua situação como "Licitação", e não paralisada. 
Com isso em mente, a Transparência Brasil desenvolveu uma definição de paralisada alternativa, que conta:

* Se a obra está paralisada ou inacabada oficialmente
* Se a obra tem percentual de execução diferente de 0 porém seu status (situação) não consta como "Execução"
* Se a obra possui data de assinatura do contrato e seu status (situação) não consta como "Execução"
* Se a obra possui data prevista de conclusão (que só poderia ser estipulada depois da assinatura do contrato) mas seu status consta como "Licitação", "Em Reformulação","Contratação" ou "Planejamento pelo proponente"

A coluna `paralisada` será igual a 1, então, se a obra está paralisada oficialmente ou de acordo com os critérios da Transparência Brasil.

### Não iniciada

A coluna `situação` também não discrimina as obras que possuem termo/convênio mas que nunca sairam do papel. Para verificar as obras não iniciadas, a Transparência Brasil considerou as obras com percentual de execução == 0 e situação diferente de cancelada.

