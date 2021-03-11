# \ <sec:var>
MODULE  = $(notdir $(CURDIR))
OS      = $(shell uname -s)
# / <sec:var>
# \ <sec:dir>
CWD     = $(CURDIR)
TMP     = $(CWD)/tmp
# / <sec:dir>
# \ <sec:tool>
CURL    = curl -L
# / <sec:tool>
# \ <sec:src>
# / <sec:src>
# \ <sec:all>
.PHONY: all
all:
# / <sec:all>
# \ <sec:doc>
.PHONY: doc
doc:
# / <sec:doc>
# \ <sec:install>
.PHONY: install
install: $(OS)_install js doc
	$(MAKE) update
.PHONY: update
update: $(OS)_update
.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt`
# \ <sec:js>
.PHONY: js
js: \
	static/js/bootstrap.min.css static/js/bootstrap.dark.css \
	static/js/bootstrap.min.js static/js/jquery.min.js \
	static/js/html5shiv.min.js static/js/respond.min.js

JQUERY_VER = 3.6.0
static/js/jquery.min.js:
	$(CURL) -o $@ https://cdnjs.cloudflare.com/ajax/libs/jquery/$(JQUERY_VER)/jquery.min.js

BOOTSTRAP_VER = 4.6.0
static/js/bootstrap.min.css: static/js/bootstrap.min.css.map
	$(CURL) -o $@ https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/$(BOOTSTRAP_VER)/css/bootstrap.min.css
static/js/bootstrap.min.css.map:
	$(CURL) -o $@ https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/$(BOOTSTRAP_VER)/css/bootstrap.min.css.map
static/js/bootstrap.dark.css:
	$(CURL) -o $@ https://bootswatch.com/4/darkly/bootstrap.min.css
static/js/bootstrap.min.js: static/js/bootstrap.min.js.map
	$(CURL) -o $@ https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/$(BOOTSTRAP_VER)/js/bootstrap.min.js
static/js/bootstrap.min.js.map:
	$(CURL) -o $@ https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/$(BOOTSTRAP_VER)/js/bootstrap.min.js.map

static/js/html5shiv.min.js:
	$(CURL) -o $@ https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js
static/js/respond.min.js:
	$(CURL) -o $@ https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js
# / <sec:js>
# / <sec:install>
# \ <sec:merge>
MERGE  = Makefile README.md apt.txt .vscode doc tmp static templates
master:
	git push -v
	git checkout $@
	git checkout shadow -- $(MERGE)
shadow:
	git push -v
	git checkout $@
# / <sec:merge>
