--- Makefile.in.orig
+++ Makefile.in
@@ -60666,7 +60666,7 @@
 	CONFIG_SHELL="$(SHELL)" $(SHELL) ./config.status --recheck
 
 # Rebuilding configure.
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.64
 $(srcdir)/configure: @MAINT@ $(srcdir)/configure.ac $(srcdir)/config/acx.m4 \
 	$(srcdir)/config/override.m4 $(srcdir)/config/proginstall.m4
 	cd $(srcdir) && $(AUTOCONF)
--- libiberty/Makefile.in.orig
+++ libiberty/Makefile.in
@@ -458,7 +458,7 @@
 config.status: $(srcdir)/configure
 	$(SHELL) ./config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.64
 configure_deps = $(srcdir)/aclocal.m4 \
 	$(srcdir)/../config/acx.m4 \
 	$(srcdir)/../config/no-executables.m4 \
--- fixincludes/Makefile.in.orig
+++ fixincludes/Makefile.in
@@ -63,9 +63,9 @@
 # Locate mkinstalldirs.
 mkinstalldirs=$(SHELL) $(srcdir)/../mkinstalldirs
 
-AUTOCONF = autoconf
-AUTOHEADER = autoheader
-ACLOCAL = aclocal
+AUTOCONF = autoconf2.64
+AUTOHEADER = autoheader2.64
+ACLOCAL = aclocal-1.11
 ACLOCAL_AMFLAGS = -I ../gcc -I .. -I ../config
 
 default : all
--- gcc/Makefile.in.orig
+++ gcc/Makefile.in
@@ -1715,8 +1715,8 @@
 # might be on a read-only file system.  If configured for maintainer mode
 # then do allow autoconf to be run.
 
-AUTOCONF = autoconf
-ACLOCAL = aclocal
+AUTOCONF = autoconf2.64
+ACLOCAL = aclocal-1.11
 ACLOCAL_AMFLAGS = -I ../config -I ..
 aclocal_deps = \
 	$(srcdir)/../libtool.m4 \
--- Makefile.tpl.orig
+++ Makefile.tpl
@@ -1878,7 +1878,7 @@
 	CONFIG_SHELL="$(SHELL)" $(SHELL) ./config.status --recheck
 
 # Rebuilding configure.
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.64
 $(srcdir)/configure: @MAINT@ $(srcdir)/configure.ac $(srcdir)/config/acx.m4 \
 	$(srcdir)/config/override.m4 $(srcdir)/config/proginstall.m4
 	cd $(srcdir) && $(AUTOCONF)
--- libada/Makefile.in.orig
+++ libada/Makefile.in
@@ -191,7 +191,7 @@
 config.status: $(srcdir)/configure
 	$(SHELL) ./config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.64
 configure_deps = \
 	$(srcdir)/configure.ac \
 	$(srcdir)/../config/acx.m4 \
--- libgcc/Makefile.in.orig
+++ libgcc/Makefile.in
@@ -141,7 +141,7 @@
 config.status: $(srcdir)/configure $(srcdir)/config.host
 	$(SHELL) ./config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.64
 configure_deps = \
 	$(srcdir)/../config/enable.m4 \
 	$(srcdir)/../config/tls.m4 \
--- libobjc/Makefile.in.orig
+++ libobjc/Makefile.in
@@ -348,8 +348,8 @@
 	CONFIG_SITE=no-such-file CC='$(CC)' AR='$(AR)' CFLAGS='$(CFLAGS)' \
 	CPPFLAGS='$(CPPFLAGS)' $(SHELL) config.status --recheck
 
-AUTOCONF = autoconf
-ACLOCAL = aclocal
+AUTOCONF = autoconf2.64
+ACLOCAL = aclocal-1.11
 ACLOCAL_AMFLAGS = -I ../config -I ..
 aclocal_deps = \
 	$(srcdir)/../config/multi.m4 \
--- gnattools/Makefile.in.orig
+++ gnattools/Makefile.in
@@ -313,7 +313,7 @@
 config.status: $(srcdir)/configure
 	$(SHELL) ./config.status --recheck
 
-AUTOCONF = autoconf
+AUTOCONF = autoconf2.64
 configure_deps = \
 	$(srcdir)/configure.ac \
 	$(srcdir)/../config/acx.m4 \
