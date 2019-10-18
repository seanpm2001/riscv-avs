	#==================================================================================================
	#
	# This test program was automatically generated by the MicroTESK tool
	# Generation started: Fri Oct 18 10:42:51 AST 2019
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
	# External Code (riscv_test_macros.rb:92)

test_2:
	li ra, 0x1
	slli t5, ra, 0x0
	li t4, 0x1
	li gp, 0x2
	bne t5, t4, fail
test_3:
	li ra, 0x1
	slli t5, ra, 0x1
	li t4, 0x2
	li gp, 0x3
	bne t5, t4, fail
test_4:
	li ra, 0x1
	slli t5, ra, 0x7
	li t4, 0x80
	li gp, 0x4
	bne t5, t4, fail
test_5:
	li ra, 0x1
	slli t5, ra, 0xe
	li t4, 0x4000
	li gp, 0x5
	bne t5, t4, fail
test_6:
	li ra, 0x1
	slli t5, ra, 0x1f
	li t4, 0x80000000
	li gp, 0x6
	bne t5, t4, fail
test_7:
	li ra, 0xffffffffffffffff
	slli t5, ra, 0x0
	li t4, 0xffffffffffffffff
	li gp, 0x7
	bne t5, t4, fail
test_8:
	li ra, 0xffffffffffffffff
	slli t5, ra, 0x1
	li t4, 0xfffffffffffffffe
	li gp, 0x8
	bne t5, t4, fail
test_9:
	li ra, 0xffffffffffffffff
	slli t5, ra, 0x7
	li t4, 0xffffffffffffff80
	li gp, 0x9
	bne t5, t4, fail
test_10:
	li ra, 0xffffffffffffffff
	slli t5, ra, 0xe
	li t4, 0xffffffffffffc000
	li gp, 0xa
	bne t5, t4, fail
test_11:
	li ra, 0xffffffffffffffff
	slli t5, ra, 0x1f
	li t4, 0xffffffff80000000
	li gp, 0xb
	bne t5, t4, fail
test_12:
	li ra, 0x21212121
	slli t5, ra, 0x0
	li t4, 0x21212121
	li gp, 0xc
	bne t5, t4, fail
test_13:
	li ra, 0x21212121
	slli t5, ra, 0x1
	li t4, 0x42424242
	li gp, 0xd
	bne t5, t4, fail
test_14:
	li ra, 0x21212121
	slli t5, ra, 0x7
	li t4, 0x1090909080
	li gp, 0xe
	bne t5, t4, fail
test_15:
	li ra, 0x21212121
	slli t5, ra, 0xe
	li t4, 0x84848484000
	li gp, 0xf
	bne t5, t4, fail
test_16:
	li ra, 0x21212121
	slli t5, ra, 0x1f
	li t4, 0x1090909080000000
	li gp, 0x10
	bne t5, t4, fail
test_50:
	li ra, 0x1
	slli t5, ra, 0x3f
	li t4, 0x8000000000000000
	li gp, 0x32
	bne t5, t4, fail
test_51:
	li ra, 0xffffffffffffffff
	slli t5, ra, 0x27
	li t4, 0xffffff8000000000
	li gp, 0x33
	bne t5, t4, fail
test_52:
	li ra, 0x21212121
	slli t5, ra, 0x2b
	li t4, 0x909080000000000
	li gp, 0x34
	bne t5, t4, fail
test_17:
	li ra, 0x1
	slli ra, ra, 0x7
	li t4, 0x80
	li gp, 0x11
	bne ra, t4, fail
test_18:
	li tp, 0x0
1:
	li ra, 0x1
	slli t5, ra, 0x7
	addi t1, t5, 0
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
	li t4, 0x80
	li gp, 0x12
	bne t1, t4, fail
test_19:
	li tp, 0x0
1:
	li ra, 0x1
	slli t5, ra, 0xe
	nop
	addi t1, t5, 0
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
	li t4, 0x4000
	li gp, 0x13
	bne t1, t4, fail
test_20:
	li tp, 0x0
1:
	li ra, 0x1
	slli t5, ra, 0x1f
	nop
	nop
	addi t1, t5, 0
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
	li t4, 0x80000000
	li gp, 0x14
	bne t1, t4, fail
test_21:
	li tp, 0x0
1:
	li ra, 0x1
	slli t5, ra, 0x7
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
	li t4, 0x80
	li gp, 0x15
	bne t5, t4, fail
test_22:
	li tp, 0x0
1:
	li ra, 0x1
	nop
	slli t5, ra, 0xe
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
	li t4, 0x4000
	li gp, 0x16
	bne t5, t4, fail
test_23:
	li tp, 0x0
1:
	li ra, 0x1
	nop
	nop
	slli t5, ra, 0x1f
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
	li t4, 0x80000000
	li gp, 0x17
	bne t5, t4, fail
test_24:
	slli ra, zero, 0x1f
	li t4, 0x0
	li gp, 0x18
	bne ra, t4, fail
test_25:
	li ra, 0x21
	slli zero, ra, 0x14
	li t4, 0x0
	li gp, 0x19
	bne zero, t4, fail

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

	.align 4
	.globl end_signature
end_signature:
	.align 8; .global begin_regstate; begin_regstate:
	.word 128;
	.align 8; .global end_regstate; end_regstate:
	.word 4;
