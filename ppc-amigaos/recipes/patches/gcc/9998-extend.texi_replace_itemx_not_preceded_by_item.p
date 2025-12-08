From d99a477150144f58199287938334fb7545acaed5 Mon Sep 17 00:00:00 2001
From: =?utf8?q?Arsen=20Arsenovi=C4=87?= <arsen@aarsen.me>
Date: Wed, 3 May 2023 22:20:27 +0200
Subject: [PATCH] extend.texi: replace @itemx not preceded by @item.

gcc/ChangeLog:

	* doc/extend.texi: Replace @itemx not being preceded by @item.
---
 gcc/doc/extend.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
index d6093397a61e..64bd4c1cb6c8 100644
--- gcc/doc/extend.texi
+++ gcc/doc/extend.texi
@@ -2487,7 +2487,7 @@ The following attributes are supported on most targets.
 @table @code
 @c Keep this table alphabetized by attribute name.  Treat _ as space.
 
-@itemx access (@var{access-mode}, @var{ref-index})
+@item access (@var{access-mode}, @var{ref-index})
 @itemx access (@var{access-mode}, @var{ref-index}, @var{size-index})
 
 The @code{access} attribute enables the detection of invalid or unsafe
-- 
2.43.7

