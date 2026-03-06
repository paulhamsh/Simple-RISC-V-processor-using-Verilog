       addi  x3, x0, 0
       jal   x3, la2
la1:   jalr  x3, x0(16)
la2:   jal   x3, la1
la3:   jalr  x3, x0(0)

