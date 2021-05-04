#! /bin/bash

function _diary
{
	local word opts
	COMPREPLY=()
	word="${COMP_WORDS[COMP_CWORD]}"
	opts="add backup config delete help stats trash"
	COMPREPLY=( $(compgen -W "${opts}" -- ${word}) )
}
complete -F _diary diary