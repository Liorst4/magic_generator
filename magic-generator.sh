#!/bin/sh

# Generates a random leet speak phrase

choose_a_word() {
	# TODO: Add cache
	grep -hE "^(a|b|c|e|f|l|h|s|g|t|q|o){$1}\$" /usr/share/dict/*english* | shuf | head -n 1
}

MAXIMUM_WORD_LENGTH=4

choose_a_phrase() {
	PHRASE_LENGTH=$1
	COUNTER=0
	while [ "$COUNTER" -lt "$PHRASE_LENGTH" ]; do
		REMAINING_LENGTH=$(("$PHRASE_LENGTH" - "$COUNTER"))
		WORD_LENGTH=$(("$REMAINING_LENGTH" > "$MAXIMUM_WORD_LENGTH" ? "$MAXIMUM_WORD_LENGTH" : "$REMAINING_LENGTH"))
		PHRASE="$PHRASE$(choose_a_word "$WORD_LENGTH") "
		COUNTER=$(("$COUNTER" + "$WORD_LENGTH"))
	done
	echo "$PHRASE"
	# TODO Remove last whitespace
}

translate_to_leet_speak() {
	echo "$1" | tr -d " " | tr lhsgtqo 1456790
}

print_leet_word() {
	printf '%s -> 0x%s\n' "$1" "$(translate_to_leet_speak "$1")"
}

usage() {
	echo "Usage: $0 [-l <NUMBER_OF_DIGITS>]" 1>&2
	exit 1
}

NUMBER_OF_DIGITS=8
while getopts ":l:" o; do
	case "${o}" in
		l)
			export NUMBER_OF_DIGITS="${OPTARG}"
			;;
		*)
			usage
			;;
	esac
done

print_leet_word "$(choose_a_phrase "$NUMBER_OF_DIGITS")"
