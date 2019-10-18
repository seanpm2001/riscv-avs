	#==================================================================================================
	#
	# This test program was automatically generated by the MicroTESK tool
	# Generation started: Fri Oct 18 10:38:44 AST 2019
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
	# External Code (jalr.rb:61)

test_2:
	li gp, 0x2
	li t0, 0x0
	la t1, target_2
	jalr t0, t1, 0
linkaddr_2:
	j fail
target_2:
	la t1, linkaddr_2
	bne t0, t1, fail
test_4:
	li gp, 0x4
	li tp, 0x0
1:
	la t1, 2f
	jalr s3, t1, 0
	bne zero, gp, fail
2:
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_5:
	li gp, 0x5
	li tp, 0x0
1:
	la t1, 2f
	nop
	jalr s3, t1, 0
	bne zero, gp, fail
2:
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
test_6:
	li gp, 0x6
	li tp, 0x0
1:
	la t1, 2f
	nop
	nop
	jalr s3, t1, 0
	bne zero, gp, fail
2:
	addi tp, tp, 1
	li t0, 0x2
	bne tp, t0, 1b
	.align 2
	.option push
	.option norvc
test_7:
	li t0, 0x1
	la t1, 1f
	jalr zero, t1, -4
	addi t0, t0, 1
	addi t0, t0, 1
	addi t0, t0, 1
	addi t0, t0, 1
1:
	addi t0, t0, 1
	addi t0, t0, 1
	li t4, 0x4
	li gp, 0x7
	bne t0, t4, fail
	.option pop

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
