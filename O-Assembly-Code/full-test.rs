# x1 and x2 are operands
# x3 is the expected result
# x4 is used to store the result

#-----------
# jal
#-----------

addi   x3,  x0,  0x008
jal    x4,  0x00004
bne    x3,  x4,  fail


#-----------
# jalr
#-----------

addi   x3,  x0,  0x018
addi   x2,  x0,  0x018
jalr   x4,  x2,  0x000
bne    x3,  x4,  fail


#-----------
# auipc
#-----------

auipc  x3,  0x00000
addi   x3,  x3,  12
jal    x4,  0x00004
bne    x3,  x4,  fail


#-----------
# lui
#-----------

# sub 0x000_1000 -1 = 0x0000_0fff
# to show that the constant is loaded
# to upper 20 bits of the register

lui    x1,  0x00001
addi   x2,  x0,  1
lui    x3,  0x00fff
srli   x3,  x3,  12
sub    x4,  x1,  x2
bne    x3,  x4,  fail


#-----------
# add
#-----------

# add 1 + 2 = 3
addi   x1,  x0,  1
addi   x2,  x0,  2
addi   x3,  x0,  3
add    x4,  x1,  x2 
bne    x3,  x4,  fail

# add -1 + 2 = 1
addi   x1,  x0,  -1
addi   x2,  x0,  2
addi   x3,  x0,  1
add    x4,  x1,  x2 
bne    x3,  x4,  fail

# add -1 + -1 = -2
addi   x1,  x0,  -1
addi   x2,  x0,  -1
addi   x3,  x0,  -2
add    x4,  x1,  x2 
bne    x3,  x4,  fail

# add -2147483648 + -1 = 2147483647
# wrap around
# 0x8000_0000      = -2147483648
# 0xffff_ffff >> 1 =  2147483647 
lui    x1,  0x80000
addi   x2,  x0,  -1
addi   x3,  x0,  -1
srli   x3,  x3,  1
add    x4,  x1,  x2
bne    x3,  x4,  fail


#-----------
# sub
#-----------

# sub -2147483648 - 1 = 2147483647
# wrap around
lui    x1,  0x80000
addi   x2,  x0,  1
addi   x3,  x0,  -1
srli   x3,  x3,  1
sub    x4,  x1,  x2
bne    x3,  x4,  fail

# sub -10 - -10 = 0
addi   x1,  x0,  -10
addi   x2,  x0,  -10
addi   x3,  x0,  0
sub    x4,  x1,  x2
bne    x3,  x4,  fail

#-----------
# sra
#-----------

# sra 0x8000_0000 >> 2 = 0xe000_0000
lui    x1,  0x80000
addi   x2,  x0,  2
lui    x3,  0xe0000
sra    x4,  x1,  x2
bne    x3,  x4,  fail

#-----------
# srl
#-----------

# srl 0x8000_0000 >> 31 = 1
lui    x1,  0x80000
addi   x2,  x0,  31
addi   x3,  x0,  1
srl    x4,  x1,  x2
bne    x3,  x4,  fail


# srl 0x8000_0000 >> 63 = 1
# wraps at 31
lui    x1,  0x80000
addi   x2,  x0,  63
addi   x3,  x0,  1
srl    x4,  x1,  x2
bne    x3,  x4,  fail

#-----------
# srli
#-----------

# srli 0x8000_0000 >> 63 = 1
lui    x1,  0x80000
addi   x3,  x0,  1
srli   x4,  x1,  63
bne    x3,  x4,  fail

#-----------
# sll
#-----------

# sll 0x0000_0008 << 4 = 0x0000_0080
addi   x1,  x0,  0x008
addi   x2,  x0,  4
addi   x3,  x0,  0x080
sll    x4,  x1,  x2
bne    x3,  x4,  fail

# sll 0x0000_0001 << 31 = 0x8000_0000
addi   x1,  x0,  1
addi   x2,  x0,  31
lui    x3,  0x80000
sll    x4,  x1,  x2
bne    x3,  x4,  fail


#-----------
# slli
#-----------

# slli 0x0000_0008 << 4 = 0x0000_0080
addi   x1,  x0,  0x008
addi   x3,  x0,  0x080
slli   x4,  x1,  4
bne    x3,  x4,  fail

#-----------
# xor
#-----------

# xor 0xf1f1_7878, 0xf0f0_ffff = 0x0101_8787
lui    x1,  0xf1f18
addi   x1,  x1,  0x878
lui    x2,  0xf0f10
addi   x2,  x2,  0xfff
lui    x3,  0x01018
addi   x3,  x3,  0x787
xor    x4,  x1,  x2
bne    x3,  x4,  fail

#-----------
# xori
#-----------

# xori 0x878, 0xfff = 0x787
addi   x1,  x0,  0x878
addi   x3,  x0,  0x787
xori   x4,  x1,  0xfff 
bne    x3,  x4,  fail

#-----------
# or
#-----------

