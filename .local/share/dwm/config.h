/* See LICENSE file for copyright and license details. */

/* Helper macros for spawning commands */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define CMD(...)   { .v = (const char*[]){ __VA_ARGS__, NULL } }

/* appearance */
static const unsigned int borderpx       = 1;   /* border pixel of windows */
static const unsigned int snap           = 32;  /* snap pixel */
static const unsigned int gappih         = 0;   /* horiz inner gap between windows */
static const unsigned int gappiv         = 0;   /* vert inner gap between windows */
static const unsigned int gappoh         = 0;   /* horiz outer gap between windows and screen edge */
static const unsigned int gappov         = 0;   /* vert outer gap between windows and screen edge */
static const int smartgaps_fact          = 1;   /* gap factor when there is only one client; 0 = no gaps, 3 = 3x outer gaps */
static const int smartborders            = 0;   /* border factor when there is only one client; 0 = no border, 1 = border */
static const char autostartblocksh[]     = "../autostart_blocking.sh";
static const char autostartsh[]          = "../autostart.sh";
static const char dwmdir[]               = "dwm";
static const char localshare[]           = ".local/share";
static const int showbar                 = 0;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */
/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor) */
static const int statusmon               = -1;
static const unsigned int systrayspacing = 1;   /* systray spacing */
static const int showsystray             = 1;   /* 0 means no systray */

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype              = INDICATOR_TOP_LEFT_SQUARE;
static int tiledindicatortype            = INDICATOR_NONE;
static int floatindicatortype            = INDICATOR_TOP_LEFT_SQUARE;
static int fakefsindicatortype           = INDICATOR_PLUS;
static int floatfakefsindicatortype      = INDICATOR_PLUS_AND_LARGER_SQUARE;
static const char *fonts[]                 = {"GohuFont 14 Nerd Font:size=12"};
static const char dmenufont[]            = "GohuFont 14 Nerd Font:size=12";

static char c000000[]                    = "#000000"; // placeholder value

static char normfgcolor[]                = "#cdd6f4";
static char normbgcolor[]                = "#1e1e2e";
static char normbordercolor[]            = "#313244";
static char normfloatcolor[]             = "#a6e3a1";

static char selfgcolor[]                 = "#1e1e2e";
static char selbgcolor[]                 = "#b4befe";
static char selbordercolor[]             = "#b4befe";
static char selfloatcolor[]              = "#b4befe";

static char titlenormfgcolor[]           = "#cdd6f4";
static char titlenormbgcolor[]           = "#1e1e2e";
static char titlenormbordercolor[]       = "#444444";
static char titlenormfloatcolor[]        = "#f5c2e7";

static char titleselfgcolor[]            = "#1e1e2e";
static char titleselbgcolor[]            = "#b4befe";
static char titleselbordercolor[]        = "#b4befe";
static char titleselfloatcolor[]         = "#b4befe";

static char tagsnormfgcolor[]            = "#cdd6f4";
static char tagsnormbgcolor[]            = "#1e1e2e";
static char tagsnormbordercolor[]        = "#444444";
static char tagsnormfloatcolor[]         = "#f5c2e7";

static char tagsselfgcolor[]             = "#1e1e2e";
static char tagsselbgcolor[]             = "#b4befe";
static char tagsselbordercolor[]         = "#b4befe";
static char tagsselfloatcolor[]          = "#b4befe";

static char hidnormfgcolor[]             = "#45475a";
static char hidselfgcolor[]              = "#585b70";
static char hidnormbgcolor[]             = "#1e1e2e";
static char hidselbgcolor[]              = "#1e1e2e";

static char urgfgcolor[]                 = "#cdd6f4";
static char urgbgcolor[]                 = "#1e1e2e";
static char urgbordercolor[]             = "#f38ba8";
static char urgfloatcolor[]              = "#f5c2e7";

