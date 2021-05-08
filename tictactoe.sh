#!/bin/sh

BOARD_ARR=()

reset () {
    BOARD_ARR=(0 1 2 3 4 5 6 7 8)
}

draw() {
    clear
    echo "\t${BOARD_ARR[0]}\t|\t${BOARD_ARR[1]}\t|\t${BOARD_ARR[2]}\n"
    echo "------------------------------------------------\n"
    echo "\t${BOARD_ARR[3]}\t|\t${BOARD_ARR[4]}\t|\t${BOARD_ARR[5]}\n"
    echo "------------------------------------------------\n"
    echo "\t${BOARD_ARR[6]}\t|\t${BOARD_ARR[7]}\t|\t${BOARD_ARR[8]}\n"
    check_winner "X"
    if [[ $? -eq 1 ]]
    then
        echo "You Win"
        exit
    fi

    check_winner "Y"
    if [[ $? -eq 1 ]]
    then
        echo "Computer Win"
        exit
    fi
}

check_winner() {
    if [[ "${BOARD_ARR[0]}" == $1 ]] && [[ "${BOARD_ARR[1]}" == $1 ]] && [[ "${BOARD_ARR[2]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD_ARR[3]}" == $1 ]] && [[ "${BOARD_ARR[4]}" == $1 ]] && [[ "${BOARD_ARR[5]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD_ARR[6]}" == $1 ]] && [[ "${BOARD_ARR[7]}" == $1 ]] && [[ "${BOARD_ARR[8]}" == $1 ]] ; then return 1; fi

    if [[ "${BOARD_ARR[0]}" == $1 ]] && [[ "${BOARD_ARR[3]}" == $1 ]] && [[ "${BOARD_ARR[6]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD_ARR[1]}" == $1 ]] && [[ "${BOARD_ARR[4]}" == $1 ]] && [[ "${BOARD_ARR[7]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD_ARR[2]}" == $1 ]] && [[ "${BOARD_ARR[5]}" == $1 ]] && [[ "${BOARD_ARR[8]}" == $1 ]] ; then return 1; fi

    if [[ "${BOARD_ARR[0]}" == $1 ]] && [[ "${BOARD_ARR[4]}" == $1 ]] && [[ "${BOARD_ARR[8]}" == $1 ]] ; then return 1; fi
    if [[ "${BOARD_ARR[2]}" == $1 ]] && [[ "${BOARD_ARR[4]}" == $1 ]] && [[ "${BOARD_ARR[6]}" == $1 ]] ; then return 1; fi

    return 0
}

validate_next_move() {
    if [[ "$1" -ge 0 ]] && [[ $1 -le 8 ]] && [[ "${BOARD_ARR[$1]}" != "Y" ]] && [[ "${BOARD_ARR[$1]}" != "X" ]]
    then
        BOARD_ARR[$1]=$2
        return 1
    else
        return 0
    fi
}

computer_move() {
    RND=$(($RANDOM % 8))
    validate_next_move $RND "Y"
    local RES=$?
    if [[ $RES -eq 0 ]]
    then
        computer_move
    else
        draw
        user_input
    fi
}

user_input() {
    echo "What is your next move?"
    read NEXT_MOVE
    validate_next_move $NEXT_MOVE "X"
    local RES=$?
    if [[ $RES -eq 0 ]]
    then
        echo "Wrong"
        user_input
    else
        draw
        computer_move
    fi
}

reset
draw
user_input
