#include <stdio.h>
#include <stdlib.h>

#define LINHAS 8
#define COLUNAS 8

char azul = 'A';
char vermelho = 'V';
char vazio = ' ';

char tabuleiro[LINHAS][COLUNAS];

// ------------------- FUNÇÕES DESNECESSÁRIAS PARA O MARS --------------------------

// Inicializa a matriz do tabuleiro com espaços vazios 
void inicializarTabuleiro() {
    for (int i = 0; i < LINHAS; i++) {
        for (int j = 0; j < COLUNAS; j++) {
            tabuleiro[i][j] = ' ';
        }
    }
}


// Imprime o tabuleiro na tela (Agora com índices de 0 a 7)
void imprimirTabuleiro() {
    printf("\n");
    for (int i = 0; i < LINHAS; i++) {
        printf("|");
        for (int j = 0; j < COLUNAS; j++) {
            printf(" %c |", tabuleiro[i][j]);
        }
        printf("\n");
    }
    printf("---------------------------------\n");
    printf("  0   1   2   3   4   5   6   7\n\n"); // Índices alterados
}

// ------------------- FUNÇÕES NECESSÁRIAS PARA O MARS --------------------------

// Tenta colocar uma peça na coluna escolhida
int jogarPeca(int coluna, char peca) {
    // Verifica de baixo para cima (simulando a gravidade)
    for (int i = LINHAS - 1; i >= 0; i--) {
        if (tabuleiro[i][coluna] == vazio) {
            tabuleiro[i][coluna] = peca;
            return 1; // Jogada válida
        }
    }
    return 0; // Coluna cheia
}

// Verifica se o jogador atual venceu
int verificarVitoria(char peca) {
    // Verifica Horizontais
    for (int i = 0; i < LINHAS; i++) {
        for (int j = 0; j <= COLUNAS - 4; j++) {
            if (tabuleiro[i][j] == peca && tabuleiro[i][j+1] == peca && 
                tabuleiro[i][j+2] == peca && tabuleiro[i][j+3] == peca)
                return 1;
        }
    }
    // Verifica Verticais
    for (int i = 0; i <= LINHAS - 4; i++) {
        for (int j = 0; j < COLUNAS; j++) {
            if (tabuleiro[i][j] == peca && tabuleiro[i+1][j] == peca && 
                tabuleiro[i+2][j] == peca && tabuleiro[i+3][j] == peca)
                return 1;
        }
    }
    // Verifica Diagonais Principais (\)
    for (int i = 0; i <= LINHAS - 4; i++) {
        for (int j = 0; j <= COLUNAS - 4; j++) {
            if (tabuleiro[i][j] == peca && tabuleiro[i+1][j+1] == peca && 
                tabuleiro[i+2][j+2] == peca && tabuleiro[i+3][j+3] == peca)
                return 1;
        }
    }
    // Verifica Diagonais Secundárias (/)
    for (int i = 3; i < LINHAS; i++) {
        for (int j = 0; j <= COLUNAS - 4; j++) {
            if (tabuleiro[i][j] == peca && tabuleiro[i-1][j+1] == peca && 
                tabuleiro[i-2][j+2] == peca && tabuleiro[i-3][j+3] == peca)
                return 1;
        }
    }
    return 0;
}

// Verifica se o tabuleiro está cheio (Empate)
int verificarEmpate() {
    for (int j = 0; j < COLUNAS; j++) {
        if (tabuleiro[0][j] == ' ') {
            return 0; // Ainda há espaço na linha do topo
        }
    }
    return 1;
}

int main() {
    int turno = 0;
    int coluna;
    char jogadorAtual;
    int vitoria = 0;

    inicializarTabuleiro();

    printf("=== BEM-VINDO AO LIG 4 (8x8) ===\n");
    printf("Jogador 1: 'A' | Jogador 2: 'V'\n");

    while (!vitoria && !verificarEmpate()) {
        imprimirTabuleiro();
        
        jogadorAtual = (turno % 2 == 0) ? 'A' : 'V';
        
        // Pedindo entrada de 0 a 7
        printf("Vez do jogador '%c'. Escolha uma coluna (0-7): ", jogadorAtual);
        
        if (scanf("%d", &coluna) != 1) {
            printf("Entrada invalida! Saindo do jogo.\n");
            return 0;
        }

        // Verifica limites
        if (coluna < 0 || coluna >= COLUNAS) {
            printf("\n=> Coluna invalida! Escolha um numero entre 0 e 7.\n");
            continue;
        }

        // Tenta jogar
        if (jogarPeca(coluna, jogadorAtual)) {
            vitoria = verificarVitoria(jogadorAtual);
            if (!vitoria) {
                turno++;
            }
        } else {
            // Imprime diretamente a coluna sem somar 1
            printf("\n=> A coluna %d esta cheia! Escolha outra.\n", coluna);
        }
    }

    imprimirTabuleiro();

    if (vitoria) {
        printf("\n*** PARABENS! O JOGADOR '%c' VENCEU! ***\n\n", jogadorAtual);
    } else {
        printf("\n*** EMPATE! O TABULEIRO ESTA CHEIO! ***\n\n");
    }

    return 0;
}