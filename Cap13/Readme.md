# Estudo de Caso Cap13

A linguagem Python foi utilizada em conjunto com o Power BI para a Manipulação de Dados. A definição do problema inclui:

A empresa Zuza Inc coletou dados do ano anterior com diversos atributos de funcionários de todos os setores. O objetivo é estudar a relação desses atributos e o impacto na promoção dos funcionários. Esse trabalho de análise pode ser usado mais tarde para construir modelos de Machine Learning para prever se um colaborador será ou não promovido.

Essas são as perguntas que devem ser respondidas:

01) Qual a Correlação Entre os Atributos dos Funcionários?
02) Qual o Tempo de Serviço da Maioria dos Funcionários?
03) Qual Avaliação do Ano Anterior Foi Mais Comum?
04) Qual a Distribuição das Idades dos Funcionários?
05) Qual o Número de Treinamentos Mais Frequente?
06) Qual a Proporção dos Funcionários Por Canal de Recrutamento?
07) Qual a Relação Entre a Promoção e a Avaliação do Ano Anterior?

# Carregando e Instalando Pacotes
```# Versão da Linguagem Python
from platform import python_version
print('Versão da Linguagem Python Usada Neste Jupyter Notebook:', python_version())
```

```
# Para atualizar um pacote, execute o comando abaixo no terminal ou prompt de comando:
# pip install -U nome_pacote

# Para instalar a versão exata de um pacote, execute o comando abaixo no terminal ou prompt de comando:
# !pip install nome_pacote==versão_desejada

# Depois de instalar ou atualizar o pacote, reinicie o jupyter notebook.

# Instala o pacote watermark. 
# Esse pacote é usado para gravar as versões de outros pacotes usados neste jupyter notebook.
!pip install -q -U watermark
```

```
# Imports
import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import seaborn as sns
import warnings
warnings.filterwarnings("ignore", category=FutureWarning)
```
# Carregando os Dados
```
dadosRH = pd.read_csv('dadosRH.csv')
```

```
dadosRH.head()
```

```
dadosRH.shape
```
# Análise Exploratória, Limpeza e Transformação de Dados
```
dadosRH.isnull().sum()
# soma dos valores nulos dentro da minha tabela dadosRH
```

```
dadosRH.groupby(['educacao']).count()
# o agrupamento não considera os valores ausentes
```

```
sns.countplot(dadosRH['educacao'])
# grafico dos conjuntos de educação
```

```
dadosRH.groupby(['aval_ano_anterior']).count()
# não considera valores ausentes
```

```
sns.countplot(dadosRH['aval_ano_anterior'])
```
# Como alternativa do tratamento de valores ausentes aplica-se a imputação

```
dadosRH['educacao'].fillna(dadosRH['educacao'].mode()[0], inplace = True)
# a função fillna preenche os valores ausentes a partir da moda 'mode()'' dos dados
```

```
dadosRH['aval_ano_anterior'].fillna(dadosRH['aval_ano_anterior'].median(), inplace = True)
# preenche os valores ausentes com o valor da mediana 'median()' dos dados 
```

```
dadosRH.isnull().sum()
# imputação soluciona o problema de valores ausentes
```

```
dadosRH.shape
# nenhum valor foi perdido
```

```
dadosRH.groupby(['educacao']).count()
```

```
dadosRH.groupby(['aval_ano_anterior']).count()
```
# Vamos verificar o balanceamento de classe na variável "promovido". A classe desbalanceada é quando tem-se uma variação muito grande entre classes que pode gerar um modelo de machine learning aprenderia muito mais de uma do que de outra.

```
dadosRH.groupby(['promovido']).count()
```

```
sns.countplot(dadosRH['promovido'])
```

```
df_classe_majoritaria = dadosRH[dadosRH.promovido==0]
df_classe_minoritaria = dadosRH[dadosRH.promovido==1]
# separando as classes majoritária e minoritária
```

```
df_classe_majoritaria.shape
```

```
df_classe_minoritaria.shape
```

```
# Upsample da classe minoritária
from sklearn.utils import resample
df_classe_minoritaria_upsampled = resample(df_classe_minoritaria, 
                                           replace = True,     
                                           n_samples = 50140,   
                                           random_state = 150) 
# balanceamento com a função resample() da classe 0 - tecnica de amostragem. Aumentando a classe minoritária

```

