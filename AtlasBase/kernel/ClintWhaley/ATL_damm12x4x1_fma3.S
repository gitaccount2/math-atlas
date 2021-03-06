#include "atlas_asm.h"

#define rB0     %ymm0
#define rA0     %ymm1
#define rA1     %ymm2
#define rA2     %ymm3
#define rC00    %ymm4
#define rC10    %ymm5
#define rC20    %ymm6
#define rC01    %ymm7
#define rC11    %ymm8
#define rC21    %ymm9
#define rC02    %ymm10
#define rC12    %ymm11
#define rC22    %ymm12
#define rC03    %ymm13
#define rC13    %ymm14
#define rC23    %ymm15
/*
 * Prioritize original registers for inner-loop operations, but inc regs
 * can be anything w/o changing opcode size, so use new regs for those
 */
#define KK      %rdx  /* API reg */
#define pA      %rcx  /* API reg */
#define pB      %rax  /* comes in as r9 */
#define r192    %r9   /* set after mov r9 to pC () */
/*
 * Then N-loop variables much less important, so use any orig regs left
 */
#define pA0     %r8   /* set after mov r8 to pB (rax) */
#define pC      %rsi  /* set after mov rsi to nnu () */
#define nnu     %r10  /* comes in as rsi */
#define pfA     %rbx
#define pfB     %rbp
#define incPF   %r12
#define KK0     %rdi
/*
 * We could give a rat's ass about what registers used in outer (M-) loop
 */
#define nmu     %r11  /* comes in as rdi */
#define incAm   %r13
#define nnu0    %r14
#define pB0     %r15
/*
                    rdi      rsi    rdx        rcx         r8        r9
void ATL_USERMM(SZT nmu, SZT nnu, SZT K, CTYPE *pA, CTYPE *pB, TYPE *pC,
                  8(%rsp)    16(%rsp)     24(%rsp)
                CTYPE *pAn, CTYPE *pBn, CTYPE *pCn);
 */
#define PFBDIST 128
#define PFADIST 128
#define prefA(m_) prefetcht0 m_
#define prefB(m_) prefetcht0 m_
#define prefC(m_) prefetcht0 m_
#define FMAC vfmadd231pd   /* FMAC m256/r256, rs1, rd */
#ifdef BETAN1
   #define VCOP vsubpd
#else
   #define VCOP vaddpd
#endif
.text
.global ATL_asmdecor(ATL_USERMM)
ALIGN16
ATL_asmdecor(ATL_USERMM):
/*
 * Save callee-saved iregs
 */
   movq %rbp, -8(%rsp)
   movq %rbx, -16(%rsp)
   movq %r12, -24(%rsp)
   movq %r13, -32(%rsp)
   movq %r14, -40(%rsp)
   movq %r15, -48(%rsp)
/*
 * Load paramaters
 */
   mov %rdi, nmu
   mov %rsi, nnu
   mov %r8, pB
   mov %r9, pC
   mov nnu, nnu0
   movq 8(%rsp), pfB      /* pfB = pAn */
   movq 16(%rsp), pfA     /* pf = pBn */
   cmp pfA, pB
   CMOVE pfB, pfA
   CMOVEq 24(%rsp), pfB
   mov KK, KK0
   sub $-128, pC
   mov $192, r192
   mov pA, pA0
   mov pB, pB0
/*
 * incAm = 12*sizeof*K = 12*8*K = 3*4*8*K = 3*K*32
 */
   lea (KK, KK,2), incAm   /* incAm = 3*K */
   shl $5, incAm           /* incAm = 32*3*K */

   MLOOP:
      NLOOP:
#if 1
/*
 *       First iteration peeled to handle init of rC
 */
            vbroadcastsd (pB), rB0
            vmovapd (pA), rA0
            vmulpd rA0, rB0, rC00
            vmovapd 32(pA), rA1
            vmulpd rA1, rB0, rC10
            vmovapd 64(pA), rA2
            vmulpd rA2, rB0, rC20
            add $96, pA

            vbroadcastsd 8(pB), rB0
            vmulpd rA0, rB0, rC01
               prefA((pfA))
               add $64, pfA
            vmulpd rA1, rB0, rC11
