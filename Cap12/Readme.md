# Estudo de Caso Cap12

O capítulo 12 utiliza-se da linguagem R por meio da ferramenta RStudio ao longo de cinco tarefas de análise estatística que apresentam:

01) Medidas de Posição;
'''
# Definindo a pasta de trabalho
# Substitua o caminho abaixo pela pasta no seu pc

setwd("C:/Users/gsmar/OneDrive/Área de Trabalho/DSA/PowerBI/Cap12")
getwd()

# Carregando os dados
vendas <- read.csv("Vendas.csv" , fileEncoding =  "windows-1252")

# Resumo do dataset
view(vendas)
str(vendas)
summary(vendas$Valor)
summary(vendas$Custo)

# Media
?mean #help
mean(vendas$Valor)
mean(vendas$Custo)

# Media Ponderada
?weighted.mean
weighted.mean(vendas$Valor, w = vendas$Custo)

# Mediana
median(vendas$Valor)
median(vendas$Custo)

# Moda
# criando a função
moda <- function(v) {
  valor_unico <- unique(v)
  valor_unico[which.max(tabulate(match(v, valor_unico)))]
}

resultado <- moda(vendas$Valor)
print(resultado)

resultado_custo <- moda(vendas$Custo)
print(resultado_custo)

# Criando um gráfico de Média de Valor por Estado com ggplot2
install.packages("ggplot2")
library(ggplot2)

# Cria o gráfico
ggplot(vendas) +
  stat_summary(aes(x = Estado,
                   y = Valor),
               fun = mean,
               geom = "bar",
               fill = "lightpink",
               col = "grey50") +
  labs(title = "Média de Valor Por Estado")
'''
02) Medidas de Dispersão;
03) Medidas de Posição Relativa.
04) Tabelas de Frequência.
05) Gráficos.