```
dadosRH_balanceados = pd.concat([df_classe_majoritaria, df_classe_minoritaria_upsampled])
# concatenando os dados classe 0 e classe 1
```

```
dadosRH_balanceados.promovido.value_counts()
```

```
dadosRH_balanceados.info()
```

```
sns.countplot(dadosRH_balanceados['promovido'])
```
# Os dados estão balanceados. Vamos salvar o dataset com os dados manipulados. A limpeza foi feita e finalizada.

```
dadosRH_balanceados.to_csv('dadosRH_modificado.csv', encoding = 'utf-8', index = False)
# salvando os dados sem o indice em uma tabela do excel
```

```
dataset = pd.read_csv('dadosRH_modificado.csv')
dataset.head()
```

```
dataset.shape
```
01) Qual a Correlação Entre os Atributos dos Funcionários?
```
import matplotlib.pyplot as plt
import seaborn as sns
corr = dataset.corr() # calculo da correlação
sns.heatmap(corr, cmap = 'YlOrRd', linewidths = 0.1) # mapa de calor
plt.show()
```
02) Qual o Tempo de Serviço da Maioria dos Funcionários?
```
# A relação do tempo de serviço para os funcionários se da pela distribuição do tempo de serviço
import matplotlib.pyplot as plt
import seaborn as sns
sns.distplot(dataset['tempo_servico'], color = 'green') # grafico de distribuição
plt.title('Distribuição do Tempo de Serviço dos Funcionários', fontsize = 15)
plt.xlabel('Tempo de Serviço em Anos', fontsize = 15)
plt.ylabel('Total')
plt.show()
```
03) Qual Avaliação do Ano Anterior Foi Mais Comum?

```
# Faz-se a contagem, ordenação e plot
import matplotlib.pyplot as plt
import seaborn as sns
dataset['aval_ano_anterior'].value_counts().sort_values().plot.bar(color = 'blue', figsize = (10, 5))
plt.title('Distribuição da Avaliação do Ano Anterior dos Funcionários', fontsize = 15)
plt.xlabel('Avaliações', fontsize = 15)
plt.ylabel('Total')
plt.show()
```
04) Qual a Distribuição das Idades dos Funcionários?

```
import matplotlib.pyplot as plt
import seaborn as sns
sns.distplot(dataset['idade'], color = 'magenta')
plt.title('Distribuição da Idade dos Funcionários', fontsize = 15)
plt.xlabel('Idade', fontsize = 15)
plt.ylabel('Total')
plt.show()
```
05) Qual o Número de Treinamentos Mais Frequente?

```
import matplotlib.pyplot as plt
import seaborn as sns
sns.violinplot(dataset['numero_treinamentos'], color = 'red')
plt.title('Número de Treinamentos Feitos Pelos Funcionários', fontsize = 15)
plt.xlabel('Número de Treinamentos', fontsize = 15)
plt.ylabel('Frequência')
plt.show()
```
06) Qual a Proporção dos Funcionários Por Canal de Recrutamento?

```
dataset['canal_recrutamento'].value_counts()

import matplotlib.pyplot as plt
import seaborn as sns
dataset['canal_recrutamento'].value_counts()
fatias = [55375, 42358, 2547]
labels = "Outro", "Outsourcing", "Indicação"
colors = ['purple', 'lime', 'yellow']
explode = [0, 0, 0]
plt.pie(fatias, labels = labels, colors = colors, explode = explode, shadow = True, autopct = "%.2f%%")
plt.title('Percentual de Funcionários Por Canal de Recrutamento', fontsize = 15)
plt.axis('off')
#plt.legend()
plt.show()
```
07) Qual a Relação Entre a Promoção e a Avaliação do Ano Anterior?

```
import matplotlib.pyplot as plt
import seaborn as sns
data = pd.crosstab(dataset['aval_ano_anterior'], dataset['promovido']) # tabela cruzada
data.div(data.sum(1).astype(float), axis = 0).plot(kind = 'bar', 
                                                   stacked = True, 
                                                   figsize = (16, 9), 
                                                   color = ['blue', 'magenta'])
plt.title('Relação Entre Avaliação do Ano Anterior e a Promoção', fontsize = 15)
plt.xlabel('Avaliação do Ano Anterior', fontsize = 15)
plt.legend()
plt.show()
```