static char *colors[][ColCount] = {
	/*                       fg                bg                border                float */
	[SchemeNorm]         = { normfgcolor,      normbgcolor,      normbordercolor,      normfloatcolor },
	[SchemeSel]          = { selfgcolor,       selbgcolor,       selbordercolor,       selfloatcolor },
	[SchemeTitleNorm]    = { titlenormfgcolor, titlenormbgcolor, titlenormbordercolor, titlenormfloatcolor },
	[SchemeTitleSel]     = { titleselfgcolor,  titleselbgcolor,  titleselbordercolor,  titleselfloatcolor },
	[SchemeTagsNorm]     = { tagsnormfgcolor,  tagsnormbgcolor,  tagsnormbordercolor,  tagsnormfloatcolor },
	[SchemeTagsSel]      = { tagsselfgcolor,   tagsselbgcolor,   tagsselbordercolor,   tagsselfloatcolor },
	[SchemeHidNorm]      = { hidnormfgcolor,   hidnormbgcolor,   c000000,              c000000 },
	[SchemeHidSel]       = { hidselfgcolor,    hidselbgcolor,    c000000,              c000000 },
	[SchemeUrg]          = { urgfgcolor,       urgbgcolor,       urgbordercolor,       urgfloatcolor },
};

const char *scratchpadcmd[] = {"st", "-c", "scratchpad", "-g", "160x42","-e", "sesh", "connect", "scratchpad", NULL };
static Sp scratchpads[] = {
   /* name        cmd  */
   {"scratchpad", scratchpadcmd},
};

/* Tags
 * In a traditional dwm the number of tags in use can be changed simply by changing the number
 * of strings in the tags array. This build does things a bit different which has some added
 * benefits. If you need to change the number of tags here then change the NUMTAGS macro in dwm.c.
 *
 * Examples:
 *
 *  1) static char *tagicons[][NUMTAGS*2] = {
 *         [DEFAULT_TAGS] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I" },
 *     }
 *
 *  2) static char *tagicons[][1] = {
 *         [DEFAULT_TAGS] = { "•" },
 *     }
 *
 * The first example would result in the tags on the first monitor to be 1 through 9, while the
 * tags for the second monitor would be named A through I. A third monitor would start again at
 * 1 through 9 while the tags on a fourth monitor would also be named A through I. Note the tags
 * count of NUMTAGS*2 in the array initialiser which defines how many tag text / icon exists in
 * the array. This can be changed to *3 to add separate icons for a third monitor.
 *
 * For the second example each tag would be represented as a bullet point. Both cases work the
 * same from a technical standpoint - the icon index is derived from the tag index and the monitor
 * index. If the icon index is is greater than the number of tag icons then it will wrap around
 * until it an icon matches. Similarly if there are two tag icons then it would alternate between
 * them. This works seamlessly with alternative tags and alttagsdecoration patches.
 */
static char *tagicons[][NUMTAGS] =
{
	[DEFAULT_TAGS]        = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
	[ALTERNATIVE_TAGS]    = { "A", "B", "C", "D", "E", "F", "G", "H", "I" },
	[ALT_TAGS_DECORATION] = { "<1>", "<2>", "<3>", "<4>", "<5>", "<6>", "<7>", "<8>", "<9>" },
};

/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields depending on
 * the patches you enable.
 */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *	WM_WINDOW_ROLE(STRING) = role
	 *	_NET_WM_WINDOW_TYPE(ATOM) = wintype
	 */
	RULE(.wintype = WTYPE "DIALOG", .isfloating = 1)
	RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
	RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1)
	RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)
	RULE(.class = "obs", .tags = 1 << 5)
	RULE(.class = "discord", .tags = 1 << 6)
	RULE(.class = "Beeper", .tags = 1 << 6, .monitor = 0)
	RULE(.class = "KeePassXC", .tags = 1 << 7, .monitor = 0)
    RULE(.class = "thunderbird-esr", .tags = 1 << 8, .monitor = 0)
    RULE(.class = "eu.betterbird.Betterbird", .tags = 1 << 8, .monitor = 0)
	RULE(.title = "floating", .isfloating = 1)
	RULE(.class = "floating", .isfloating = 1)
	RULE(.instance = "floating", .isfloating = 1)
	RULE(.title = "pulsemixer", .isfloating = 1)
	RULE(.class = "scratchpad", .tags = SPTAG(0), .isfloating = 1)
};

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor   bar    alignment         widthfunc                 drawfunc                clickfunc                hoverfunc                name */
	{ -1,        0,     BAR_ALIGN_LEFT,   width_tags,               draw_tags,              click_tags,              hover_tags,              "tags" },
	{  0,        0,     BAR_ALIGN_RIGHT,  width_systray,            draw_systray,           click_systray,           NULL,                    "systray" },
	{ -1,        0,     BAR_ALIGN_LEFT,   width_ltsymbol,           draw_ltsymbol,          click_ltsymbol,          NULL,                    "layout" },
	{ statusmon, 0,     BAR_ALIGN_RIGHT,  width_status,             draw_status,            click_statuscmd,         NULL,                    "status" },
	{ -1,        0,     BAR_ALIGN_NONE,   width_wintitle,           draw_wintitle,          click_wintitle,          NULL,                    "wintitle" },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "[D]",      deck },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {
	"menu_run",
	"-m", dmenumon,
	"-fn", dmenufont,
	"-nb", normbgcolor,
	"-nf", normfgcolor,
	"-sb", selbgcolor,
	"-sf", selfgcolor,
	NULL
};
static const char *tmuxcmd[]  = { "st","-e", "sesh", "connect", "home", NULL };
static const char *lockcmd[]  = { "slock", NULL };
static const char *browsercmd[]  = { "zen", NULL };
static const char *privatebrowsercmd[]  = { "zen", "--private-window", NULL };
static const char *filescmd[]  = { "st", "-e", "yazi", NULL };
static const char *agendacmd[]  = { "st", "-e", "nvim", "-c", ":Org agenda", NULL };
static const char *notescmd[]  = { "st", "-e", "nvim", "-c", ":Org capture", NULL };

