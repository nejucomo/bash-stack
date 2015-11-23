# bash-stack
#
# copyright 2015, Nathan Wilcox, see ./license.txt
#
# Usage:
#
#

function stack-empty {
    if [ $# -eq 1 ]
    then
        local STACK_NAME="$1"
        eval [ "\${#${STACK_NAME}[*]}" -eq 0 ]
    else
        echo 'Usage: stack-empty $STACK_NAME'
        return 2
    fi
}

function stack-length {
    if [ $# -eq 1 ]
    then
        local STACK_NAME="$1"
        eval echo "\${#${STACK_NAME}[*]}"
    else
        echo 'Usage: stack-length $STACK_NAME'
        return 2
    fi
}

function stack-push {
    if [ $# -eq 2 ]
    then
        local STACK_NAME="$1"
        local VALUE="$2"
        eval "${STACK_NAME}[ \${#${STACK_NAME}[*]} ]=\${VALUE}"
    else
        echo 'Usage: push $STACK_NAME $VALUE'
        return 2
    fi
}

function stack-peek {
    if [ $# -eq 1 ]
    then
        local STACK_NAME="$1"
        eval 'echo' "\${${STACK_NAME}[\${#${STACK_NAME}[*]}-1]}"
    else
        echo 'Usage: peek $STACK_NAME'
        return 2
    fi
}


function stack-pop {
    if [ $# -eq 1 ]
    then
        local STACK_NAME="$1"
        eval 'unset' "${STACK_NAME}[\${#${STACK_NAME}[*]}-1]"
    else
        echo 'Usage: pop $STACK_NAME'
        return 2
    fi
}

