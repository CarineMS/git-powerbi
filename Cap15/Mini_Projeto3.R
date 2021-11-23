#*************************************************************************
#
#                           Data Science Academy
#                              Mini-Projeto 3
#                         Inadimplência de Clientes 
#                Análise Exploratória e Limpeza dos Dados
#

#                           Carine Madeira Soares
#*************************************************************************

# Pasta de trabalho
setwd("C:/Users")
getwd()

# Pacotes instalações
install.packages("Amelia")
install.packages("caret")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("reshape")
install.packages("randomForest")
install.packages("e1071")

# Carregando os pacotes
library(Amelia)
library(ggplot2)
library(caret)
library(reshape)
library(randomForest)
library(dplyr)
library(e1071)

# Carregando o dataset
# Fonte: https://archive.ics.uci.edu/ml/datasets/default+of+credit+card+clients
dados_clientes <- read.csv("dados/dataset.csv")

# Visualizando os dados e sua estrutura
View(dados_clientes)
dim(dados_clientes)
str(dados_clientes)
summary(dados_clientes)

########### Análise Exploratoria, Limpeza e Transformação ###########


# Removendo a primeira coluna ID
dados_clientes$ID <- NULL

# Renomeando a coluna de classe
colnames(dados_clientes)[24] <- "inadimplente"
colnames(dados_clientes)

# Verificando e removendo valores ausentes
sapply(dados_clientes, function(x) sum(is.na(x)))
missmap(dados_clientes, main = "Valores Missing Observados")
dados_clientes <- na.omit(dados_clientes)

# Mudando categorias
colnames(dados_clientes)
colnames(dados_clientes)[2] <- "Genero"
colnames(dados_clientes)[3] <- "Escolaridade"
colnames(dados_clientes)[4] <- "Estado_Civil"
colnames(dados_clientes)[5] <- "Idade"
colnames(dados_clientes)
View(dados_clientes)

# Correção de erro
# colnames(dados_clientes)[23] <- "PAY_AMT6"
# colnames(dados_clientes)


# Genero
View(dados_clientes$Genero)
str(dados_clientes$Genero)
summary(dados_clientes$Genero)
dados_clientes$Genero <- cut(dados_clientes$Genero,
                             c(0,1,2),
                             labels = c("Masculino",
                                        "Feminino"))
View(dados_clientes$Genero)
str(dados_clientes$Genero)
summary(dados_clientes$Genero)

# Escolaridade
str(dados_clientes$Escolaridade)
summary(dados_clientes$Escolaridade)
dados_clientes$Escolaridade <- cut(dados_clientes$Escolaridade,
                                   c(0,1,2,3,4),
                                   labels = c("Pos Graduado",
                                              "Graduado",
                                              "Ensino Médio",
                                              "Outros"))
View(dados_clientes$Escolaridade)
str(dados_clientes$Escolaridade)
summary(dados_clientes$Escolaridade)

# Estado civil
str(dados_clientes$Estado_Civil)
summary(dados_clientes$Estado_Civil)
dados_clientes$Estado_Civil <- cut(dados_clientes$Estado_Civil,
                                   c(-1,0,1,2,3),
                                   labels = c("Unknown",
                                              "Married",
                                              "Single",
                                              "Others"))
View(dados_clientes$Estado_Civil)
str(dados_clientes$Estado_Civil)
summary(dados_clientes$Estado_Civil)

# Idade
# Convertendo variável para o tipo fator com faixa etária
str(dados_clientes$Idade)
summary(dados_clientes$Idade)
#?hist
hist(dados_clientes$Idade)
dados_clientes$Idade <- cut(dados_clientes$Idade,
                            c(0,30,50,100),
                            labels = c("Jovem",
                                       "Adulto",
                                       "Idoso"))
View(dados_clientes$Idade)
str(dados_clientes$Idade)
summary(dados_clientes$Idade)
View(dados_clientes)

# Historico de Pagamento para tipo fator
dados_clientes$PAY_0 <- as.factor(dados_clientes$PAY_0)
dados_clientes$PAY_2 <- as.factor(dados_clientes$PAY_2)
dados_clientes$PAY_3 <- as.factor(dados_clientes$PAY_3)
dados_clientes$PAY_4 <- as.factor(dados_clientes$PAY_4)
dados_clientes$PAY_5 <- as.factor(dados_clientes$PAY_5)
dados_clientes$PAY_6 <- as.factor(dados_clientes$PAY_6)

# Dataset após as conversões
str(dados_clientes)
sapply(dados_clientes, function(x) sum(is.na(x)))
missmap(dados_clientes, main = "Valores Missing Observados")
dados_clientes <- na.omit(dados_clientes)
missmap(dados_clientes, main = "Valores Missing Observados")
dim(dados_clientes)

# Alterando a variavel dependente para o tipo fator
str(dados_clientes$inadimplente)
colnames(dados_clientes)
dados_clientes$inadimplente <- as.factor(dados_clientes$inadimplente)
str(dados_clientes$inadimplente)

# Total de inadimplentes versus não inadimplente
table(dados_clientes$inadimplente)

# Porcentagens entre classes
prop.table(table(dados_clientes$inadimplente))

# Distribuição usando ggplot2
qplot(inadimplente, data = dados_clientes, geom = "bar") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Set seed
set.seed(12345)

# Amstragem estratificada
# Seleciona as linhas de acordo com a variável inadimplente como strata
# ?creatDataPartition
indice <- createDataPartition(dados_clientes$inadimplente, p=0.75, list = FALSE)
dim(indice)

