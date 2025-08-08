.data
menu: .asciiz "\n--- Questionário ---\nVocê pode errar no máximo 3 vezes por pergunta!\nAtenção: Digite apenas a letra da alternativa (a, b ou c)!\n1. Iniciar\n2. Sair\nEscolha uma opção: "

p1: .asciiz "\nQuantos ossos tem o corpo humano?\na) 206\nb) 300\nc) 150\nResposta: "
p2: .asciiz "\nEm que ano foi descoberto o Brasil?\na) 1492\nb) 1500\nc) 1520\nResposta: "
p3: .asciiz "\nQuantos planetas existem no sistema solar?\na) 9\nb) 8\nc) 10\nResposta: "
p4: .asciiz "\nEm que ano terminou a Segunda Guerra Mundial?\na) 1943\nb) 1944\nc) 1945\nResposta: "

correto: .asciiz "\nCorreto!\n"
errado: .asciiz "\nErrado! Tente novamente.\n"
max_tentativas: .asciiz "\nNúmero máximo de tentativas atingido! A resposta correta era: "
fim_quiz: .asciiz "\n--- Resultados ---\n"
acertos_msg: .asciiz "Acertos: "
erros_msg: .asciiz "Erros: "
tempo_msg: .asciiz "\n--- Tempo por pergunta ---\n"
pergunta_tempo: .asciiz "Pergunta "
segundos_msg: .asciiz ": "
segundos_unidade: .asciiz " ms\n"
respostas_certas: .asciiz "\nRespostas corretas:\n1. a) 206 ossos\n2. b) 1500\n3. b) 8 planetas\n4. c) 1945\n"
newline: .asciiz "\n"
letra_a: .asciiz "a"
letra_b: .asciiz "b" 
letra_c: .asciiz "c"
resposta_correta_p1: .asciiz "a\n"
resposta_correta_p2: .asciiz "b\n"
resposta_correta_p3: .asciiz "b\n"
resposta_correta_p4: .asciiz "c\n"

# Array para armazenar tempos (4 perguntas)
tempos: .word 0, 0, 0, 0
buffer_entrada: .space 10

.text
.globl main
main:
    # Exibir menu
    li $v0, 4
    la $a0, menu
    syscall
    
    # Ler opção do menu
    li $v0, 5
    syscall
    
    beq $v0, 2, exit
    
    # Inicializar contadores
    li $t0, 0 # Acertos
    li $t1, 0 # Erros totais
    li $t9, 0 # Índice da pergunta atual
    
    # Primeira pergunta
    li $v0, 4
    la $a0, p1
    syscall
    la $a1, resposta_correta_p1
    jal fazer_pergunta
    
    # Segunda pergunta
    addi $t9, $t9, 1
    li $v0, 4
    la $a0, p2
    syscall
    la $a1, resposta_correta_p2
    jal fazer_pergunta
    
    # Terceira pergunta
    addi $t9, $t9, 1
    li $v0, 4
    la $a0, p3
    syscall
    la $a1, resposta_correta_p3
    jal fazer_pergunta
    
    # Quarta pergunta
    addi $t9, $t9, 1
    li $v0, 4
    la $a0, p4
    syscall
    la $a1, resposta_correta_p4
    jal fazer_pergunta
    
    # Exibir resultados
    jal mostrar_resultados
    j exit

fazer_pergunta:
    # Salvar registradores na pilha
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $a1, 8($sp)
    sw $t9, 4($sp)
    sw $t0, 0($sp)
    
    # Capturar tempo inicial
    li $v0, 30  # syscall para tempo do sistema
    syscall
    move $t6, $a0  # salvar tempo inicial em $t6
    
    li $t2, 0 # Contador de tentativas
    
pergunta_loop:
    # Ler entrada do usuário
    li $v0, 8
    la $a0, buffer_entrada
    li $a1, 10
    syscall
    
    # Comparar resposta
    lw $a1, 8($sp)  # recuperar endereço da resposta correta
    la $t3, buffer_entrada
    
    # Comparar primeiro caractere
    lb $t4, 0($t3)    # caractere digitado
    lb $t5, 0($a1)    # resposta correta
    
    beq $t4, $t5, correto_resp
    
    # Resposta errada
    li $v0, 4
    la $a0, errado
    syscall
    
    addi $t2, $t2, 1 # Incrementa tentativas
    addi $t1, $t1, 1 # Incrementa erros totais
    
    bge $t2, 3, max_tentativas_msg
    j pergunta_loop

max_tentativas_msg:
    li $v0, 4
    la $a0, max_tentativas
    syscall
    
    # Mostrar resposta correta
    li $v0, 4
    lw $a0, 8($sp)
    syscall
    
    j calcular_tempo

correto_resp:
    li $v0, 4
    la $a0, correto
    syscall
    lw $t0, 0($sp)    # recuperar contador de acertos
    addi $t0, $t0, 1  # incrementar acertos
    sw $t0, 0($sp)    # salvar de volta
    
calcular_tempo:
    # Capturar tempo final
    li $v0, 30
    syscall
    
    # Calcular diferença de tempo
    sub $t7, $a0, $t6  # tempo final - tempo inicial
    
    # Salvar tempo no array
    lw $t9, 4($sp)     # recuperar índice da pergunta
    la $t8, tempos
    sll $t9, $t9, 2    # multiplicar por 4 (tamanho de word)
    add $t8, $t8, $t9  # endereço correto no array
    sw $t7, 0($t8)     # salvar tempo
    
    # Restaurar registradores
    lw $t0, 0($sp)
    lw $t9, 4($sp)
    lw $a1, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    
    jr $ra

mostrar_resultados:
    # Salvar $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # Mostrar cabeçalho dos resultados
    li $v0, 4
    la $a0, fim_quiz
    syscall
    
    # Mostrar acertos
    li $v0, 4
    la $a0, acertos_msg
    syscall
    
    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    # Mostrar erros
    li $v0, 4
    la $a0, erros_msg
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    # Mostrar tempos por pergunta
    li $v0, 4
    la $a0, tempo_msg
    syscall
    
    # Loop para mostrar tempos de cada pergunta
    li $t2, 0  # contador
    la $t3, tempos
    
loop_tempos:
    bge $t2, 4, fim_tempos
    
    # Mostrar "Pergunta X:"
    li $v0, 4
    la $a0, pergunta_tempo
    syscall
    
    li $v0, 1
    addi $a0, $t2, 1  # número da pergunta (1-4)
    syscall
    
    li $v0, 4
    la $a0, segundos_msg
    syscall
    
    # Mostrar tempo
    li $v0, 1
    lw $a0, 0($t3)
    syscall
    
    li $v0, 4
    la $a0, segundos_unidade
    syscall
    
    addi $t2, $t2, 1
    addi $t3, $t3, 4
    j loop_tempos
    
fim_tempos:
    # Mostrar respostas corretas
    li $v0, 4
    la $a0, respostas_certas
    syscall
    
    # Restaurar $ra
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

exit:
    li $v0, 10
    syscall