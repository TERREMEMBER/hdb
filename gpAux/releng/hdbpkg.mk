GPMGMT=$(BLD_TOP)/gpMgmt
include $(BLD_TOP)/Makefile.global
INSTLOC= /usr/local/greenplum-db
pg_config_path := $(BLD_TOP)/../src/include/pg_config.h
GP_VERSION_NUM := $(shell grep 'define  *GP_VERSION_NUM' $(pg_config_path) \
        | perl -ne '$$m1=int($$1/10000),$$m2=int(($$1-$$m1*10000)/100) if/^.*?([0-9]+)/;print "$$m1.$$m2$$/"' )

OS=$(word 1,$(subst _, ,$(BLD_ARCH)))
ARCH=$(shell uname -p)
# e.g. 
# # postgis-1.0-1-x86_64.rpm
# # Quite a few assumptions about the semantics of the associated RPM spec file:
# #   * Most importantly, from the use of RPM_NAME below, building postgis-*.rpm will require a postgis.spec,
# #     in the current working directory.
# #   * RPMs must disable AutoReq, as hdbpkg RPM database will lack knowledge of system's libraries
# #   * RPMs with shell commands in hooks must "Provide" /bin/sh, as a hack, for the same reason as the AutoReq issue
# #   * --buildroot must requires an absolute path. I think we cd into %{buildroot} for %install. I think we might also
# #     step into %{buildroot} again for %files. So, relative paths cause "file not found" errors.
# #
# # Sample spec. file
# # Summary:        Geos library
# # License:        LGPL
# # Name:           geos
# # Version:        %{geos_ver}
# # Release:        %{geos_rel}
# # Group:          Development/Tools
# # Prefix:         /temp
# # AutoReq:        no
# # AutoProv:       no
# # Provides:       geos = %{geos_ver}
# #
# # %description
# # The Geos module provides geometric library which is used by PostGIS.
# #
# # %install
# # mkdir -p %{buildroot}/temp/lib
# # cp -rf %{geos_dir}/lib/libgeos* %{buildroot}/temp/lib/
# #
# # %files
# # /temp
RPM_ARGS=$(subst -, ,$*)
RPM_NAME=$(word 1,$(RPM_ARGS))
PWD=$(shell pwd)
%.rpm: 
	rm -rf RPMS BUILD SPECS
	mkdir RPMS BUILD SPECS
	cp $(RPM_NAME).spec SPECS/
	rpmbuild -bb SPECS/$(RPM_NAME).spec --buildroot $(PWD)/BUILD --define '_topdir $(PWD)' --define '__os_install_post \%{nil}' --define 'buildarch $(ARCH)' $(RPM_FLAGS)
	mv RPMS/$(ARCH)/$*.rpm .
	rm -rf RPMS BUILD SPECS

hdbpkg_spec.yml: hdbpkg_spec.yml.in
	cat $< | sed "s/#arch/$(ARCH)/g" | sed "s/#os/$(OS)/g" | sed 's/#gpver/$(GP_VERSION_NUM)/g' > $@

%.hdbpkg: hdbpkg_spec.yml $(MAIN_RPM) $(DEPENDENT_RPMS)
	mkdir -p hdbpkg/deps 
	cp hdbpkg_spec.yml hdbpkg/
	cp $(MAIN_RPM) hdbpkg/ 
ifdef DEPENDENT_RPMS
	for dep_rpm in $(DEPENDENT_RPMS); do \
		cp $${dep_rpm} hdbpkg/deps; \
	done
endif
	source $(INSTLOC)/inhybrid_path.sh && hdbpkg --build hdbpkg 
	rm -rf hdbpkg

clean:
	rm -rf RPMS BUILD SPECS
	rm -rf hdbpkg
	rm -f hdbpkg_spec.yml
ifdef EXTRA_CLEAN
	rm -f $(EXTRA_CLEAN)
endif

install: $(TARGET_GPPKG)
	source $(INSTLOC)/inhybrid_path.sh && hdbpkg -i $(TARGET_GPPKG)

.PHONY: install clean
