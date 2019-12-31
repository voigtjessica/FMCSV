#Mapa final

library(stringr)
library(data.table)
library(tidyr)
library(dplyr)
library(janitor)
library(readr)
library(googledrive)
library(xlsx)


drive_find(n_max=10) 
#função fix nomes

fix_nomes <- function(x){
  
  x <- str_to_title(x)
  x <- ifelse(grepl("De ", x), gsub( "\\ De ", " de ", x ), x)
  x <- ifelse(grepl("Da ", x), gsub( "\\ Da ", " da ", x ), x)
  x <- ifelse(grepl("Do ", x), gsub( "\\ Do ", " do ", x ), x)
  x <- ifelse(grepl("Dos ", x), gsub( "\\ Dos ", " dos ", x ), x)
  
}



#Mais atual:
load("C:/Users/coliv/Documents/R-Projects/FMCSV/Bancos/fnde_list.Rdata")
obras <- fnde_list[[20]]

ends <- obras %>%
  mutate(nome = fix_nomes(nome),
         endereco = paste(municipio, uf, "Brasil", sep=", "),
         id = as.character(id),
         endereco = gsub("^, ", "", endereco)) %>%
  select(id, nome, endereco)

opids <- obras %>%
  filter(paralisada == 1)

opids <- unique(opids$id)

# setwd("C:/Users/coliv/Documents/R-Projects/FMCSV/arquivos_finais")
# save(opids, file="opids.Rdata")

#obras que rodamos o modelo :
probabilidade <- read_csv("~/R-Projects/FMCSV/arquivos_finais/8-ObrasAPrever-Treino3AnoseMeio.csv")

#Gastos (arquivo do Manoel)

gastos <- read_delim("~/R-Projects/FMCSV/arquivos_finais/arquivo_simulador_apos_join_sem_na.csv", 
                     "\t", escape_double = FALSE, col_types = cols(id = col_character(), 
                                                                   prev_gasto = col_character()), trim_ws = TRUE)
gastosids <- unique(gastos$id)

#restantes:

restantes <- obras %>%
  filter(id %in% opids,
         !id %in% gastosids) %>%
  select(id) %>%
  mutate(prev_gasto = NA,
         probs_15 = NA,
         probs_25 = NA,
         probs_35 = NA)

mapa <- gastos %>%
  distinct(id, .keep_all = TRUE) %>% 
  bind_rows(restantes) %>%
  mutate(probs_15 = gsub(",", "\\.",probs_15),
         probs_25 = gsub(",", "\\.",probs_25),
         probs_35 = gsub(",", "\\.",probs_35),
         probs_15 = as.numeric(probs_15),
         probs_25 = as.numeric(probs_25),
         probs_35 = as.numeric(probs_35),
         camada15 = ifelse(probs_15 > 0.8, "Maior que 80%",
                           ifelse(probs_15 > 0.7, "Maior que 70%",
                                  ifelse(probs_15 > 0.6, "Maior que 60%",
                                         ifelse(probs_15 > 0.5, "Maior que 50%",
                                                "Menor que 50%")))),
         camada25 = ifelse(probs_25 > 0.8, "Maior que 80%",
                           ifelse(probs_25 > 0.7, "Maior que 70%",
                                  ifelse(probs_25 > 0.6, "Maior que 60%",
                                         ifelse(probs_25 > 0.5, "Maior que 50%",
                                                "Menor que 50%")))),
         camada35 = ifelse(probs_35 > 0.8, "Maior que 80%",
                           ifelse(probs_35 > 0.7, "Maior que 70%",
                                  ifelse(probs_35 > 0.6, "Maior que 60%",
                                         ifelse(probs_35 > 0.5, "Maior que 50%",
                                                "Menor que 50%")))),
         camada15 = ifelse(is.na(camada15), "Desconhecido", camada15),
         camada25 = ifelse(is.na(camada25), "Desconhecido", camada25),
         camada35 = ifelse(is.na(camada35), "Desconhecido", camada35),
         probs_15 = round(probs_15,4)*100,
         probs_25 = round(probs_25,4)*100,
         probs_35 = round(probs_35,4)*100,
         probs_15 = paste0(probs_15, "%"),
         probs_25 = paste0(probs_25, "%"),
         probs_35 = paste0(probs_35, "%"),
         probs_15 = ifelse(probs_15 == "NA%", "Desconhecido", probs_15),
         probs_25 = ifelse(probs_25 == "NA%", "Desconhecido", probs_25),
         probs_35 = ifelse(probs_35 == "NA%", "Desconhecido", probs_35),
         prev_gasto =  gsub(",", "\\.",prev_gasto),
         prev_gasto = as.numeric(prev_gasto),
         prev_gasto = ifelse(is.na(prev_gasto), "Desconhecido",
                             paste0("R$ ",round(prev_gasto,0)))) %>%
  left_join(ends)
         

