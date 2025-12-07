--- crypto/bio/bio_sock2.c.orig	2019-02-15 10:07:24.181612545 +0000
+++ crypto/bio/bio_sock2.c	2019-02-15 10:07:15.637654488 +0000
@@ -100,6 +100,7 @@
         }
     }
 
+#if defined(TCP_NODELAY)
     if (options & BIO_SOCK_NODELAY) {
         if (setsockopt(sock, IPPROTO_TCP, TCP_NODELAY,
                        (const void *)&on, sizeof(on)) != 0) {
@@ -109,6 +110,7 @@
             return 0;
         }
     }
+#endif
     if (options & BIO_SOCK_TFO) {
 # if defined(OSSL_TFO_CLIENT_FLAG)
 #  if defined(OSSL_TFO_SYSCTL_CLIENT)
@@ -317,6 +319,7 @@
         }
     }
 
+#if defined(TCP_NODELAY)
     if (options & BIO_SOCK_NODELAY) {
         if (setsockopt(sock, IPPROTO_TCP, TCP_NODELAY,
                        (const void *)&on, sizeof(on)) != 0) {
@@ -326,6 +329,7 @@
             return 0;
         }
     }
+#endif

   /* On OpenBSD it is always IPv6 only with IPv6 sockets thus read-only */
 # if defined(IPV6_V6ONLY) && !defined(__OpenBSD__)
