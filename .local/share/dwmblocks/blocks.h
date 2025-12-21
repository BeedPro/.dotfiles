//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{" ", "~/.local/scripts/xkblayout", 0, 20},
	{"root ", "~/.local/scripts/disk", 30, 0},
	{"", "~/.local/scripts/battery", 60, 0},
	{"", "~/.local/scripts/brightness", 0, 15},
	{"", "~/.local/scripts/volume", 0, 10},
	{"", "~/.local/scripts/datetime", 5, 0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " :: ";
static unsigned int delimLen = 5;
