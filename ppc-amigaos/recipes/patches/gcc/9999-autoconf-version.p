--- Makefile.in.orig
+++ Makefile.in
@@ -61900,7 +61900,7 @@
 	CONFIG_SHELL="$(SHELL)" $(SHELL) ./config.status --recheck
 
 # Rebuilding configure.
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 $(srcdir)/configure: @MAINT@ $(srcdir)/configure.ac $(srcdir)/config/acx.m4 \
 	$(srcdir)/config/override.m4 $(srcdir)/config/proginstall.m4 \
 	$(srcdir)/config/elf.m4 $(srcdir)/config/isl.m4 \
--- libiberty/Makefile.in.orig
+++ libiberty/Makefile.in
@@ -482,7 +482,7 @@
 config.status: $(srcdir)/configure
 	$(SHELL) ./config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 ACLOCAL = aclocal
 ACLOCAL_AMFLAGS = -I ../config -I ..
 aclocal_deps = \
--- fixincludes/Makefile.in.orig
+++ fixincludes/Makefile.in
@@ -63,7 +63,7 @@
 # Locate mkinstalldirs.
 mkinstalldirs=$(SHELL) $(srcdir)/../mkinstalldirs
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 AUTOHEADER = autoheader
 ACLOCAL = aclocal
 ACLOCAL_AMFLAGS = -I .. -I ../config
--- gcc/Makefile.in.orig
+++ gcc/Makefile.in
@@ -1935,7 +1935,7 @@
 # might be on a read-only file system.  If configured for maintainer mode
 # then do allow autoconf to be run.
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 ACLOCAL = aclocal
 ACLOCAL_AMFLAGS = -I ../config -I ..
 aclocal_deps = \
--- Makefile.tpl.orig
+++ Makefile.tpl
@@ -2015,7 +2015,7 @@
 	CONFIG_SHELL="$(SHELL)" $(SHELL) ./config.status --recheck
 
 # Rebuilding configure.
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 $(srcdir)/configure: @MAINT@ $(srcdir)/configure.ac $(srcdir)/config/acx.m4 \
 	$(srcdir)/config/override.m4 $(srcdir)/config/proginstall.m4 \
 	$(srcdir)/config/elf.m4 $(srcdir)/config/isl.m4 \
--- libada/Makefile.in.orig
+++ libada/Makefile.in
@@ -179,7 +179,7 @@
 config.status: $(srcdir)/configure
 	$(SHELL) ./config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 configure_deps = \
 	$(srcdir)/configure.ac \
 	$(srcdir)/../config/acx.m4 \
--- libgcc/Makefile.in.orig
+++ libgcc/Makefile.in
@@ -161,7 +161,7 @@
 config.status: $(srcdir)/configure $(srcdir)/config.host
 	$(SHELL) ./config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 configure_deps = \
 	$(srcdir)/../config/enable.m4 \
 	$(srcdir)/../config/tls.m4 \
--- libobjc/Makefile.in.orig
+++ libobjc/Makefile.in
@@ -286,7 +286,7 @@
 	CONFIG_SITE=no-such-file CC='$(CC)' AR='$(AR)' CFLAGS='$(CFLAGS)' \
 	CPPFLAGS='$(CPPFLAGS)' $(SHELL) config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 ACLOCAL = aclocal
 ACLOCAL_AMFLAGS = -I ../config -I ..
 aclocal_deps = \
--- gnattools/Makefile.in.orig
+++ gnattools/Makefile.in
@@ -280,7 +280,7 @@
 config.status: $(srcdir)/configure
 	$(SHELL) ./config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.69
 configure_deps = \
 	$(srcdir)/configure.ac \
 	$(srcdir)/../config/acx.m4 \
