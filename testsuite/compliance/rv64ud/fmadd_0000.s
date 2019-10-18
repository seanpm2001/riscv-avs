	#==================================================================================================
	#
	# This test program was automatically generated by the MicroTESK tool
	# Generation started: Fri Oct 18 10:41:24 AST 2019
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
	# External Code (riscv_test_macros.rb:533)

test_2:
	li gp, 0x2
	la a0, test_2_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fmadd.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x0
	bne a0, a3, fail
	bne a1, a2, fail
test_3:
	li gp, 0x3
	la a0, test_3_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fmadd.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x1
	bne a0, a3, fail
	bne a1, a2, fail
test_4:
	li gp, 0x4
	la a0, test_4_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fmadd.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x0
	bne a0, a3, fail
	bne a1, a2, fail
test_5:
	li gp, 0x5
	la a0, test_5_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fnmadd.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x0
	bne a0, a3, fail
	bne a1, a2, fail
test_6:
	li gp, 0x6
	la a0, test_6_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fnmadd.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x1
	bne a0, a3, fail
	bne a1, a2, fail
test_7:
	li gp, 0x7
	la a0, test_7_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fnmadd.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x0
	bne a0, a3, fail
	bne a1, a2, fail
test_8:
	li gp, 0x8
	la a0, test_8_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fmsub.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x0
	bne a0, a3, fail
	bne a1, a2, fail
test_9:
	li gp, 0x9
	la a0, test_9_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fmsub.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x1
	bne a0, a3, fail
	bne a1, a2, fail
test_10:
	li gp, 0xa
	la a0, test_10_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fmsub.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x0
	bne a0, a3, fail
	bne a1, a2, fail
test_11:
	li gp, 0xb
	la a0, test_11_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fnmsub.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x0
	bne a0, a3, fail
	bne a1, a2, fail
test_12:
	li gp, 0xc
	la a0, test_12_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fnmsub.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x1
	bne a0, a3, fail
	bne a1, a2, fail
test_13:
	li gp, 0xd
	la a0, test_13_data
	fld ft0, 0(a0)
	fld ft1, 8(a0)
	fld ft2, 16(a0)
	ld a3, 24(a0)
	fnmsub.d ft3, ft0, ft1, ft2
	fmv.x.d a0, ft3
	fsflags a1, zero
	li a2, 0x0
	bne a0, a3, fail
	bne a1, a2, fail

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

	.align 3
test_2_data:
	.double 1.0
	.double 2.5
	.double 1.0
	.double 3.5

	.align 3
test_3_data:
	.double -1.0
	.double -1235.1
	.double 1.1
	.double 1236.1999999999998

	.align 3
test_4_data:
	.double 2.0
	.double -5.0
	.double -2.0
	.double -12.0

	.align 3
test_5_data:
	.double 1.0
	.double 2.5
	.double 1.0
	.double -3.5

	.align 3
test_6_data:
	.double -1.0
	.double -1235.1
	.double 1.1
	.double -1236.1999999999998

	.align 3
test_7_data:
	.double 2.0
	.double -5.0
	.double -2.0
	.double 12.0

	.align 3
test_8_data:
	.double 1.0
	.double 2.5
	.double 1.0
	.double 1.5

	.align 3
test_9_data:
	.double -1.0
	.double -1235.1
	.double 1.1
	.double 0d:00000000000004D2

	.align 3
test_10_data:
	.double 2.0
	.double -5.0
	.double -2.0
	.double -8.0

	.align 3
test_11_data:
	.double 1.0
	.double 2.5
	.double 1.0
	.double -1.5

	.align 3
test_12_data:
	.double -1.0
	.double -1235.1
	.double 1.1
	.double 0d:FFFFFFFFFFFFFB2E

	.align 3
test_13_data:
	.double 2.0
	.double -5.0
	.double -2.0
	.double 8.0
