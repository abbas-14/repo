prefix=/usr/local

# files that need mode 755
EXEC_FILES=repo

# files that need mode 644
SCRIPT_FILES+=repo-add
SCRIPT_FILES+=repo-commit
SCRIPT_FILES+=repo-feature
SCRIPT_FILES+=repo-init
SCRIPT_FILES+=repo-merge
SCRIPT_FILES+=repo-release
SCRIPT_FILES+=repo-status
SCRIPT_FILES+=repo-version
SCRIPT_FILES+=repo-checkout
SCRIPT_FILES+=repo-common
SCRIPT_FILES+=repo-hotfix
SCRIPT_FILES+=repo-log
SCRIPT_FILES+=repo-rebase
SCRIPT_FILES+=repo-shFlags
SCRIPT_FILES+=repo-support

all:
	@echo "usage: make install"
	@echo "       make uninstall"

install:
	@test -f gitflow-shFlags || (echo "Run 'git submodule init && git submodule update' first." ; exit 1 )
	install -d -m 0755 $(prefix)/bin
	install -m 0755 $(EXEC_FILES) $(prefix)/bin
	install -m 0644 $(SCRIPT_FILES) $(prefix)/bin

uninstall:
	test -d $(prefix)/bin && \
	cd $(prefix)/bin && \
	rm -f $(EXEC_FILES) $(SCRIPT_FILES)
