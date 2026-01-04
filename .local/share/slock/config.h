/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nogroup"; // use "nobody" for arch

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#cdd6f4",     /* after initialization */
	[INPUT] =  "#cba6f7",   /* during input */
	[FAILED] = "#f38ba8",   /* wrong password */
	[CAPS] =   "#eba0ac",       /* CapsLock on */
};

/* default message */
static const char * message = "";

/* text color */
static const char * text_color = "#cdd6f4";

/* text size (must be a valid size) */
static const char * font_name = "6x13";

static const char * background_image = "/tmp/wallpaper.jpg";

/* insert grid pattern with scale 1:1, the size can be changed with logosize */
static const int logosize = 50;
static const int logow = 12;   /* grid width and height for right center alignment*/
static const int logoh = 6;

static XRectangle rectangles[] = {
   /* x    y   w   h */
   { 0,    3,  1,  3 },
   { 1,    3,  2,  1 },
   { 0,    5,  8,  1 },
   { 3,    0,  1,  5 },
   { 5,    3,  1,  2 },
   { 7,    3,  1,  2 },
   { 8,    3,  4,  1 },
   { 9,    4,  1,  2 },
   { 11,   4,  1,  2 },
};

/* lock screen opacity */
static const float alpha = 1.0;

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;

/* length of time (seconds) until */
static const int timeoffset = 60;

/* should [command] be run only once? */
static const int runonce = 0;

/* command to be run after [time] has passed */
static const char *command = "";

/* Enable blur */
// #define BLUR
/* Set blur radius */
// static const int blurRadius = 8;
/* Enable Pixelation */
//#define PIXELATION
/* Set pixelation radius */
//static const int pixelSize = 8;

