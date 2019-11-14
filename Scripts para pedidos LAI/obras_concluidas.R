# Vendo quais obras estavam paralisadas que foram retomadas e concluídas

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


obras_concluidas %>%
  group_by(uf, municipio) %>%
  summarise(obras = n()) %>%
  arrange(desc(obras))

x <- obras_concluidas %>%
  filter(municipio == "Brasília") %>%
  select(id, nome)

