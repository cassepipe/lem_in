/*#include <stdio.h>*/
#include <unistd.h>

const char ant_ascii_art[] =
"\\(\")/\n"
"-( )-\n"
"/(_)\\\n"
;

void print_ant() {
	write(STDOUT_FILENO, ant_ascii_art, sizeof(ant_ascii_art) - 1);
}

int main() {
	print_ant();
}


