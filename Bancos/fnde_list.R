#montando o arquivo com todas as infos que temos.

library(dplyr)
library(janitor)

setwd("C:/Users/coliv/Documents/R-Projects/FMCSV/Arquivos originais")

nomes <- c( "ID"
            , "Nome"
            , "Situação" 
            , "Município"                                     
            , "UF"                                            
            , "CEP"                                           
            , "Logradouro"                                    
            , "Bairro"                                        
            , "Termo/Convênio"                                
            , "Fim da Vigência Termo/Convênio"                
            , "Situação do Termo/Convênio"                    
            , "Percentual de Execução"                        
            , "Data Prevista de Conclusão da Obra"            
            , "Tipo de ensino / Modalidade"                   
            , "Tipo do Projeto"                               
            , "Tipo da Obra"                                  
            , "Classificação da Obra"                         
            , "Valor Pactuado pelo FNDE"                      
            , "Rede de Ensino Público"                        
            , "CNPJ"                                          
            , "Inscrição Estadual"                            
            , "Nome da Entidade"                              
            , "Razão Social"                                  
            , "Email"                                         
            , "Sigla"                                         
            , "Telefone Comercial"                            
            , "Fax"                                           
            , "CEP Entidade"                                  
            , "Logradouro Entidade"                           
            , "Complemento Entidade"                          
            , "Número Entidade"                               
            , "Bairro Entidade"                               
            , "UF Entidade"                                   
            , "Munícipio Entidade"                            
            , "Modalidade de Licitação"                       
            , "Número da Licitação"                           
            , "Homologação da Licitação"                      
            , "Empresa Contratada"                            
            , "Data de Assinatura do Contrato"                
            , "Prazo de Vigência"                             
            , "Data de Término do Contrato"                   
            , "Valor do Contrato"                             
            , "Valor Pactuado com o FNDE"                     
            , "Data da Última Vistoria do Estado ou Município"
            , "Situação da Vistoria"                          
            , "OBS"                                           
            , "Total Pago"                                    
            , "Percentual Pago"                               
            , "Banco"                                         
            , "Agência"                                       
            , "Conta"                                         
            , "Data"                                          
            , "Saldo da Conta"                                
            , "Saldo Fundos"                                  
            , "Saldo da Poupança"                             
            , "Saldo CDB"                                     
            , "Saldo TOTAL")

obras_esc_creches <- c("Escola de Educação Infantil Tipo B", 
                       "Projeto 1 Convencional", 
                       "Projeto 2 Convencional", 
                       "Escola de Educação Infantil Tipo C", 
                       "MI - Escola de Educação Infantil Tipo B", 
                       "Espaço Educativo - 12 Salas", 
                       "Escola com Projeto elaborado pelo proponente", 
                       "Espaço Educativo - 02 Salas", 
                       "Espaço Educativo - 06 Salas", 
                       "Espaço Educativo - 04 Salas", 
                       "Espaço Educativo - 01 Sala", 
                       "Espaço Educativo - 08 Salas", 
                       "Espaço Educativo - 10 Salas", 
                       "Escola de Educação Infantil Tipo A", 
                       "Escola com projeto elaborado pelo concedente", 
                       "MI - Escola de Educação Infantil Tipo C", 
                       "Projeto Tipo C - Bloco Estrutural", 
                       "Projeto Tipo B - Bloco Estrutural",
                       "Escola Infantil - Tipo B (Projeto Novo)",
                       "Escola Infantil - Tipo C (Projeto Novo)", 
                       "Escola 06 Salas com Quadra - Projeto FNDE",
                       "Escola 04 Salas com Quadra - Projeto FNDE")

fnde_files = list.files()
fnde_files <- fnde_files[-1]

data_arq <- gsub(".csv", "", fnde_files)
data_arq <- gsub("obras_", "", data_arq)

fnde_list <- list()

for(i in 1:length(fnde_files)){
  
  print(fnde_files[i])
  
  obras <- read.csv(fnde_files[i], sep=";", fileEncoding = "UTF-8")
  
  obras[] <- lapply(obras, gsub, pattern=';', replacement='/')
 
  names(obras) <- nomes 
  
  obras <- obras %>%
    clean_names() %>%
    filter(tipo_do_projeto %in% obras_esc_creches) %>%
    mutate(data_arquivo = data_arq[i],
           percentual_de_execucao = as.numeric(percentual_de_execucao),
           nao_iniciada = ifelse( percentual_de_execucao == 0 & !situacao %in%
                                    c("Inacabada","Paralisada", "Obra Cancelada", "Concluída" ), 1, 0),
           paralisada_off = ifelse(situacao %in% c("Inacabada","Paralisada"), 1, 0),
           paralisada_nao_off = if_else(!is.na(data_de_assinatura_do_contrato) & situacao != "Execução" & nao_iniciada == 0|
                                          percentual_de_execucao > 0 & situacao != "Execução"  & nao_iniciada == 0|
                                          !is.na(data_prevista_de_conclusao_da_obra) & nao_iniciada == 0 & 
                                          situacao %in% c("Licitação", "Em Reformulação","Contratação", 
                                                          "Planejamento pelo proponente"), 1 , 0),
           paralisada_nao_off = ifelse(situacao %in% c("Obra Cancelada", "Concluída",
                                                       "Inacabada","Paralisada"), 0, paralisada_nao_off), #retirando concluidas e canceladas
           paralisada = ifelse(paralisada_nao_off == 1 | paralisada_off == 1, 1, 0)) %>%
    select(-c(paralisada_off, paralisada_nao_off))
  
  fnde_list[[i]] <- obras
  
}

setwd("C:/Users/coliv/Documents/R-Projects/FMCSV/Bancos")
save(fnde_list, file="fnde_list.Rdata")




