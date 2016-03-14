# Rock-paper-scissors-lizard-Spock

# The key idea of this program is to equate the strings
# "rock", "paper", "scissors", "lizard", "Spock" to numbers
# as follows:
#
# 0 - rock
# 1 - Spock
# 2 - paper
# 3 - lizard
# 4 - scissors
#
# Rule: scissors cuts paper, paper covers rock, rock crushes lizard,
# lizard poisons Spork, Spork smashes scissors, scissors decapitates lizard,
# lizard eat paper, paper disproves Spock, Spock vaporizes rock,
# and rock crushes scissors.

import random

def rpsls(x, y):
    tmp = (x - y) % 4;
    if tmp <= 2 and tmp > 0:
        print 'Player (' + str(Sequence[x]) + ') wins computer (' + str(Sequence[y]) + ').'
    elif tmp == 0:
        print 'Player (' + str(Sequence[x]) + ') is equal to computer (' + str(Sequence[y]) + ').'
    else:
        print 'Computer (' + str(Sequence[y]) + ') wins player (' + str(Sequence[x]) + ').'


Choice = {'rock':0, 'Spock':1, 'paper':2, 'lizard':3, 'scissors':4}
Sequence = {0:'rock', 1:'Spock', 2:'paper', 3:'lizard', 4:'scissors'}

circle = 5
while circle > 0:
    circle = circle - 1
    player = input()
    if player not in Choice.keys():
        print 'Wrong input!'
        continue

    player_seq = Choice[player]

    computer_seq = random.randint(0, 4)

    rpsls(player_seq, computer_seq)
