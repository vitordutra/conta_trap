# Tipos de Escolhas

- [Pagar menos](#Pagar%20menos)
- [Pagar a mais](#Pagar%20a%20mais)
- [Não pagar nada](#Não%20pagar%20nada)

## Pagar menos

ID | Ação | Descrição | Limitações
-|-|-|-
PL001 | O jogador poderá pagar de 10% até 50% a menos do seu valor atual. A quantidade deve ser múltipla de 10. | |
PL002 | O jogador poderá pagar de 10% até 50% a menos do seu valor atual. A quantidade deve ser múltipla de 10. | |


## Pagar a mais

## Consequências

ID | Consequência | Descrição | Limitações
-|-|-|-
C000 | **Divisão igualitária** | A quantia que o jogador deixar de pagar será dividida para os demais jogadores. | 
C001 | **Transferência identificada** | A quantia que o jogador deixar de pagar será transferida para um outro jogador específico. | 
C002 | **Transferência não-identificada** | A quantia que o jogador deixar de pagar será transferida para um jogador aleatório. | 
C003 | **Perda de jogada** | O jogador perderá sua próxima jogada. | 
C004 | **Perda total de jogadas** | O jogador perderá todas as suas vezes. | 
C005 | **Tiro pela culatra** | O jogador tem N% de chance do efeito da sua ação será invertido (ex: ao invés de pagar 10% a menos, pagará a 10% mais). | 
C006 | **Amigo oculto** | Se o próximo jogador (aceitar/recusar) sua condição, o efeito da sua ação será invertido.
C007 | **Bem-feitor** | Será garantido que o próximo jogador pague menos.