mapa %>%
  group_by(camada35) %>%
  summarise(total = n())

setwd("C:/Users/coliv/Documents/R-Projects/FMCSV/arquivos_finais")  
save(mapa, file="mapa.Rdata")
write.csv(mapa, file="mapa.csv", row.names = FALSE, fileEncoding = "UTF-8")

setwd("C:/Users/coliv/Documents/R-Projects/FMCSV/arquivos_finais/mapa_camadas")

um_ano_e_meio <- mapa %>%
  select(id,nome,endereco, prev_gasto, probs_15, camada15)

names(um_ano_e_meio) <- c("Id da obra", "Nome", "Endereço", "Previsão de gasto",
                          "Probabilidade de conclusão", "Faixa")

write.csv(um_ano_e_meio, file="um_ano_e_meio.csv", row.names = FALSE, fileEncoding = "UTF-8")


dois_anos_e_meio <- mapa %>%
  select(id,nome,endereco, prev_gasto, probs_25, camada25)

names(dois_anos_e_meio) <- c("Id da obra", "Nome", "Endereço", "Previsão de gasto",
                          "Probabilidade de conclusão", "Faixa")

write.csv(dois_anos_e_meio, file="dois_anos_e_meio.csv", row.names = FALSE, fileEncoding = "UTF-8")


tres_anos_e_meio <- mapa %>%
  select(id,nome,endereco, prev_gasto, probs_35, camada35)

names(tres_anos_e_meio) <- c("Id da obra", "Nome", "Endereço", "Previsão de gasto",
                          "Probabilidade de conclusão", "Faixa")

write.csv(tres_anos_e_meio, file="tres_anos_e_meio.csv", row.names = FALSE, fileEncoding = "UTF-8")

setwd("C:/Users/coliv/Documents/R-Projects/FMCSV/arquivos_finais/mapa_camadas/apenas_mais_50")

um_ano_e_meio_mais <- um_ano_e_meio %>%
  filter(!Faixa %in% c("Desconhecido", "Menor que 50%"))

write.csv(um_ano_e_meio_mais, file="um_ano_e_meio_mais.csv", row.names = FALSE, fileEncoding = "UTF-8")


dois_anos_e_meio_mais <- dois_anos_e_meio %>%
  filter(!Faixa %in% c("Desconhecido", "Menor que 50%"))

write.csv(dois_anos_e_meio_mais, file="dois_anos_e_meio_mais.csv", row.names = FALSE, fileEncoding = "UTF-8")



tres_anos_e_meio_mais <- tres_anos_e_meio %>%
  filter(!Faixa %in% c("Desconhecido", "Menor que 50%"))

write.csv(tres_anos_e_meio_mais, file="tres_anos_e_meio_mais.csv", row.names = FALSE, fileEncoding = "UTF-8")

##

x <- mapa %>%
  mutate(prev_gasto = gsub("R\\$ ", "", prev_gasto),
         prev_gasto = as.numeric(prev_gasto))


x %>%
  filter(!camada35 %in% c("Desconhecido", "Menor que 50%")) %>%
  summarise(gasto = sum(prev_gasto))


anexo1 <- mapa %>%
  select(id,nome, endereco, prev_gasto, probs_15, probs_25, probs_35 ) %>%
  mutate(prev_gasto = gsub("R\\$ ", "", prev_gasto),
         prev_gasto = as.numeric(prev_gasto))

setwd("C:/Users/coliv/Documents/R-Projects/FMCSV/arquivos_finais")  
write.xlsx(as.data.frame(anexo1), 
           file="anexo1.xlsx", sheetName="anexo1",
           col.names=TRUE, row.names=FALSE, append=FALSE, showNA=FALSE)

drive_upload(
  "anexo1.xlsx",
  path="~/TB/2019/FMCSV/Relatório/Anexos",
  name = "Anexo 1",
  type = "spreadsheet")
