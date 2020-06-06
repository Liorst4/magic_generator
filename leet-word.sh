#!/bin/sh

# Generates a random leetspeck word

# TODO: If length is larger than 8, concat a number of words
# TODO: Shellcheck

choose_a_word() {
	# TODO: Default to 8
	grep -E "^(a|b|c|e|f|l|h|s|g|t|q|o){"$1"}\$" /usr/share/dict/american-english | shuf | head -n 1 
}

translate_to_leet_speak() {
	echo "$1" | tr lhsgtqo 1456790
}

print_leet_word() {
	printf '%s -> 0x%s\n' "$1" "$(translate_to_leet_speak "$1")"
}

# TODO: Usage string
print_leet_word "$(choose_a_word "$1")"