static const char *powercmd[] = { "/bin/sh", "-c", "~/.local/scripts/powermenu.sh", NULL };
static const char *killmenucmd[] = { "/bin/sh", "-c", "~/.local/scripts/killmenu.sh", NULL };

static const char *volupcmd[]   = { "/bin/sh", "-c", "~/.local/scripts/volume up", NULL };
static const char *volmutecmd[] = { "/bin/sh", "-c", "~/.local/scripts/volume mute", NULL };
static const char *voldowncmd[] = { "/bin/sh", "-c", "~/.local/scripts/volume down", NULL };

static const char *brightupcmd[] = { "/bin/sh", "-c", "~/.local/scripts/brightness up", NULL };
static const char *brightdowncmd[] = { "/bin/sh", "-c", "~/.local/scripts/brightness down", NULL };
static const char *audiotogglecmd[] = { "/bin/sh", "-c", "playerctl play-pause", NULL };
static const char *audionextcmd[] = { "/bin/sh", "-c", "playerctl next", NULL };

static const char *screenselcmd[] = { "/bin/sh", "-c", "~/.local/scripts/screenshot.sh selection", NULL };
static const char *screenwincmd[] = { "/bin/sh", "-c", "~/.local/scripts/screenshot.sh window", NULL };
static const char *screensrncmd[] = { "/bin/sh", "-c", "~/.local/scripts/screenshot.sh screen", NULL };

static const char *xswapkbcmd[] = { "/bin/sh", "-c", "~/.local/scripts/xswapkb", NULL };

/* This defines the name of the executable that handles the bar (used for signalling purposes) */
#define STATUSBAR "dwmblocks"

