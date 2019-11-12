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
    mutate(data_arquivo = data_arq[i])
  
  fnde_list[[i]] <- obras
  
}

setwd("C:/Users/coliv/Documents/R-Projects/FMCSV/Bancos")
save(fnde_list, file="fnde_list.Rdata")




