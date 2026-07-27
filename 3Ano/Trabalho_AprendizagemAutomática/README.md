# Aprendizagem Automática - Previsão de Diagnóstico de Tumores Cerebrais

Este projeto foi desenvolvido no âmbito da unidade curricular de **Aprendizagem Automática** da **Universidade de Évora**, no contexto de um desafio de Machine Learning relacionado com a previsão de tumores cerebrais.

## Sobre o Projeto

O objetivo deste trabalho foi construir modelos preditivos capazes de classificar tumores cerebrais como **malignos** ou **benignos**, utilizando um conjunto de dados com informação demográfica e medidas de textura extraídas de imagens de ressonância magnética (ADC).

O projeto foi desenvolvido em **Python**, recorrendo a técnicas de machine learning e a um notebook com a pipeline completa de análise, treino e avaliação dos modelos.

## Objetivo

O principal objetivo foi maximizar a métrica **F1-Score**, de forma a obter previsões robustas e competitivas para o desafio Kaggle.

## Metodologia

O trabalho incluiu as seguintes etapas:

- Carregamento e análise exploratória dos dados;
- Pré-processamento e agregação das informações por paciente;
- Treino de vários modelos de classificação;
- Comparação de desempenho com validação cruzada estratificada;
- Geração de ficheiros de submissão no formato exigido para o desafio.

## Modelos Testados

Foram testados diferentes algoritmos clássicos de machine learning, nomeadamente:

- Regressão Logística;
- Random Forest;
- Support Vector Machine (SVM).

A seleção dos modelos teve em conta o equilíbrio entre desempenho e capacidade de generalização, especialmente devido à dimensão reduzida do conjunto de dados.

## Estrutura do Repositório

- **Notebook_l59119.ipynb**: notebook principal com o desenvolvimento completo do projeto;
- **Samples/**: ficheiros de exemplo e dados de treino/teste utilizados no desafio;
- **Enunciado Trabalho**: Enunciado do trabalho.

## Tecnologias Utilizadas

- Python
- pandas
- NumPy
- scikit-learn
- Jupyter Notebook

## Como Utilizar

1. Abrir o notebook **Notebook_l59119.ipynb** num ambiente com Jupyter;
2. Instalar as dependências necessárias;
3. Executar as células em ordem para reproduzir a análise e gerar as submissões.

## Observações

Este trabalho faz parte do conjunto de projetos académicos da licenciatura e representa uma aplicação prática de Aprendizagem Automática (Machine Learning) a um problema real de classificação.
