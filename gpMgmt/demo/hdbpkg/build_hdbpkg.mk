hdbpkg: buildhdbpkg
# get GP_MAJORVERSION from makefile in the installed gpdb folder
PGXS := $(shell pg_config --pgxs)
include $(PGXS)

buildhdbpkg:
	cat hdbpkg_spec.yml.in | sed "s/#gpver/$(GP_MAJORVERSION)/" > hdbpkg_spec.yml
	rm hdbpkg_spec.yml.in
	tar czf sample.hdbpkg *
