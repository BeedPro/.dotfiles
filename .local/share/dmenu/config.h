/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom */
static int opacity = 0;                     /* -o  option; if 0, then alpha is disabled */
static int caret_width = 2;                 /* -cw option; set default caret width */
static int fuzzy = 1;                       /* -F  option; if 0, dmenu doesn't use fuzzy matching */
static int instant = 0;                     /* -n  option; if 1, selects matching item without the need to press enter */
static int center = 1;                      /* -c  option; if 0, dmenu won't be centered on the screen */
static int min_width = 500;                 /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static char *fonts[] =
{
	"GohuFont 14 Nerd Font:size=12"
};
static char *prompt            = NULL;      /* -p  option; prompt to the left of input field */
static const char *dynamic     = NULL;      /* -dy option; dynamic command to run on input change */
static const char *symbol_1 = "<";
static const char *symbol_2 = ">";

static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeBorder] = { OPAQUE, OPAQUE, OPAQUE },
	[SchemeSelHighlight] = { OPAQUE, baralpha, borderalpha },
	[SchemeNormHighlight] = { OPAQUE, baralpha, borderalpha },
	[SchemeHp] = { OPAQUE, baralpha, borderalpha },
};

static
char *colors[][2] = {
	/*               fg         bg       */
	[SchemeNorm] = { "#cdd6f4", "#1e1e2e" },
	[SchemeSel]  = { "#1e1e2e", "#b4befe" },
	[SchemeOut]  = { "#1e1e2e", "#89b4fa" },
    [SchemeBorder] = { "#000000", "#b4befe" },
	[SchemeSelHighlight]  = { "#313244", "#b4befe" },
	[SchemeNormHighlight] = { "#f9e2af", "#1e1e2e" },
	[SchemeHp]   = { "#cdd6f4", "#313244" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 16;
/* -g option; if nonzero, dmenu uses a grid comprised of columns and lines */
static unsigned int columns    = 0;
static unsigned int lineheight = 0;         /* -h option; minimum height of a menu line     */
static unsigned int min_lineheight = 8;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 1;

