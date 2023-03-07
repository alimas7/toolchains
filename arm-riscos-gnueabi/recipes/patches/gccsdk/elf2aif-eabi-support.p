Index: elf2aif/src/elf2aif.c
===================================================================
--- elf2aif/src/elf2aif.c	(revision 7698)
+++ elf2aif/src/elf2aif.c	(working copy)
@@ -72,12 +72,14 @@
 } aifheader_t;
 
 static int opt_verbose = 0;
+static int opt_eabi = 0;
 
 static Elf32_External_Ehdr elf_ehdr;
 static phdr_list_t *elf_phdrlistP;
 static const char *elf_filename;
+static uint32_t got_addr = 0;
 
-static const unsigned int aifcode[] = {
+static const uint32_t aifcode[] = {
   0xE1A00000,			/* NOP (BL decompress)      */
   0xE1A00000,			/* NOP (BL self-relocate)   */
   0xEB00000C,			/* BL zero-init             */
@@ -113,6 +115,25 @@
   0xEAFFFFFB			/* B     zeroloop           */
 };
 
+static const uint32_t crt0code[] = {
+  0xE59F3010,			/* LDR   R3, =crt1_data     */
+  0xE583000C,			/* STR   R0, [R3, #12]      */
+  0xE583101C,			/* STR   R1, [R3, #28]      */
+  0xE5832020,			/* STR   R2, [R3, #32]      */
+  0xE1A00003			/* MOV   R0, R3             */
+ 				/* B     __main             */
+};
+
+static const uint32_t eabi_crt0code[] = {
+  0xE59F0010,			/* LDR   R0, =crt1_data     */
+  0xE59F1004,			/* LDR   R1, =got_addr      */
+  0xE3A020FF,			/* MOV   R2, #&FF           */
+  0xEA000000,			/* B     go                 */
+  0x00000000,			/* got_addr (*)             */
+/* go: */
+  				/* B     __main             */
+};
+
 /* Read a little-endian 'short' value.  */
 static uint16_t
 RdShort (const uint8_t sh[2])
@@ -143,6 +164,7 @@
   fprintf (stderr, "Usage: elf2aif [options] <ELF file> [<AIF file>]\n"
 	   "Convert static ARM ELF binary to AIF (Acorn Image Format) binary.\n"
 	   "Options:\n"
+	   "  -e, --eabi	source binary uses EABI\n"
 	   "  -v, --verbose	prints informational messages during processing\n"
 	   "      --help	display this help and exit\n"
 	   "      --version	output version information and exit\n");
@@ -201,7 +223,8 @@
       return EXIT_FAILURE;
     }
 
-  if (elf_ehdr.e_ident[EI_OSABI] != ELFOSABI_ARM)
+  if ((!opt_eabi && elf_ehdr.e_ident[EI_OSABI] != ELFOSABI_ARM) ||
+      (opt_eabi && elf_ehdr.e_ident[EI_OSABI] != ELFOSABI_NONE))
     {
       fprintf (stderr, "ELF file '%s' is not for ARM\n", elf_filename);
       return EXIT_FAILURE;
@@ -344,6 +367,97 @@
 }
 
 static int
