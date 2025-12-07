Index: gcc4/recipe/files/gcc/libunixlib/stdlib/alloc.c
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/stdlib/alloc.c	(revision 7686)
+++ gcc4/recipe/files/gcc/libunixlib/stdlib/alloc.c	(revision 7687)
@@ -3966,6 +3966,22 @@
 }
 weak_alias (__memalign, memalign)
 
+int __posix_memalign(void **memptr, size_t alignment, size_t size)
+{
+  assert(memptr);
+
+  /* If the alignment has more than 1 bit set, then it's not a power of 2.  */
+  if (__builtin_popcount(alignment) != 1 || (alignment & 3) != 0)
+    return EINVAL;
+
+  void *ptr = __memalign(alignment, size);
+
+  *memptr = ptr;
+
+  return ptr ? 0 : ENOMEM;
+}
+weak_alias (__posix_memalign, posix_memalign)
+
 void *__valloc (size_t bytes)
 {
   void *ptr;
Index: gcc4/recipe/files/gcc/libunixlib/include/stdlib.h
===================================================================
--- gcc4/recipe/files/gcc/libunixlib/include/stdlib.h	(revision 7686)
+++ gcc4/recipe/files/gcc/libunixlib/include/stdlib.h	(revision 7687)
@@ -184,6 +184,7 @@
 #ifndef __TARGET_SCL__
 extern void *memalign (size_t __alignment,
 		       size_t __bytes) __THROW __attribute_malloc__ __wur;
+extern int posix_memalign(void **memptr, size_t alignment, size_t size);
 extern void cfree (void *__mem) __THROW;
 extern int malloc_trim (size_t) __THROW;
 #endif
