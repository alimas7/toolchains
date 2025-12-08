--- gcc/bfd.bfd-in.h.pp.orig
+++ gcc/bfd.bfd-in.h.pp
@@ -1,16 +1,14 @@
 --- bfd/bfd-in.h.orig	2018-01-13 13:31:15.000000000 +0000
 +++ bfd/bfd-in.h	2019-01-17 22:13:33.544924940 +0000
-@@ -918,6 +918,9 @@
+@@ -918,6 +918,7 @@
    int merge_exidx_entries;
    int cmse_implib;
    bfd *in_implib_bfd;
-+#ifdef __RISCOS_TARGET__
 +  int riscos_module;
-+#endif
  };
  
  void bfd_elf32_arm_set_target_params
-@@ -932,6 +935,19 @@
+@@ -932,6 +933,19 @@
  extern void bfd_elf32_arm_keep_private_stub_output_sections
    (struct bfd_link_info *);
  
--- gcc/bfd.bfd-in2.h.pp
+++ /dev/null
@@ -1,10 +0,0 @@
---- bfd/bfd-in2.h.orig	2019-01-14 23:35:16.000000000 +0000
-+++ bfd/bfd-in2.h	2019-01-14 23:40:55.101564158 +0000
-@@ -925,6 +925,7 @@
-   int merge_exidx_entries;
-   int cmse_implib;
-   bfd *in_implib_bfd;
-+  int riscos_module;
- };
- 
- void bfd_elf32_arm_set_target_params
