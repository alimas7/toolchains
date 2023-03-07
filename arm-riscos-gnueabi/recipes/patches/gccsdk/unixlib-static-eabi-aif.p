Index: libunixlib/incl-local/internal/asm_dec.s
===================================================================
--- libunixlib/incl-local/internal/asm_dec.s	(revision 7698)
+++ libunixlib/incl-local/internal/asm_dec.s	(working copy)
@@ -215,6 +215,7 @@
 
 @ A few of these are required to build SUL.
 .set	XARMEABISupport_MemoryOp, 0x59D00 + X_Bit
+.set	ARMEABISupport_AbortOp, 0x59D01
 .set	XARMEABISupport_AbortOp, 0x59D01 + X_Bit
 .set	XARMEABISupport_StackOp, 0x59D02 + X_Bit
 .set	XARMEABISupport_Cleanup, 0x59D03 + X_Bit

Index: libunixlib/sys/_syslib.s
===================================================================
--- libunixlib/sys/_syslib.s	(revision 7698)
+++ libunixlib/sys/_syslib.s	(working copy)
@@ -108,6 +108,35 @@
 
 	MOV	v1, a1
 
+#ifdef __ARM_EABI__
+	@ Check to see if this is a static EABI binary produced by elf2aif
+	TEQ	a3, #0xFF
+	BNE	not_eabi_aif
+
+	@ It was. a2 contains the GOT address (or 0 if none)
+	TEQ	a2, #0
+	@ Create a fake runtime array (overwriting bits of AIF header)
+	MOVNE	a3, #0x8000
+	STRNE	a2, [a3, #(52 + 20)]
+	MOVNE	a2, #0
+	STRNE	a2, [a3, #(52 + 24)]
+	STRNE	a2, [a3, #(52 + 28)]
+	STRNE	a2, [a3, #(52 + 32)]
+	@ and fill in the workspace (ditto)
+	STRNE	a2, [a3, #(52 + 0)]
+	STRNE	a2, [a3, #(52 + 8)]
+	STRNE	a2, [a3, #(52 + 12)]
+	STRNE	a2, [a3, #(52 + 16)]
+	ADDNE	a2, a3, #(52 + 20)
+	STRNE	a2, [a3, #(52 + 4)]
+
+	@ Finally, enable the ARMEABISupport abort handler
+	MOV	a1, #2
+	SWI	ARMEABISupport_AbortOp
+
+not_eabi_aif:
+#endif
+
 	PIC_LOAD v4
 
 	@ Read environment parameters
