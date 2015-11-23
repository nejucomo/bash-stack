#!/bin/bash

set -e

source "$(readlink -f "$(dirname "$0")")/bash-stack.sh"

SCNT=0 # success count
FCNT=0 # failure count

function assert {
    local pass='true'
    eval "$@" || pass='false'

    if [ "$pass" = 'true' ]
    then
        SCNT="$(expr "$SCNT" + 1)"
    else
        FCNT="$(expr "$FCNT" + 1)"
        echo "Assertion failed: $*"
        exit 1
    fi
}


# Just in case these were in the caller's environment:
unset S

assert 'stack empty S'
assert '[ "$(stack length S)" -eq 0 ]'

assert 'stack push S foo'
assert '! stack empty S'
assert '[ "$(stack length S)" -eq 1 ]'
assert '[ "$(stack peek S)" = foo ]'
assert '[ "$(stack peek S)" = foo ]'
assert '[ "$(stack length S)" -eq 1 ]'

assert 'stack push S bar'
assert '! stack empty S'
assert '[ "$(stack peek S)" = bar ]'
assert '[ "$(stack length S)" -eq 2 ]'
assert '[ "$(stack peek S)" = bar ]'
assert '[ "$(stack length S)" -eq 2 ]'

assert 'stack pop S'
assert '! stack empty S'
assert '[ "$(stack length S)" -eq 1 ]'
assert '[ "$(stack peek S)" = foo ]'
assert '[ "$(stack peek S)" = foo ]'
assert '[ "$(stack length S)" -eq 1 ]'

assert 'stack pop S'
assert 'stack empty S'
assert '[ "$(stack length S)" -eq 0 ]'

[ "$FCNT" -gt 0 ] && echo

TOTAL="$(expr "$SCNT" + "$FCNT")"
echo -e "=== Tests: $TOTAL; Successes: $SCNT; Failures: $FCNT ==="

exec [ "$FCNT" -eq 0 ]
