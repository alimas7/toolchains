--- lib/amigaos.c.orig	2017-10-10 15:19:45.611896396 +0100
+++ lib/amigaos.c	2017-10-17 15:42:25.304921197 +0100
@@ -86,7 +86,9 @@
       ULONG enabled = 0;
 
       SocketBaseTags(SBTM_SETVAL(SBTC_CAN_SHARE_LIBRARY_BASES), TRUE,
+#ifdef SBTC_HAVE_GETHOSTADDR_R_API
                      SBTM_GETREF(SBTC_HAVE_GETHOSTADDR_R_API), (ULONG)&enabled,
+#endif
                      TAG_DONE);
 
       if(enabled) {
