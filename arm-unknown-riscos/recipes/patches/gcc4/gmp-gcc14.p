--- /dev/null
+++ gcc4/recipe/patches/gmp/configure.p
@@ -0,0 +1,29 @@
+--- configure.orig	2025-12-09 00:31:48.348888956 +0000
++++ configure	2025-12-09 00:43:29.384837057 +0000
+@@ -6121,11 +6121,12 @@
+ 
+ #if defined (__GNUC__) && ! defined (__cplusplus)
+ typedef unsigned long long t1;typedef t1*t2;
++void g(){}
++void h(){}
+ static __inline__ t1 e(t2 rp,t2 up,int n,t1 v0)
+ {t1 c,x,r;int i;if(v0){c=1;for(i=1;i<n;i++){x=up[i];r=x+1;rp[i]=r;}}return c;}
+-f(){static const struct{t1 n;t1 src[9];t1 want[9];}d[]={{1,{0},{1}},};t1 got[9];int i;
++void f(){static const struct{t1 n;t1 src[9];t1 want[9];}d[]={{1,{0},{1}},};t1 got[9];int i;
+ for(i=0;i<1;i++){if(e(got,got,9,d[i].n)==0)h();g(i,d[i].src,d[i].n,got,d[i].want,9);if(d[i].n)h();}}
+-h(){}g(){}
+ #else
+ int dummy;
+ #endif
+@@ -6184,8 +6185,9 @@
+    1666 to get an ICE with -O1 -mpowerpc64.  */
+ 
+ #if defined (__GNUC__) && ! defined (__cplusplus)
+-f(int u){int i;long long x;x=u?~0:0;if(x)for(i=0;i<9;i++);x&=g();if(x)g();}
+-g(){}
++int g();
++void f(int u){int i;long long x;x=u?~0:0;if(x)for(i=0;i<9;i++);x&=g();if(x)g();}
++int g(){return 0;}
+ #else
+ int dummy;
+ #endif