static const Key keys[] = {
	/* modifier                     key            function                argument */
	{ MODKEY,                       XK_space,      spawn,                  {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,     spawn,                  {.v = tmuxcmd } },
	{ MODKEY,                       XK_w,          spawn,                  {.v = browsercmd } },
	{ MODKEY|ShiftMask,             XK_w,          spawn,                  {.v = privatebrowsercmd } },
	{ MODKEY,                       XK_o,          spawn,                  {.v = agendacmd } },
	{ MODKEY|ShiftMask,             XK_o,          spawn,                  {.v = notescmd } },
	{ MODKEY,                       XK_e,          spawn,                  {.v = filescmd } },
	{ MODKEY,                       XK_x,          spawn,                  {.v = lockcmd } },
	{ MODKEY|ShiftMask,             XK_x,          spawn,                  {.v = powercmd} },
	{ MODKEY|ShiftMask,             XK_c,          spawn,                  {.v = killmenucmd} },
	{ 0,         XF86XK_AudioRaiseVolume,          spawn,                  {.v = volupcmd} },
	{ 0,                XF86XK_AudioMute,          spawn,                  {.v = volmutecmd} },
	{ 0,         XF86XK_AudioLowerVolume,          spawn,                  {.v = voldowncmd} },
	{ 0,          XF86XK_MonBrightnessUp,          spawn,                  {.v = brightupcmd} },
	{ 0,        XF86XK_MonBrightnessDown,          spawn,                  {.v = brightdowncmd} },
	{ 0,                XF86XK_AudioPlay,          spawn,                  {.v = audiotogglecmd} },
	{ 0,                XF86XK_AudioNext,          spawn,                  {.v = audionextcmd} },
	{ 0,                            XK_Print,      spawn,                  {.v = screenselcmd} },
	{ MODKEY,                       XK_Print,      spawn,                  {.v = screenwincmd} },
	{ MODKEY|ShiftMask,             XK_Print,      spawn,                  {.v = screensrncmd} },
	{ MODKEY,                       XK_b,          togglebar,              {0} },
	{ MODKEY,                       XK_j,          focusstack,             {.i = +1 } },
	{ MODKEY,                       XK_k,          focusstack,             {.i = -1 } },
	{ MODKEY,                       XK_i,          incnmaster,             {.i = +1 } },
	{ MODKEY,                       XK_d,          incnmaster,             {.i = -1 } },
	{ MODKEY|ControlMask,           XK_h,          setmfact,               {.f = -0.05} },
	{ MODKEY|ControlMask,           XK_l,          setmfact,               {.f = +0.05} },
	{ MODKEY|ControlMask,           XK_k,          setcfact,               {.f = +0.25} },
	{ MODKEY|ControlMask,           XK_j,          setcfact,               {.f = -0.25} },
	{ MODKEY|ControlMask,           XK_0,          setcfact,               {0} },
	{ MODKEY|ShiftMask,             XK_Return,     zoom,                   {0} },
	{ MODKEY,                       XK_g,          togglegaps,             {0} },
	{ MODKEY,                       XK_Tab,        view,                   {0} },
	{ MODKEY,                       XK_c,          killclient,             {0} },
	{ MODKEY|Mod1Mask,              XK_r,          quit,                   {1} },
	{ MODKEY,                       XK_t,          setlayout,              {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,          setlayout,              {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,          setlayout,              {.v = &layouts[2]} },
	{ MODKEY,                       XK_s,          setlayout,              {.v = &layouts[3]} },
	{ MODKEY|ShiftMask,             XK_f,          togglefloating,         {0} },
	{ MODKEY,                       XK_n,          togglescratch,          {.ui = 0 } },
	{ 0,                            XK_F11,        fullscreen,             {0} },
	{ MODKEY,                       XK_F11,        togglefakefullscreen,   {0} },
	{ MODKEY,                       XK_F12,        spawn,                  {.v = xswapkbcmd} },
	{ MODKEY,                       XK_0,          view,                   {.ui = ~SPTAGMASK } },
	{ MODKEY|ShiftMask,             XK_0,          tag,                    {.ui = ~SPTAGMASK } },
	{ MODKEY,                       XK_comma,      focusmon,               {.i = -1 } },
	{ MODKEY,                       XK_period,     focusmon,               {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,      tagmon,                 {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,     tagmon,                 {.i = +1 } },
	TAGKEYS(                        XK_1,                                  0)
	TAGKEYS(                        XK_2,                                  1)
	TAGKEYS(                        XK_3,                                  2)
	TAGKEYS(                        XK_4,                                  3)
	TAGKEYS(                        XK_5,                                  4)
	TAGKEYS(                        XK_6,                                  5)
	TAGKEYS(                        XK_7,                                  6)
	TAGKEYS(                        XK_8,                                  7)
	TAGKEYS(                        XK_9,                                  8)
	// { MODKEY|ControlMask,           XK_comma,      cyclelayout,            {.i = -1 } },
	// { MODKEY|ControlMask,           XK_period,     cyclelayout,            {.i = +1 } },
	// { MODKEY|ShiftMask,             XK_j,          movestack,              {.i = +1 } },
	// { MODKEY|ShiftMask,             XK_k,          movestack,              {.i = -1 } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask           button          function        argument */
	{ ClkLtSymbol,          0,                   Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,                   Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,                   Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,                   Button3,        showhideclient, {0} },
	{ ClkWinTitle,          0,                   Button2,        zoom,           {0} },
	{ ClkStatusText,        0,                   Button1,        sigstatusbar,   {.i = 1 } },
	{ ClkStatusText,        0,                   Button2,        sigstatusbar,   {.i = 2 } },
	{ ClkStatusText,        0,                   Button3,        sigstatusbar,   {.i = 3 } },
	{ ClkClientWin,         MODKEY,              Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,              Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,              Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,                   Button1,        view,           {0} },
	{ ClkTagBar,            0,                   Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,              Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,              Button3,        toggletag,      {0} },
};

