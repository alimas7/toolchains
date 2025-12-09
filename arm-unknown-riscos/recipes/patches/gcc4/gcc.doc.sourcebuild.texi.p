--- /dev/null
+++ gcc4/recipe/patches/gcc/gcc.doc.sourcebuild.texi.p
@@ -0,0 +1,11 @@
+--- gcc/doc/sourcebuild.texi.orig
++++ gcc/doc/sourcebuild.texi
+@@ -676,7 +676,7 @@
+ @code{lang_checks}.
+ 
+ @table @code
+-@itemx all.cross
++@item all.cross
+ @itemx start.encap
+ @itemx rest.encap
+ FIXME: exactly what goes in each of these targets?
