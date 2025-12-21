int
noborder(Client *c)
{
	int monocle_layout = 0;

	if (&monocle == c->mon->lt[c->mon->sellt]->arrange)
		monocle_layout = 1;

	if (&deck == c->mon->lt[c->mon->sellt]->arrange && c->mon->nmaster == 0)
		monocle_layout = 1;

	if (!monocle_layout && (nexttiled(c->mon->clients) != c || nexttiled(c->next)))
		return 0;

	if (c->isfloating)
		return 0;

	if (!c->mon->lt[c->mon->sellt]->arrange)
		return 0;

	return 1;
}

