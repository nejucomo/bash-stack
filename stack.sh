# stack.sh - A "stack" function providing stack abstraction over bash arrays.
#
# copyright 2015, Nathan Wilcox, see ./license.txt

function stack {
    if [ $# -lt 1 ] || [ "$1" = '--help' ]
    then
        sed 's/^          //' <<________EOF
          Usage:

            stack --help
              Show this help message.

            stack empty S
              Return 0 if stack named S is empty, 1 if not empty.

            stack length S
              Echo the number of elements in the stack named S.

            stack push S V
              Push the value V onto the stack named S.

            stack peek S
              Echo the value on top of the stack S.

            stack pop S
              Remove the top of the stack S, producing no output. Fails
              if S is empty.

          Synopsis:
            Stack operations in bash using bash arrays. stack is a bash
            function which returns 0 on success, 1 for informational false
            (such as for 'stack empty'), and 2 for incorrect usage.

            The stack argument, 'S' above, is a literal name of a
            bash array. You can access that array directly. If you use
            parameter expansion, you get indirection. Eg: 'x=foo; stack
            peek $x' shows you the top of the stack in the bash array
            named "foo".

            This has some strange edge cases. It doesn't seem to work
            well with 'set -u' mode.
________EOF
        return 0
    elif [ "$1" = 'empty' ]
    then
        if [ $# -eq 2 ]
        then
            local STACK_NAME="$2"
            eval [ "\${#${STACK_NAME}[*]}" -eq 0 ]
        else
            echo 'Usage: stack empty $STACK_NAME'
            return 2
        fi
    elif [ "$1" = 'length' ]
    then
        if [ $# -eq 2 ]
        then
            local STACK_NAME="$2"
            eval echo "\${#${STACK_NAME}[*]}"
        else
            echo 'Usage: stack length $STACK_NAME'
            return 2
        fi
    elif [ "$1" = 'push' ]
    then
        if [ $# -eq 3 ]
        then
            local STACK_NAME="$2"
            local VALUE="$3"
            eval "${STACK_NAME}[ \${#${STACK_NAME}[*]} ]=\${VALUE}"
        else
            echo 'Usage: stack push $STACK_NAME $VALUE'
            return 2
        fi
    elif [ "$1" = 'peek' ]
    then
        if [ $# -eq 2 ]
        then
            local STACK_NAME="$2"
            eval 'echo' "\${${STACK_NAME}[\${#${STACK_NAME}[*]}-1]}"
        else
            echo 'Usage: stack peek $STACK_NAME'
            return 2
        fi
    elif [ "$1" = 'pop' ]
    then
        if [ $# -eq 2 ]
        then
            local STACK_NAME="$2"
            eval 'unset' "${STACK_NAME}[\${#${STACK_NAME}[*]}-1]"
        else
            echo 'Usage: stack pop $STACK_NAME'
            return 2
        fi
    else
        echo "Unknown command: $1"
        stack --help
        return 2
    fi
}
