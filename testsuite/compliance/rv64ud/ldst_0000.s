	#==================================================================================================
	#
	# This test program was automatically generated by the MicroTESK tool
	# Generation started: Fri Oct 18 10:41:30 AST 2019
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

	# RVTEST_FP_ENABLE
	li a0, 0x2000
	csrs mstatus, a0
	csrwi fcsr, 0x0

	la t0, 1f
	csrw mepc, t0
	csrr a0, mhartid
	mret
1:

	#==================================================================================================
	# External Code (ldst.rb:78)

	la s0, tdat
test_2:
	fld ft2, 0(s0)
	fsd ft2, 16(s0)
	ld a0, 16(s0)
	li t4, 0x40000000bf800000
	li gp, 0x2
	bne a0, t4, fail
test_3:
	fld ft2, 0(s0)
	fsw ft2, 16(s0)
	ld a0, 16(s0)
	li t4, 0x40000000bf800000
	li gp, 0x3
	bne a0, t4, fail
test_4:
	flw ft2, 0(s0)
	fsw ft2, 16(s0)
	ld a0, 16(s0)
	li t4, 0x40000000bf800000
	li gp, 0x4
	bne a0, t4, fail
test_5:
	fld ft2, 8(s0)
	fsd ft2, 16(s0)
	ld a0, 16(s0)
	li t4, 0xc080000040400000
	li gp, 0x5
	bne a0, t4, fail
test_6:
	flw ft2, 8(s0)
	fsd ft2, 16(s0)
	ld a0, 16(s0)
	li t4, 0xffffffff40400000
	li gp, 0x6
	bne a0, t4, fail

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
	.word 0xBF800000
	.word 0x40000000
	.word 0x40400000
	.word 0xC0800000
	.word 0xDEADBEEF
	.word 0xCAFEBABE
	.word 0xABAD1DEA
	.word 0x1337D00D

	.align 4
	.globl end_signature
end_signature:
	.align 8; .global begin_regstate; begin_regstate:
	.word 128;
	.align 8; .global end_regstate; end_regstate:
	.word 4;