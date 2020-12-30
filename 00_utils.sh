#!/bin/bash

available_envs=(poc sdlc cust)

function checkEnv () {
    for w in ${available_envs[*]}
    do
        if [ "$w" == "$1" ] 
        then
            workspace=$w
            break
        fi
    done;
}
