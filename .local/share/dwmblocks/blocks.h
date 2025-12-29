//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{" ", "~/.local/scripts/xkblayout", 0, 20},
	{"/ ", "~/.local/scripts/disk", 30, 0},
	{"", "~/.local/scripts/battery", 60, 0},
	{"", "~/.local/scripts/datetime", 5, 0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 3;