# or 0xf1f1_7878, 0xf0f0_8787 = 0xf1f1_ffff
lui    x1,  0xf1f18
addi   x1,  x1,  0x878
lui    x2,  0xf0f08
addi   x2,  x2,  0x787
lui    x3,  0xf1f20
addi   x3,  x3,  0xfff
or     x4,  x1,  x2
bne    x3,  x4,  fail

#-----------
# ori
#-----------

# ori 0x878, 0x787 = 0xffff_ffff
addi   x1,  x0,  0x878
addi   x3,  x0,  0xfff
ori    x4,  x1,  0x787 
bne    x3,  x4,  fail

#-----------
# and
#-----------

# and 0xf1f1_7878, 0xf0f0_8787 = 0xf0f0_0000
lui    x1,  0xf1f18
addi   x1,  x1,  0x878
lui    x2,  0xf0f08
addi   x2,  x2,  0x787
lui    x3,  0xf0f00
addi   x3,  x3,  0x000
and    x4,  x1,  x2
bne    x3,  x4,  fail


#-----------
# slt
#-----------

# slt -1, 2
addi   x1,  x0,  -1
addi   x2,  x0,  2
addi   x3,  x0,  1
slt    x4,  x1,  x2
bne    x3,  x4,  fail

#-----------
# sltu
#-----------

# sltu -1, 2
addi   x1,  x0,  -1
addi   x2,  x0,  2
addi   x3,  x0,  0
sltu   x4,  x1,  x2
bne    x3,  x4,  fail

#-----------
# slti
#-----------

# slti -1, 2
addi   x1,  x0,  -1
addi   x3,  x0,  1
slti   x4,  x1,  2
bne    x3,  x4,  fail

#-----------
# sltiu
#-----------

# sltiu -1, 2
addi   x1,  x0,  -1
addi   x3,  x0,  0
sltiu  x4,  x1,  2
bne    x3,  x4,  fail

#-----------
# sb & lw
#-----------

# Store 0x808f_707f at 0
addi   x1,  x0,  0x07f
sb     x1,  0(x0)
addi   x1,  x0,  0x070
sb     x1,  1(x0)
addi   x1,  x0,  0x08f
sb     x1,  2(x0)
addi   x1,  x0,  0x080
sb     x1,  3(x0)
lui    x3,  0x808f7
addi   x3,  x3, 0x07f
lw     x4,  0(x0)
bne    x3,  x4,  fail

#-----------
# sb & lw
#-----------

# Store 0xf8f7_07f7 at 4
addi   x1,  x0,  0x7f7
sh     x1,  4(x0)
addi   x1,  x0,  0x8f7
sh     x1,  6(x0)
lui    x3,  0xf8f70
addi   x3,  x3,  0x7f7
lw     x4,  4(x0)
bne    x3,  x4,  fail

#-----------
# lhu
#-----------
# lhu - half-word aligned
# 0xf8f7_07f7 => 0x0000_07f7 
lui    x1,  0xf8f70
addi   x1,  x1,  0x7f7
sw     x1,  4(x0)
addi   x3,  x0,  0x7f7
lhu    x4,  4(x0)
bne    x3,  x4,  fail

# lhu - half-word aligned
# 0xf7f6_f5f4 => 0x0000_f7f6 
lui    x1,  0xf7f6f
addi   x1,  x1,  0x5f4
sw     x1,  4(x0)
lui    x3,  0x0000f
addi   x3,  x3,  0x7f6
lhu    x4,  6(x0)
bne    x3,  x4,  fail

#-----------
# lh
#-----------
# lh - word aligned
# 0xf7f6_f5f4 => 0xffff_f7f6 
lui    x1,  0xf7f6f
addi   x1,  x1,  0x5f4
sw     x1,  4(x0)
lui    x3,  0xfffff
addi   x3,  x3,  0x5f4
lh     x4,  4(x0)
bne    x3,  x4,  fail

# lh - misaligned
# 0xf7f6_f5f4 => 0xffff_f6f5 
lui    x1,  0xf7f6f
addi   x1,  x1,  0x5f4
sw     x1,  4(x0)
lui    x3,  0xfffff
addi   x3,  x3,  0x6f5
lh     x4,  5(x0)
bne    x3,  x4,  fail

#-----------
# branch
#-----------

# order br1, br4, br2, br3, br5
addi   x1,  x0,  1
addi   x2,  x0,  -1
beq    x1,  x2,  fail
br1:
bne    x1,  x2,  br4
beq    x0,  x0,  fail
br2:
bltu   x2,  x1,  fail
br3:
blt    x2,  x1,  br5
beq    x0,  x0,  fail
br4:
bge    x1,  x2,  br2
beq    x0,  x0,  fail
br5:
bgeu   x2,  x1,  br6
beq    x0,  x0,  fail
br6:


success:
beq    x0,  x0,  success

fail:
beq    x0,  x0,  fail