static int enableattachbelow = 0;

void
attachx(Client *c)
{
  if (enableattachbelow == 0) {
    attach(c);
    return;
  }
	Client *at;

	if (c->idx > 0) { /* then the client has a designated position in the client list */
		for (at = c->mon->clients; at; at = at->next) {
			if (c->idx < at->idx) {
				c->next = at;
				c->mon->clients = c;
				return;
			} else if (at->idx <= c->idx && (!at->next || c->idx <= at->next->idx)) {
				c->next = at->next;
				at->next = c;
				return;
			}
		}
	}

	if (!(c->mon->sel == NULL || c->mon->sel == c || c->mon->sel->isfloating)) {
		c->next = c->mon->sel->next;
		c->mon->sel->next = c;
		return;
	}
	attach(c); // master (default)
}

