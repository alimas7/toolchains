--- gmp/configure.orig 2012-08-17 18:03:57.000000000 +0100
+++ gmp/configure      2012-08-17 18:04:17.000000000 +0100
@@ -5003,11 +5003,12 @@
 
 #if defined (__GNUC__) && ! defined (__cplusplus)
 typedef unsigned long long t1;typedef t1*t2;
+void g(){}
+void h(){}
 static __inline__ t1 e(t2 rp,t2 up,int n,t1 v0)
 {t1 c,x,r;int i;if(v0){c=1;for(i=1;i<n;i++){x=up[i];r=x+1;rp[i]=r;}}return c;}
-f(){static const struct{t1 n;t1 src[9];t1 want[9];}d[]={{1,{0},{1}},};t1 got[9];int i;
+void f(){static const struct{t1 n;t1 src[9];t1 want[9];}d[]={{1,{0},{1}},};t1 got[9];int i;
 for(i=0;i<1;i++){if(e(got,got,9,d[i].n)==0)h();g(i,d[i].src,d[i].n,got,d[i].want,9);if(d[i].n)h();}}
-h(){}g(){}
 #else
 int dummy;
 #endif
@@ -5066,8 +5067,9 @@
    1666 to get an ICE with -O1 -mpowerpc64.  */
 
 #if defined (__GNUC__) && ! defined (__cplusplus)
-f(int u){int i;long long x;x=u?~0:0;if(x)for(i=0;i<9;i++);x&=g();if(x)g();}
-g(){}
+int g();
+void f(int u){int i;long long x;x=u?~0:0;if(x)for(i=0;i<9;i++);x&=g();if(x)g();}
+int g(){return 0;}
 #else
 int dummy;
 #endif
@@ -8615,6 +8617,7 @@
 # remove anything that might look like compiler output to our "||" expression
 rm -f conftest* a.out b.out a.exe a_out.exe
 cat >conftest.c <<EOF
+#include <stdlib.h>
 int
 main ()
 {
@@ -8767,6 +8770,7 @@
   echo $ECHO_N "(cached) $ECHO_C" >&6
 else
   cat >conftest.c <<EOF
+#include <stdlib.h>
 int
 main ()
 {
@@ -8806,6 +8810,7 @@
   echo $ECHO_N "(cached) $ECHO_C" >&6
 else
   cat >conftest.c <<EOF
+#include <stdlib.h>
 int
 main (int argc, char **argv)
 {
@@ -8841,6 +8846,8 @@
   echo $ECHO_N "(cached) $ECHO_C" >&6
 else
   cat >conftest.c <<EOF
+#include <math.h>
+#include <stdlib.h>
 int
 main ()
 {
@@ -30006,8 +30013,6 @@
 echo "define(<M4WRAP_SPURIOUS>,<$gmp_cv_m4_m4wrap_spurious>)" >> $gmp_tmpconfigm4
 
 
-else
-  M4=m4-not-needed
 fi
 
 # Only do the GMP_ASM checks if there's a .S or .asm wanting them.