+e2a_readshdr (FILE * elfhandle)
+{
+  Elf32_External_Shdr shstentry;
+  uint32_t shoffset, shentrysize, shentrycount, shstrndx;
+  uint32_t shstoffset, shstsize;
+  char *shst;
+
+  if ((shoffset = RdLong (elf_ehdr.e_shoff)) == 0
+      || (shentrycount = RdShort (elf_ehdr.e_shnum)) == 0)
+    {
+      fprintf (stderr, "ELF file '%s' does not have section headers\n",
+               elf_filename);
+      return EXIT_FAILURE;
+    }
+
+  if ((shentrysize = RdShort (elf_ehdr.e_shentsize)) < sizeof (Elf32_External_Shdr))
+    {
+      fprintf (stderr, "Size section header entry is too small\n");
+      return EXIT_FAILURE;
+    }
+
+  if ((shstrndx = RdShort (elf_ehdr.e_shstrndx)) >= shentrycount) {
+      fprintf (stderr, "String table index out of bounds\n");
+      return EXIT_FAILURE;
+    }
+
+  if (fseek (elfhandle, shoffset + (shstrndx * shentrysize), SEEK_SET) != 0
+      || fread (&shstentry, sizeof (Elf32_External_Shdr), 1, elfhandle) != 1)
+    {
+      fprintf (stderr, "Failed to read section header string table header\n");
+      return EXIT_FAILURE;
+    }
+
+  if ((shstoffset = RdLong (shstentry.sh_offset)) == 0)
+    {
+      fprintf (stderr, "Section header string table data missing\n");
+      return EXIT_FAILURE;
+    }
+
+  if ((shstsize = RdLong (shstentry.sh_size)) == 0)
+    {
+      fprintf (stderr, "Invalid section header string table size\n");
+      return EXIT_FAILURE;
+    }
+
+  if ((shst = malloc (shstsize)) == NULL)
+    {
+      fprintf (stderr, "Out of memory\n");
+      return EXIT_FAILURE;
+    }
+
+  if (fseek (elfhandle, shstoffset, SEEK_SET) != 0
+      || fread (shst, 1, shstsize, elfhandle) != shstsize)
+    {
+      fprintf (stderr, "Failed to read section header string table\n");
+      return EXIT_FAILURE;
+    }
+
+  while (shentrycount)
+    {
+      Elf32_External_Shdr shentry;
+      uint32_t shnameoff;
+
+      if (fseek (elfhandle, shoffset, SEEK_SET) != 0
+          || fread (&shentry, sizeof (Elf32_External_Shdr), 1, elfhandle) != 1)
+        {
+          fprintf (stderr, "Failed to read section header entry\n");
+          return EXIT_FAILURE;
+        }
+
+      if ((shnameoff = RdLong (shentry.sh_name)) >= shstsize)
+        {
+          fprintf (stderr, "Section name out of bounds\n");
+          return EXIT_FAILURE;
+        }
+
+      if (strcmp ((shst + shnameoff), ".got") == 0)
+        {
+          got_addr = RdLong (shentry.sh_addr);
+        }
+
+      shoffset += shentrysize;
+      --shentrycount;
+    }
+
+  free (shst);
+
+  return EXIT_SUCCESS;
+}
+
+static int
 e2a_copy (FILE * elfhandle, FILE * aifhandle)
 {
   const phdr_list_t *phdrP;
@@ -503,6 +617,40 @@
       return EXIT_FAILURE;
     }
 
+  /* In the EABI case we need to inject the code to install
+   * the ARMEABISupport abort handler */
+  if (opt_eabi)
+    {
+      uint32_t crt0[5];
+      assert(sizeof (crt0code) == sizeof (crt0));
+      assert(sizeof (eabi_crt0code) == sizeof (crt0));
+
+      if (opt_verbose)
+	printf ("Rewriting crt0 at offset 0x%x\n", (exec_addr - load_addr));
+
+      if (fseek (elfhandle, (exec_addr - load_addr), SEEK_SET) != 0 ||
+	  fread (crt0, sizeof (crt0), 1, elfhandle) != 1)
+	{
+	  fprintf (stderr, "Failed to read crt0\n");
+	  return EXIT_FAILURE;
+	}
+      if (memcmp(crt0, crt0code, sizeof (crt0)) != 0)
+	{
+	  fprintf (stderr, "crt0 code not as expected\n");
+	  return EXIT_FAILURE;
+	}
+      /* Inject GOT address */
+      memcpy (crt0, eabi_crt0code, sizeof (crt0));
+      crt0[4] = got_addr;
+      if (fseek (aifhandle, (exec_addr - load_addr), SEEK_SET) != 0 ||
+	  fwrite (crt0, sizeof (crt0), 1, aifhandle) != 1 ||
+	  fseek (aifhandle, aifend, SEEK_SET) != 0)
+	{
+	  fprintf (stderr, "Failed to write crt0\n");
+	  return EXIT_FAILURE;
+	}
+    }
+
   return EXIT_SUCCESS;
 }
 
@@ -557,6 +705,7 @@
   elf_filename = elffilename;
 
   if (e2a_readehdr (elfhandle) == EXIT_SUCCESS
+      && e2a_readshdr (elfhandle) == EXIT_SUCCESS
       && e2a_readphdr (elfhandle) == EXIT_SUCCESS
       && e2a_copy (elfhandle, aifhandle) == EXIT_SUCCESS)
     status = EXIT_SUCCESS;
@@ -683,6 +832,9 @@
 	    fprintf (stderr, "Warning: extra options/arguments ignored\n");
 	  return EXIT_SUCCESS;
 	}
+      else if (!strcmp (&argv[i][1], "-eabi")
+	       || !strcmp (&argv[i][1], "e"))
+	opt_eabi = 1;
       else if (!strcmp (&argv[i][1], "-verbose")
 	       || !strcmp (&argv[i][1], "v"))
 	++opt_verbose;
