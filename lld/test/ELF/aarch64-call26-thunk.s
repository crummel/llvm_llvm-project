// RUN: llvm-mc -filetype=obj -triple=aarch64-pc-freebsd %S/Inputs/abs.s -o %tabs
// RUN: llvm-mc -filetype=obj -triple=aarch64-pc-freebsd %s -o %t
// RUN: ld.lld %t %tabs -o %t2 2>&1
// RUN: llvm-objdump -d -triple=aarch64-pc-freebsd %t2 | FileCheck %s
// REQUIRES: aarch64

.text
.globl _start
_start:
    bl big

// CHECK: Disassembly of section .text:
// CHECK-NEXT: _start:
// CHECK-NEXT:    20000:        02 00 00 94     bl      #8
// CHECK: __AArch64AbsLongThunk_big:
// CHECK-NEXT:    20008:        50 00 00 58     ldr     x16, #8
// CHECK-NEXT:    2000c:        00 02 1f d6     br      x16
// CHECK: $d:
// CHECK-NEXT:    20010:        00 00 00 00     .word   0x00000000
// CHECK-NEXT:    20014:        10 00 00 00     .word   0x00000010

