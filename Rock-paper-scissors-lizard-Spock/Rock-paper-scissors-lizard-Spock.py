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

def rpsls_with_computer(player):
    '''
    When player wants to play with computer, then generates a random tag.
    '''
    x = choice[player]
    y = random.randint(0, 4)
    tmp = (x - y) % 4;
    if tmp <= 2 and tmp > 0:
        print 'Player (' + str(sequence[x]) + ') wins computer (' + str(sequence[y]) + ').'
    elif tmp == 0:
        print 'Player (' + str(sequence[x]) + ') is equal to computer'
    else:
        print 'Computer (' + str(sequence[y]) + ') wins player (' + str(sequence[x]) + ').'


def rpsls(choice_list):
    '''
    When players play with each other, outputs the winner's index if exits.
    '''
    flag = False
    for i in range(5):
        if choice_list[choice_key[i]] == choice_list[choice_key[(i + 1) % 5]] == '':
            if not choice_list[choice_key[(i - 1) % 5]] == '':
                flag = True
                print 'Player' + ' Player'.join(choice_list[choice_key[(i - 1) % 5]]) + ' win the game.'
                print '(index from 0.)'
                return

    if flag == False:
        print 'No one wins.'
    return


choice = {'rock':0, 'Spock':1, 'paper':2, 'lizard':3, 'scissors':4}
choice_key = choice.keys()
sequence = {0:'rock', 1:'Spock', 2:'paper', 3:'lizard', 4:'scissors'}
choice_list = {'rock':'', 'Spock':'', 'paper':'', 'lizard':'', 'scissors':''}


player_num = int(input('Please input the number of players: '))

if player_num < 1:
    # get a wrong input
    print 'Wrong input'

elif player_num == 1:
    # play with computer
    player = input('Please input your choice: ')
    while player not in choice_key:
        print 'Wrong input! Try again!'
        player = input('Please input your choice: ')

    rpsls_with_computer(player)

else:
    # play with people
    for i in range(player_num):
        player = input('Please input your choice: ')
        while player not in choice_key:
            print 'Wrong input! Try again!'
            player = input('Please input your choice: ')
        choice_list[player] = choice_list[player] + str(i)

    rpsls(choice_list)
