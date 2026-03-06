// need testbench to set
// x1 = 1
// x2 = 2
add    x3,  x1, x2
add    x5,  x2, x3
xor    x6,  x3, x5
sll    x24, x6, x2
sltu   x1,  x2, x6
