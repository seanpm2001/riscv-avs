	#==================================================================================================
	#
	# This test program was automatically generated by the MicroTESK tool
	# Generation started: Fri Oct 18 10:37:55 AST 2019
	#
	# Ivannikov Institute for System Programming of the Russian Academy of Sciences (ISP RAS)
	# 25 Alexander Solzhenitsyn st., Moscow, 109004, Russia
	#
	# http://www.microtesk.org
	# http://forge.ispras.ru/projects/microtesk
	#
	#==================================================================================================

	#==================================================================================================
	# Prologue (riscv_test.rb:231)

	#====================================== .section .text.init =======================================
	.section .text.init
	.align 6
	.weak stvec_handler
	.weak mtvec_handler
	.globl _start
_start:
	j reset_vector
	.align 2
trap_vector:
	csrr t5, mcause
	li t6, 0x8
	beq t5, t6, write_tohost
	li t6, 0x9
	beq t5, t6, write_tohost
	li t6, 0xb
	beq t5, t6, write_tohost
	la t5, mtvec_handler
	beqz t5, 1f
	jr t5
1:
	csrr t5, mcause
	bgez t5, handle_exception
	j other_exception
handle_exception:
other_exception:
1:
	ori gp, gp, 1337
write_tohost:
	nop
	sw gp, tohost, t5
	nop
	j write_tohost
reset_vector:
	csrr a0, mhartid
1:
	bnez a0, 1b
	la t0, 1f
	csrw mtvec, t0
	csrwi satp, 0x0
	.align 2
1:
	la t0, 1f
	csrw mtvec, t0
	li t0, 0xffffffffffffffff
	csrw pmpaddr0, t0
	li t0, 0x1f
	csrw pmpcfg0, t0
	.align 2
1:
	la t0, 1f
	csrw mtvec, t0
	csrwi medeleg, 0x0
	csrwi mideleg, 0x0
	csrwi mie, 0x0
	.align 2
1:
	li gp, 0x0
	la t0, trap_vector
	csrw mtvec, t0
	li a0, 0x1
	slli a0, a0, 0x1f
	bgez a0, 1f
	fence
	li gp, 0x1
	ecall
1:
	la t0, stvec_handler
	beqz t0, 1f
	csrw stvec, t0
	li t0, 0xb109
	csrw medeleg, t0
	csrr t1, medeleg
	bne t0, t1, other_exception
1:
	csrwi mstatus, 0x0
	la t0, 1f
	csrw mepc, t0
	csrr a0, mhartid
	mret
1:

	#==================================================================================================
	# External Code (riscv_test_macros.rb:297)

test_2:
	la ra, tdat
	li sp, 0xffffffffffffffaa
	sb sp, 0(ra)
	lb t5, 0(ra)
	li t4, 0xffffffffffffffaa
	li gp, 0x2
	bne t5, t4, fail
test_3:
	la ra, tdat
	li sp, 0x0
	sb sp, 1(ra)
	lb t5, 1(ra)
	li t4, 0x0
	li gp, 0x3
	bne t5, t4, fail
test_4:
	la ra, tdat
	li sp, 0xffffffffffffefa0
	sb sp, 2(ra)
	lh t5, 2(ra)
	li t4, 0xffffffffffffefa0
	li gp, 0x4
	bne t5, t4, fail
test_5:
	la ra, tdat
	li sp, 0xa
	sb sp, 3(ra)
	lb t5, 3(ra)
	li t4, 0xa
	li gp, 0x5
	bne t5, t4, fail
test_6:
	la ra, tdat8
	li sp, 0xffffffffffffffaa
	sb sp, -3(ra)
	lb t5, -3(ra)
	li t4, 0xffffffffffffffaa
	li gp, 0x6
	bne t5, t4, fail
test_7:
	la ra, tdat8
	li sp, 0x0
	sb sp, -2(ra)
	lb t5, -2(ra)
	li t4, 0x0
	li gp, 0x7
	bne t5, t4, fail
test_8:
	la ra, tdat8
	li sp, 0xffffffffffffffa0
	sb sp, -1(ra)
	lb t5, -1(ra)
	li t4, 0xffffffffffffffa0
	li gp, 0x8
	bne t5, t4, fail
test_9:
	la ra, tdat8
	li sp, 0xa
	sb sp, 0(ra)
	lb t5, 0(ra)
	li t4, 0xa
	li gp, 0x9
	bne t5, t4, fail
test_10:
	la ra, tdat9
	li sp, 0x12345678
	addi tp, ra, -32
	sb sp, 32(tp)
	lb t0, 0(ra)
	li t4, 0x78
	li gp, 0xa
	bne t0, t4, fail
