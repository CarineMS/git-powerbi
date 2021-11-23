# Estudo de Caso Cap12

O capítulo 12 utiliza-se da linguagem R por meio da ferramenta RStudio ao longo de cinco tarefas de análise estatística que apresentam:

01) Medidas de Posição;
```
# Definindo a pasta de trabalho
# Substitua o caminho abaixo pela pasta no seu pc

setwd("C:/Users/...")
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
```
02) Medidas de Dispersão;
```
# Definindo a pasta de trabalho
# Substitua o caminho abaixo pela pasta no seu pc
setwd("C:/Users/gsmar/OneDrive/Área de Trabalho/DSA/PowerBI/Cap12")
getwd()

# Carregando o dataset
vendas <- read.csv("vendas.csv", fileEncoding = "windows-1252")

# Resumo dataset
View(vendas)
str(vendas)
summary(vendas$Valor)

# Variância
var(vendas$Valor)

# Desvio Padrão
sd(vendas$Valor)
```

03) Medidas de Posição Relativa. 
``` 
# Definindo a pasta de trabalho
# Substitua o caminho abaixo pela pasta no seu pc
setwd("C:/Users/gsmar/OneDrive/Área de Trabalho/DSA/PowerBI/Cap12")
getwd()

# Carregando o dataset
vendas <- read.csv("vendas.csv", fileEncoding = "windows-1252")

# Resumo dos Dados
head(vendas)
tail(vendas)
View(vendas)

str(vendas)
summary(vendas$Valor)

# Medidas de Tendência Central
summary(vendas$Valor)
summary(vendas[c('Valor','Custo')])

# Explotando variáveis numéricas
mean(vendas$Valor)
median(vendas$Valor)
quantile(vendas$Valor)
quantile(vendas$Valor, probs = c(0.01, 0.99))
quantile(vendas$Valor, seq(from = 0, to = 1, by = 0.2))
IQR(vendas$Valor) # diferença entre q3 e q1
range(vendas$Valor)
summary(vendas$Valor)
diff(range(vendas$Valor))
```
04) Tabelas de Frequência.
```
# Definindo a parta de trabalho
# Substitua o caminho abaixo pela pasta no seu computador
setwd("C:/Users/gsmar/OneDrive/Área de Trabalho/DSA/PowerBI/Cap12")
getwd()

# Carregando os dados
dados <- read.table("usuarios.csv",
                    dec = ",",
                    sep = ",",
                    h = T,
                    fileEncoding = "windows-1252")

# Visualizando e sumarizando os dados
View(dados)
names(dados)
str(dados)
summary(dados$salario)
summary(dados$grau_instrucao)
mean(dados$salario)
mean(dados$grau_instrucao)


# Tabela de Frequências Absolutas
freq <- table(dados$grau_instrucao)
View(freq)

# Tabela de Frequencias Relativas
freq_rel <- prop.table(freq)
View(freq_rel)

# Porcentagem (100 * freq_rel_table)
p_freq_rel <- 100 * prop.table(freq_rel)
View(p_freq_rel)

# Adiciona linhas de total
View(freq)
freq <- c(freq, sum(freq))
View(freq)
names(freq)[4] <- "Total"
View(freq)

# Tabela final como todos os valores

# Calculos de frequencia relativa e frequencia proporcional
freq_rel <- c(freq_rel, sum(freq_rel))
p_freq_rel <- c(p_freq_rel, sum(p_freq_rel))

# Tabela Final com todos os valores
tabela_final <- cbind(freq,
                      freq_rel = round(freq_rel, digits = 2))
View(tabela_final)
```
05) Gráficos.
```
# Graficos em R - BarPlot, Pie Chart, Line Chart, Scatter Plot, Histograms e Treemap
# http://www.r-graph-gallery.com/

# Mais detalhes no curso visualização e design de dashboards
# https://www.datascienceacademy.com.br/pages/todos-os-cursos-dsa

# Definindo a parsta de trabalho
setwd("C:/Users/gsmar/OneDrive/Área de Trabalho/DSA/PowerBI/Cap12")
getwd()

# Dados
vetor_total_resultados = c(3, 12, 5, 18, 45)
names(vetor_total_resultados) = c("A", "B", "C", "D", "E")
vetor_total_resultados

#### Barplot ####

barplot(vetor_total_resultados)
barplot(vetor_total_resultados, col = c(1,2,3,4,5))
png("barplot.png", width = 480, height = 480 )
barplot(vetor_total_resultados,
        col = rgb(0.5, 0.1, 0.6, 0.6),
        xlab = "Categorias",
        ylab = "Valores",
        main = "Barplot em R", 
        ylim = c(0,60) )
dev.off()

# Ggplot2 
library(ggplot2)
View(mtcars)

# Barplot
ggplot(mtcars, aes(x = as.factor(cyl) )) + 
  geom_bar()

ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl) )) +  
  geom_bar( ) +
  scale_fill_manual(values = c("red", "green", "blue"))

# Criando dados dummy (fictÃcios)
dados = data.frame(group = c("A ","B ","C ","D ") , value = c(33,62,56,67))
View(dados)

# Barplot
ggplot(dados, aes(x = group, y = value ,fill = group )) + 
  geom_bar(width = 0.85, stat = "identity")


##### Pie Chart ##### 

fatias <- c(4, 12, 14, 16, 8)
paises <- c("Brasil", "Estados Unidos", "Alemanha", "Reino Unido", "Espanha")
?pie
pie(fatias, labels = paises, main = "Leitura de Livros Por Pessoa/Ano")

# Pie Chart 3D
install.packages("plotrix")
library(plotrix)

fatias <- c(4, 12, 14, 16, 8)
paises <- c("Brasil", "Estados Unidos", "Alemanha", "Reino Unido", "Espanha")
?pie3D
pie3D(fatias, labels = paises, explode = 0.1, main = "Leitura de Livros Por Pessoa/Ano")


##### Line Chart ##### 

# Dados
carros <- c(1, 3, 6, 4, 9)
caminhoes <- c(2, 5, 4, 5, 12)

# Plot
plot(carros, type = "o", col = "blue", ylim = c(0,12))

lines(caminhoes, type = "o", pch = 22, lty = 2, col = "red")

title(main = "Produção de Veículos", col.main = "gray", font.main = 4)


##### Boxplot ##### 

library(ggplot2)
View(mpg)

# Plot
ggplot(mpg, aes(x = reorder(class, hwy), y = hwy, fill = class)) + 
  geom_boxplot() +
  xlab("class") +
  theme(legend.position = "none")


##### Scatter Plot ##### 

library(ggplot2)
data = data.frame(cond = rep(c("condition_1", "condition_2"), each=10), 
                  my_x = 1:100 + rnorm(100,sd=9), my_y = 1:100 + rnorm(100,sd=16))

View(data)

ggplot(data, aes(x=my_x, y=my_y)) + 
  geom_point(shape=1)

# Adiciona linha de regressão
ggplot(data, aes(x=my_x, y=my_y)) +    
  geom_point(shape=1) +  
  geom_smooth(method = lm , color="red", se=FALSE) 

# Adiciona smooth
ggplot(data, aes(x=my_x, y=my_y)) +    
  geom_point(shape=1) +  
  geom_smooth(method=lm , color="red", se=TRUE)  


##### Treemap #####

install.packages("treemap")
library(treemap)

# Dados
grupo = c(rep("grupo-1",4), rep("grupo-2",2), rep("grupo-3",3))
subgrupo = paste("subgroup", c(1,2,3,4,1,2,1,2,3), sep = "-")
valor = c(13,5,22,12,11,7,3,1,23)
dados = data.frame(grupo, subgrupo, valor)
View(dados)

# Labels
treemap(dados, 
        index = c("grupo", "subgrupo"),     
        vSize = "valor", 
        type = "index",
        fontsize.labels = c(15,12),               
        fontcolor.labels = c("white", "orange"),    
        fontface.labels = c(2,1),                 
        bg.labels = 220,             
        align.labels = list(c("center", "center"), c("right", "bottom")),                                  
        overlap.labels = 0.5,           
        inflate.labels = F)


# Customizando
treemap(dados, 
        index = c("grupo", "subgrupo"), 
        vSize = "valor", 
        type = "index",
        border.col = c("black", "white"),          
        border.lwds = c(7,2))


##### Histograma #####

# Gerando valores para x
x <- mtcars$mpg 

# Criando o histograma
?hist
h <- hist(x, 
          breaks = 10, 
          col = "red", 
          xlab = "Milhas Por Galão", 
          main = "Histograma com Curva de Distribuição") 

# Customizando o histograma
xfit <- seq(min(x), max(x), length = 40) 
yfit <- dnorm(xfit, mean = mean(x), sd = sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col = "blue", lwd = 2)

# Usando o ggplot2
library(ggplot2)

# dataset
dados = data.frame(value = rnorm(10000))
View(dados)

# Tamanho das colunas
ggplot(dados, aes(x=value)) + 
  geom_histogram(binwidth = 0.05)

# Cor uniforme
ggplot(dados, aes(x=value)) + 
  geom_histogram(binwidth = 0.2, color="white", fill=rgb(0.2,0.7,0.1,0.4) ) 

# Cor proporcional
ggplot(dados, aes(x=value)) + 
  geom_histogram(binwidth = 0.2, aes(fill = ..count..) )
```
