top_builddir = ../..
include $(top_builddir)/src/Makefile.global

# do nothing if global config is not enabled
ifeq ($(enable_gpperfmon),no)
all:
	@echo "Configuration not enabled for gpperfmon."

else
#change by yuwei (change target name)
.PHONY: hdbsmon hdbmmon

all: hdbsmon hdbmmon

hdbsmon:
	$(MAKE) -C src/gpmon hdbsmon BUILDDIR=$(BUILDDIR)

hdbmmon:
	$(MAKE) -C src/gpmon hdbmmon BUILDDIR=$(BUILDDIR)

clean distclean:
	$(MAKE) -C src/gpmon clean

install:
	$(MAKE) -C src/gpmon install

endif