test_11:
	la ra, tdat9
	li sp, 0x3098
	addi ra, ra, -6
	sb sp, 7(ra)
	la tp, tdat10
	lb t0, 0(tp)
	li t4, 0xffffffffffffff98
	li gp, 0xb
	bne t0, t4, fail
test_12:
	li gp, 0xc
	li tp, 0x0
1:
	li ra, 0xffffffffffffffdd
	la sp, tdat
	sb ra, 0(sp)
	lb t5, 0(sp)
	li t4, 0xffffffffffffffdd
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_13:
	li gp, 0xd
	li tp, 0x0
1:
	li ra, 0xffffffffffffffcd
	la sp, tdat
	nop
	sb ra, 1(sp)
	lb t5, 1(sp)
	li t4, 0xffffffffffffffcd
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_14:
	li gp, 0xe
	li tp, 0x0
1:
	li ra, 0xffffffffffffffcc
	la sp, tdat
	nop
	nop
	sb ra, 2(sp)
	lb t5, 2(sp)
	li t4, 0xffffffffffffffcc
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_15:
	li gp, 0xf
	li tp, 0x0
1:
	li ra, 0xffffffffffffffbc
	nop
	la sp, tdat
	sb ra, 3(sp)
	lb t5, 3(sp)
	li t4, 0xffffffffffffffbc
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_16:
	li gp, 0x10
	li tp, 0x0
1:
	li ra, 0xffffffffffffffbb
	nop
	la sp, tdat
	nop
	sb ra, 4(sp)
	lb t5, 4(sp)
	li t4, 0xffffffffffffffbb
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_17:
	li gp, 0x11
	li tp, 0x0
1:
	li ra, 0xffffffffffffffab
	nop
	nop
	la sp, tdat
	sb ra, 5(sp)
	lb t5, 5(sp)
	li t4, 0xffffffffffffffab
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_18:
	li gp, 0x12
	li tp, 0x0
1:
	la sp, tdat
	li ra, 0x33
	sb ra, 0(sp)
	lb t5, 0(sp)
	li t4, 0x33
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_19:
	li gp, 0x13
	li tp, 0x0
1:
	la sp, tdat
	li ra, 0x23
	nop
	sb ra, 1(sp)
	lb t5, 1(sp)
	li t4, 0x23
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_20:
	li gp, 0x14
	li tp, 0x0
1:
	la sp, tdat
	li ra, 0x22
	nop
	nop
	sb ra, 2(sp)
	lb t5, 2(sp)
	li t4, 0x22
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_21:
	li gp, 0x15
	li tp, 0x0
1:
	la sp, tdat
	nop
	li ra, 0x12
	sb ra, 3(sp)
	lb t5, 3(sp)
	li t4, 0x12
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_22:
	li gp, 0x16
	li tp, 0x0
1:
	la sp, tdat
	nop
	li ra, 0x11
	nop
	sb ra, 4(sp)
	lb t5, 4(sp)
	li t4, 0x11
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_23:
	li gp, 0x17
	li tp, 0x0
1:
	la sp, tdat
	nop
	nop
	li ra, 0x1
	sb ra, 5(sp)
	lb t5, 5(sp)
	li t4, 0x1
	bne t5, t4, fail
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
	li a0, 0xef
	la a1, tdat
	sb a0, 3(a1)

	#==================================================================================================
	# Epilogue (riscv_test_macros.rb:883)

	bne zero, gp, pass
fail:
	fence
1:
	beqz gp, 1b
	sll gp, gp, ra
	or gp, gp, ra
	ecall
pass:
	fence
	li gp, 0x1
	ecall
	unimp

	#==================================================================================================
	# Data

	#============================================= .data ==============================================
	.data

	#========================================== Global Data ===========================================
	.align 4
	.pushsection .tohost,"aw",@progbits
	.align 8; .global tohost; tohost: .dword 0;
	.align 8; .global fromhost; fromhost: .dword 0;
	.popsection;
	.align 4
	.globl begin_signature
begin_signature:

tdat:
tdat1:
	.byte 0xEF
tdat2:
	.byte 0xEF
tdat3:
	.byte 0xEF
tdat4:
	.byte 0xEF
tdat5:
	.byte 0xEF
tdat6:
	.byte 0xEF
tdat7:
	.byte 0xEF
tdat8:
	.byte 0xEF
tdat9:
	.byte 0xEF
tdat10:
	.byte 0xEF

	.align 4
	.globl end_signature
end_signature:
	.align 8; .global begin_regstate; begin_regstate:
	.word 128;
	.align 8; .global end_regstate; end_regstate:
	.word 4;
