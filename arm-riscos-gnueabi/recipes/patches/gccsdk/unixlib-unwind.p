Index: libunixlib/Makefile.am
===================================================================
--- libunixlib/Makefile.am      (revision 7698)
+++ libunixlib/Makefile.am      (working copy)
@@ -33,7 +33,7 @@
 # arguments can not be tested for NULL in UnixLib itself.
 if ARM_EABI
 AM_CFLAGS = -D__GNU_LIBRARY__ -DNO_LONG_DOUBLE -D_GNU_SOURCE=1 \
-	-D__UNIXLIB_NO_NONNULL -std=c99 $(LIBM_FLAGS)
+	-D__UNIXLIB_NO_NONNULL -std=c99 -mpoke-function-name -funwind-tables $(LIBM_FLAGS)
 UNIXLIB_CHUNKED_STACK=0
 else
 AM_CFLAGS = -D__GNU_LIBRARY__ -DNO_LONG_DOUBLE -D_GNU_SOURCE=1 \
Index: libunixlib/signal/post.c
===================================================================
--- libunixlib/signal/post.c	(revision 7698)
+++ libunixlib/signal/post.c	(working copy)
@@ -267,9 +267,86 @@
 #define FP_OFFSET (-3)
 #endif
 
+#ifdef __ARM_EABI__
+/**
+ * AAPCS does not require the compiler to construct a backtrace structure
+ * in the stack (unlike APCS, which does). This results in FP rarely pointing
+ * at any form of valid stack frame (and, to complicate matters, at the time
+ * of writing, some frames end up with APCS-format frame records, anyway)
+ * which makes it nigh-on impossible to reliably unwind the stack without
+ * additional information). FP is thus often treated as an additional
+ * callee-saved register (i.e. v8) in AAPCS-conformant code.
+ *
+ * Additionally, where frame records are generated, AAPCS has them contain
+ * two entries: previous-FP and LR on entry. There is therefore (unlike APCS)
+ * no way of finding the function entry point from the frame record at all,
+ * even if it did exist.
+ *
+ * So, we cannot trust that FP ever points at a valid stack frame record and
+ * we cannot find function entry points to extract poked function names from.
+ * We can, however, make stack unwinding work if we have some means of
+ * identifying the function in which an arbitrary instruction lies.
+ *
+ * -funwind-tables will result in clang/GCC generating such a data structure,
+ * (an array between __exidx_start and __exidx_end) which will be consulted
+ * by _Unwind_Backtrace() when unwinding the stack.
+ */
+
+#include <unwind.h>
+
+static _Unwind_Reason_Code
+__write_backtrace_cb (_Unwind_Context *ctx, void *pw)
+{
+  _Unwind_Control_Block *ucbp = NULL;
+  const unsigned int *fn;
+
+  ucbp = (_Unwind_Control_Block *) _Unwind_GetGR(ctx, UNWIND_POINTER_REG);
+  fn = (const unsigned int *) ucbp->pr_cache.fnstart;
+
+  fprintf (stderr, "  (%8x) fn: %8x pc: %8x sp: %8x ",
+	   _Unwind_GetGR (ctx, 11), (unsigned int)fn, _Unwind_GetIP (ctx),
+	   _Unwind_GetGR (ctx, 13));
+
+#if PIC
+  /* FIXME: extend this with source location when available.  */
+  const char *lib = NULL;
+  unsigned offset;
+  _swix(SOM_Location,
+	_IN(0) | _OUTR(0,1), _Unwind_GetIP (ctx), &lib, &offset);
+  if (lib)
+    fprintf(stderr, " : %8X : %s\n", offset, lib);
+  else
+#endif
+    {
+      int cplusplus_name;
+      const char *name = extract_name (fn, &cplusplus_name);
+      fprintf (stderr, (cplusplus_name) ? " %s\n" : " %s()\n", name);
+    }
+
+  /* TODO: __ul_callback_fp stuff (might need to save/match lr, instead) */
+
+  return _URC_NO_REASON;
+}
+
 static void
 __write_backtrace_thread (const unsigned int *fp)
 {
+  if (fp != NULL)
+    {
+      /* TODO: thread stack traces */
+      fprintf (stderr, "Thread stack traces not supported\n");
+    }
+  else
+    {
+      _Unwind_Backtrace(__write_backtrace_cb, NULL);
+    }
+
+  fputc ('\n', stderr);
+}
+#else
+static void
+__write_backtrace_thread (const unsigned int *fp)
+{
   /* Running as USR26 or USR32 ?  */
   unsigned int is32bit;
   __asm__ volatile ("SUBS	%[is32bit], r0, r0\n\t" /* Set at least one status flag. */
@@ -306,22 +383,6 @@
 	  break;
 	}
 
-#ifdef __ARM_EABI__
-      const unsigned int * const lr = (unsigned int *)fp[LR_OFFSET];
-      fprintf (stderr, "  (%8x) lr: %8x",
-	       (unsigned int)fp, (unsigned int)lr);
-#if PIC
-      /* FIXME: extend this with source location when available.  */
-      const char *lib = NULL;
-      unsigned offset;
-      _swix(SOM_Location,
-	    _IN(0) | _OUTR(0,1), lr, &lib, &offset);
-      if (lib)
-	fprintf(stderr, " : %8X : %s\n", offset, lib);
-      else
-#endif
-	fputc('\n', stderr);
-#else
       /* Retrieve PC counter.
 	 PC counter has been saved using STMxx ..., { ..., PC } so it can be
 	 8 or 12 bytes away from the STMxx instruction depending on the ARM
@@ -347,10 +408,9 @@
       int cplusplus_name;
       const char *name = extract_name (pc, &cplusplus_name);
       fprintf (stderr, (cplusplus_name) ? " %s\n" : " %s()\n", name);
-#endif
+
       oldfp = fp;
       fp = (const unsigned int *)fp[FP_OFFSET];
-#ifndef __ARM_EABI__
       if (__ul_callbackfp != NULL && fp == __ul_callbackfp)
 	{
 	  /* At &oldfp[1] = cpsr, a1-a4, v1-v6, sl, fp, ip, sp, lr, pc */
@@ -424,18 +484,17 @@
 
 	  fputs ("\n\n", stderr);
 	}
-#endif
     }
 
   fputc ('\n', stderr);
 }
+#endif
 
-
 void
 __write_backtrace (int signo)
 {
 #ifdef __ARM_EABI__
-  register const unsigned int *fp = __builtin_frame_address(0);
+  register const unsigned int *fp = NULL;
 #else
   register const unsigned int *fp __asm ("fp");
 #endif
