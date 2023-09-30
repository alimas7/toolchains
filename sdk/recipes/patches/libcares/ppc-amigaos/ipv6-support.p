--- src/lib/ares_ipv6.h.orig	2017-10-10 15:19:45.611896396 +0100
+++ src/lib/ares_ipv6.h	2017-10-17 15:42:25.304921197 +0100
@@ -22,6 +22,11 @@
 #endif
 
+#ifndef INET6_ADDRSTRLEN
+#define INET6_ADDRSTRLEN 46
+#endif
+
 #ifndef HAVE_STRUCT_SOCKADDR_IN6
+#define s6_addr _S6_un._S6_u8
 struct sockaddr_in6
 {
   unsigned short       sin6_family;
--- src/lib/ares__sortaddrinfo.c.orig	2017-10-10 15:19:45.611896396 +0100
+++ src/lib/ares__sortaddrinfo.c	2017-10-17 15:42:25.304921197 +0100
@@ -71,6 +71,39 @@
 
 #define ARES_IN_LOOPBACK(a) ((((long int)(a)) & 0xff000000) == 0x7f000000)
 
+#ifndef IN6_IS_ADDR_LINKLOCAL
+#define IN6_IS_ADDR_LINKLOCAL(a) \
+	((((__const uint32_t *) (a))[0] & htonl (0xffc00000))		      \
+	 == htonl (0xfe800000))
+#endif
+#ifndef IN6_IS_ADDR_LOOPBACK
+#define IN6_IS_ADDR_LOOPBACK(a) \
+	(((__const uint32_t *) (a))[0] == 0				      \
+	 && ((__const uint32_t *) (a))[1] == 0				      \
+	 && ((__const uint32_t *) (a))[2] == 0				      \
+	 && ((__const uint32_t *) (a))[3] == htonl (1))
+#endif
+#ifndef IN6_IS_ADDR_MULTICAST
+#define IN6_IS_ADDR_MULTICAST(a) (((__const uint8_t *) (a))[0] == 0xff)
+#endif
+#ifndef IN6_IS_ADDR_SITELOCAL
+#define IN6_IS_ADDR_SITELOCAL(a) \
+	((((__const uint32_t *) (a))[0] & htonl (0xffc00000))		      \
+	 == htonl (0xfec00000))
+#endif
+#ifndef IN6_IS_ADDR_V4COMPAT
+#define IN6_IS_ADDR_V4COMPAT(a) \
+	((((__const uint32_t *) (a))[0] == 0)				      \
+	 && (((__const uint32_t *) (a))[1] == 0)			      \
+	 && (((__const uint32_t *) (a))[2] == 0)			      \
+	 && (ntohl (((__const uint32_t *) (a))[3]) > 1))
+#endif
+#ifndef IN6_IS_ADDR_V4MAPPED
+#define IN6_IS_ADDR_V4MAPPED(a) \
+	((((__const uint32_t *) (a))[0] == 0)				      \
+	 && (((__const uint32_t *) (a))[1] == 0)			      \
+	 && (((__const uint32_t *) (a))[2] == htonl (0xffff)))
+#endif
 /* RFC 4193. */
 #define ARES_IN6_IS_ADDR_ULA(a) (((a)->s6_addr[0] & 0xfe) == 0xfc)
 
@@ -253,8 +286,13 @@
 /*
  * Find number of matching initial bits between the two addresses a1 and a2.
  */
+#ifndef HAVE_STRUCT_SOCKADDR_IN6
+static int common_prefix_len(const struct ares_in6_addr *a1,
+                             const struct ares_in6_addr *a2)
+#else
 static int common_prefix_len(const struct in6_addr *a1,
                              const struct in6_addr *a2)
+#endif
 {
   const char *p1 = (const char *)a1;
   const char *p2 = (const char *)a2;
