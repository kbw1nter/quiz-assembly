# 🎯 Quiz Interativo em Assembly MIPS

Este projeto foi desenvolvido como trabalho prático da disciplina **Arquitetura e Organização de Computadores I** no semestre **2024/2**. O objetivo é demonstrar o conhecimento em programação Assembly MIPS através da implementação de um sistema de quiz interativo com controle de tempo e múltiplas tentativas.

## 🚀 Funcionalidades

- ✅ **4 perguntas** de conhecimentos gerais com alternativas múltiplas (a, b, c)
- ⏱️ **Cronômetro individual** para cada pergunta
- 🔄 **Sistema de tentativas** (máximo 3 erros por pergunta)
- 📊 **Relatório final** com acertos, erros e tempo gasto
- 🎮 **Interface de menu** simples e intuitiva
- 📝 **Gabarito completo** exibido ao final

### Pré-requisitos
- **MARS MIPS Simulator** (recomendado: versão 4.5 ou superior)
- Conhecimento básico do simulador MARS

### Execução
1. Abra o **MARS MIPS Simulator**
2. Carregue o arquivo `quiz.asm`
3. Monte o código (F3)
4. Execute o programa (F5)
5. Siga as instruções na tela

### Navegação
```
--- Questionário ---
1. Iniciar    ← Começar o quiz
2. Sair       ← Encerrar programa
```

### Durante o Quiz
- Digite apenas **a**, **b** ou **c** para responder
- Você tem até **3 tentativas** por pergunta
- O tempo é contado automaticamente

## 📚 Perguntas do Quiz

1. **Quantos ossos tem o corpo humano?**
   - a) 206 ✅
   - b) 300
   - c) 150

2. **Em que ano foi descoberto o Brasil?**
   - a) 1492
   - b) 1500 ✅
   - c) 1520

3. **Quantos planetas existem no sistema solar?**
   - a) 9
   - b) 8 ✅
   - c) 10

4. **Em que ano terminou a Segunda Guerra Mundial?**
   - a) 1943
   - b) 1944
   - c) 1945 ✅

## 🛠️ Implementação Técnica

### Conceitos MIPS Utilizados

- **Syscalls**:
  - `4` - Impressão de strings
  - `5` - Leitura de inteiros
  - `8` - Leitura de strings
  - `10` - Encerramento do programa
  - `30` - Obtenção de tempo do sistema

- **Estruturas de Dados**:
  - `.data` - Armazenamento de strings e variáveis
  - `.word` - Array para tempos das perguntas
  - `.space` - Buffer para entrada do usuário

- **Controle de Fluxo**:
  - Loops condicionais (`beq`, `bge`)
  - Saltos incondicionais (`j`, `jal`)
  - Gerenciamento de pilha (`stack`)

- **Operações**:
  - Comparação de caracteres
  - Aritmética básica
  - Manipulação de endereços

## 📊 Exemplo de Saída

```
--- Questionário ---
Você pode errar no máximo 3 vezes por pergunta!
Atenção: Digite apenas a letra da alternativa (a, b ou c)!
1. Iniciar
2. Sair
Escolha uma opção: 1

Quantos ossos tem o corpo humano?
a) 206
b) 300
c) 150
Resposta: a

Correto!

[... outras perguntas ...]

--- Resultados ---
Acertos: 3
Erros: 2

--- Tempo por pergunta ---
Pergunta 1: 2340 ms
Pergunta 2: 1850 ms
Pergunta 3: 3200 ms
Pergunta 4: 1950 ms

Respostas corretas:
1. a) 206 ossos
2. b) 1500
3. b) 8 planetas
4. c) 1945
```

## 📈 Possíveis Melhorias

- [ ] Banco de perguntas aleatórias
- [ ] Níveis de dificuldade
- [ ] Ranking de melhores tempos
- [ ] Interface gráfica simples
- [ ] Suporte a mais alternativas (d, e)
- [ ] Sistema de pontuação ponderado

---

⭐ **Dica**: Para melhor experiência, execute no MARS com a aba "Run I/O" aberta para visualizar a interação completa!
