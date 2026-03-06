// testbench needs to set
//   x1 to 2
//   x2 to 4
//   x3 to -2 (0xffff_fffe)

la1:   bne    x0, x1, la3  // true
la2:   beq    x0, x0, la5  // true
la3:   bltu   x3, x2, la5  // false       
la4:   blt    x3, x2, la2  // true
la5:   beq    x0, x0, la4  // true

