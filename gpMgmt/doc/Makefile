# gpMgmt/doc/Makefile

top_builddir = ../..
include $(top_builddir)/src/Makefile.global

SUBDIRS= gpconfigs

$(recurse)

DOCS= gpactivatestandby_help gpaddmirrors_help hdbcheckperf_help \
	gpdeletesystem_help gpexpand_help gpfdist_help \
	gpload_help gpmapreduce_help gpperfmon_install_help hdbpkg_help gpreload_help \
	gpstate_help hdbsys1_help \
	hdbinitsystem_help hdbinitstandby_help hdbscp_help hdbssh_help hdbssh-exkeys_help \
	hdbstart_help hdbstop_help hdbrecoverseg_help hdbconfig_help hdblogfilter_help

installdirs:
	$(MKDIR_P) '$(DESTDIR)$(prefix)/docs/cli_help'

install: installdirs
	for file in $(DOCS); do \
		$(INSTALL_DATA) $$file '$(DESTDIR)$(prefix)/docs/cli_help/'$$file ; \
	done

uninstall:
	for file in $(DOCS); do \
		rm -f '$(DESTDIR)$(prefix)/docs/cli_help/'$$file ; \
	done

