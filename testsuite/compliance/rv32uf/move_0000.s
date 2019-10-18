	#==================================================================================================
	#
	# This test program was automatically generated by the MicroTESK tool
	# Generation started: Fri Oct 18 10:37:14 AST 2019
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
	# External Code (move.rb:72)

test_2:
	csrwi fcsr, 0x1
	li a0, 0x1234
	fscsr a1, a0
	li t4, 0x1
	li gp, 0x2
	bne a1, t4, fail
test_3:
	frcsr a0
	li t4, 0x34
	li gp, 0x3
	bne a0, t4, fail
test_4:
	frflags a0
	li t4, 0x14
	li gp, 0x4
	bne a0, t4, fail
test_5:
	csrrwi a0, frm, 0x2
	li t4, 0x1
	li gp, 0x5
	bne a0, t4, fail
test_6:
	frcsr a0
	li t4, 0x54
	li gp, 0x6
	bne a0, t4, fail
test_7:
	csrrci a0, fflags, 0x4
	li t4, 0x14
	li gp, 0x7
	bne a0, t4, fail
test_8:
	frcsr a0
	li t4, 0x50
	li gp, 0x8
	bne a0, t4, fail
test_10:
	li a1, 0x12345678
	li a2, 0x0
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnj.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0x12345678
	li gp, 0xa
	bne a0, t4, fail
test_11:
	li a1, 0x12345678
	li a2, 0xffffffffffffffff
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnj.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0xffffffff92345678
	li gp, 0xb
	bne a0, t4, fail
test_12:
	li a1, 0x92345678
	li a2, 0x0
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnj.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0x12345678
	li gp, 0xc
	bne a0, t4, fail
test_13:
	li a1, 0x92345678
	li a2, 0xffffffffffffffff
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnj.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0xffffffff92345678
	li gp, 0xd
	bne a0, t4, fail
test_20:
	li a1, 0x12345678
	li a2, 0x0
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnjn.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0xffffffff92345678
	li gp, 0x14
	bne a0, t4, fail
test_21:
	li a1, 0x12345678
	li a2, 0xffffffffffffffff
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnjn.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0x12345678
	li gp, 0x15
	bne a0, t4, fail
test_22:
	li a1, 0x92345678
	li a2, 0x0
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnjn.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0xffffffff92345678
	li gp, 0x16
	bne a0, t4, fail
test_23:
	li a1, 0x92345678
	li a2, 0xffffffffffffffff
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnjn.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0x12345678
	li gp, 0x17
	bne a0, t4, fail
test_30:
	li a1, 0x12345678
	li a2, 0x0
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnjx.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0x12345678
	li gp, 0x1e
	bne a0, t4, fail
test_31:
	li a1, 0x12345678
	li a2, 0xffffffffffffffff
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnjx.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0xffffffff92345678
	li gp, 0x1f
	bne a0, t4, fail
test_32:
	li a1, 0x92345678
	li a2, 0x0
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnjx.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0xffffffff92345678
	li gp, 0x20
	bne a0, t4, fail
test_33:
	li a1, 0x92345678
	li a2, 0xffffffffffffffff
	fmv.s.x ft1, a1
	fmv.s.x ft2, a2
	fsgnjx.s ft0, ft1, ft2
	fmv.x.s a0, ft0
	li t4, 0x12345678
	li gp, 0x21
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

	.align 4
	.globl end_signature
end_signature:
	.align 8; .global begin_regstate; begin_regstate:
	.word 128;
	.align 8; .global end_regstate; end_regstate:
	.word 4;
