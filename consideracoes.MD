## Considerações sobre as obras

### Obras da metodologia inovadora
As obras da metodologia inovadora tem os seguintes nomes de projetos:

* MI - Escola de Educação Infantil Tipo C
* MI - Escola de Educação Infantil Tipo B

Quando as obras são repactuadas, elas mudam de ID. Solicitei ao FNDE quais foram as obras repactuadas e qual é o ID novo delas.

### Obras paralisadas que foram concluídas
As obras da metodologia inovadora tem os seguintes nomes de projetos:


```{r, warning=FALSE}

library(dplyr)

load("~/R-Projects/FMCSV/Bancos/fnde_list.Rdata")

# Mais antigo

antigo <- fnde_list[[1]]

recente <- fnde_list[[20]] %>%
  filter(situacao == "Concluída" ) %>%
  select(id)

obras_concluidas <- antigo %>%
  filter(paralisada == 1) %>%
  inner_join(recente) %>%
  mutate(nome = gsub("QUADRA ", "", nome)) 

para_em_2016 <- antigo %>%
  filter(paralisada == 1) 

```


Das 1.368 obras paralisadas em 2016, 260 (19%) foram concluídas até o fim de 2019.