//               prefB((pfB))
               add $64, pfB
            vmulpd rA2, rB0, rC21
               prefC((pC))

            vbroadcastsd 16(pB), rB0
            vmulpd rA0, rB0, rC02
//                prefetcht0 128(pB)
            vmulpd rA1, rB0, rC12
//                prefetcht0 128(pA)
            vmulpd rA2, rB0, rC22

            vbroadcastsd 24(pB), rB0
            vmulpd rA0, rB0, rC03
               vmovapd (pA), rA0
            vmulpd rA1, rB0, rC13
               vmovapd 32(pA), rA1
            vmulpd rA2, rB0, rC23
               vmovapd 64(pA), rA2
               add $96, pA

            add $32, pB
            sub $1, KK
            jz KDONE
#endif
         ALIGN16
         KLOOP:
            vbroadcastsd (pB), rB0
            FMAC rA0, rB0, rC00
            FMAC rA1, rB0, rC10
            FMAC rA2, rB0, rC20

            vbroadcastsd 8(pB), rB0
            FMAC rA0, rB0, rC01
            FMAC rA1, rB0, rC11
            FMAC rA2, rB0, rC21

            vbroadcastsd 16(pB), rB0
            FMAC rA0, rB0, rC02
            FMAC rA1, rB0, rC12
            FMAC rA2, rB0, rC22

            vbroadcastsd 24(pB), rB0
            FMAC rA0, rB0, rC03
               vmovapd (pA), rA0
            FMAC rA1, rB0, rC13
               vmovapd 32(pA), rA1
            FMAC rA2, rB0, rC23
               vmovapd 64(pA), rA2

            add $32, pB
            add $96, pA
            sub $1, KK
         jnz KLOOP
KDONE:
         mov KK0, KK
         mov pA0, pA
         #ifndef BETA0
            VCOP -128(pC), rC00, rC00
         #endif
         vmovapd rC00, -128(pC)
         #ifndef BETA0
            VCOP -96(pC), rC10, rC10
         #endif
         vmovapd rC10, -96(pC)
         #ifndef BETA0
            VCOP -64(pC), rC20, rC20
         #endif
         vmovapd rC20, -64(pC)
         #ifndef BETA0
            VCOP -32(pC), rC01, rC01
         #endif
         vmovapd rC01, -32(pC)
         #ifndef BETA0
            VCOP (pC), rC11, rC11
         #endif
         vmovapd rC11, (pC)
         #ifndef BETA0
            VCOP 32(pC), rC21, rC21
         #endif
         vmovapd rC21, 32(pC)
         #ifndef BETA0
            VCOP 64(pC), rC02, rC02
         #endif
         vmovapd rC02, 64(pC)
         #ifndef BETA0
            VCOP 96(pC), rC12, rC12
         #endif
         vmovapd rC12, 96(pC)
         #ifndef BETA0
            VCOP 128(pC), rC22, rC22
         #endif
         vmovapd rC22, 128(pC)
         #ifndef BETA0
            VCOP 160(pC), rC03, rC03
         #endif
         vmovapd rC03, 160(pC)
         #ifndef BETA0
            VCOP 192(pC), rC13, rC13
         #endif
         vmovapd rC13, 192(pC)
         #ifndef BETA0
            VCOP 224(pC), rC23, rC23
         #endif
         vmovapd rC23, 224(pC)
         add $384, pC
         sub $1, nnu
      jnz NLOOP
      mov nnu0, nnu
      add incAm, pA0
      mov pA0, pA
      mov pB0, pB
      sub $1, nmu
   jnz MLOOP
 DONE: 
   movq -8(%rsp), %rbp
   movq -16(%rsp), %rbx
   movq -24(%rsp), %r12
   movq -32(%rsp), %r13
   movq -40(%rsp), %r14
   movq -48(%rsp), %r15
   ret
