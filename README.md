# Single-cycle RISC-V processor using Verilog

A single-cycle RISC V processor written in Verilog    

Supporting files for this book ```RISC-V single-cycle processor using Verilog```   
ISBN-13 ‏ : ‎ 979-8249151010    

<img src="cover.jpg">

All the files for the book are here.     
They are tested with Quartus 13.0sp1 on a DE2 board, and Vivado 2018.2 on a Nexys 4 DDR board.   

# Installation instuctions - Windows

Either clone the repo or down load a zip.   
Assume it is installed at ```d:\RiscV\```    
The folder has each source module as a sub-folder, and one for the Vivado files and one for the Quartus files.   
The module folders need to be copied into the Vivado and Quartus folders.   
This folder should now look like below  

```
D:\RiscV>dir /b
A-Program-Counter
B-Instruction-Memory
C-Control-Unit
D-Registers
E-ALU
F-Immediates
G-Branch
H-Jumps
I-Large-Immediate
J-Data-Word
K-Data-Aligned
L-Data-Misaligned
LICENSE
M-Input-Output
N-SOC
Quartus
README.md
Vivado
```


## Quartus 13.0sp1

Change directory to ```Quartus\scripts```   

Run ```create.bat```

This will make the correct folder structure in the Quartus folder, and copy all the project files.   

The project file for each module is in the ```working``` sub-folder.     

For example
```
d:\RiscV\A-Program-Counter\working\A-Program-Counter.qpf
```
Double click and it will open the Quartus project with an appropriate simulation configured.    

## Vivado 2018.2

Change directory to ```Vivado\scripts```     

Run ```create.bat```   

Edit  Vivado\scripts\Run-All.tcl to have the correct location of all the project files and the part you are using (PATH and PART)   

```
set ::PATH d:/RiscV/Vivado
set ::PART xc7a12ticsg325-1L
```

In Vivado, when opening select Tools / Run Tcl Script... and choose ```RunAll.tcl```   
Or - once Vivado is open in a project, select the TCL console and type    

```
source d:/RiscV/Vivado/scripts/Run-All.tcl
```

Then the project file is in the sub-folder, for example:
```
d:\RiscV\A-Program-Counter\A-Program-Counter.xpr
```


## Waveform entities

```
A-Program-Counter
	clk
	uut/pc_current
	uut/pc_next
B-Instruction-Memory
	clk
	uut/pc_current
	uut/instr
C-Control-Unit
	clk
	uut/cu/instr
	uut/cu/opcode
	uut/cu/funct3
	uut/cu/funct7
D-Registers
	clk
	uut/im/instr
	uut/regs/rd
	uut/regs/rs1
	uut/regs/rs2
	uut/regs/rs1_value
	uut/regs/rs2_value
E-ALU
	clk
	uut/pc_current
	uut/instr
	uut/alu_op
	uut/rs1
	uut/rs1_value
	uut/rs2
	uut/rs2_value
	uut/alu_out
	uut/rd
	uut/rd_value
F-Immediates
	clk
	uut/pc_current
	uut/alu_op
	uut/alu_b_src
	uut/rd
	uut/rs1
	uut/rs2
	uut/rd_value
	uut/rs1_value
	uut/rs2_value
	uut/immediate
	uut/alu_out
G-Branch
	clk
	uut/pc_current
	uut/pc_next
	uut/instr
	uut/alu_op
	uut/rs1_value
	uut/rs2_value
	uut/alu_out
	uut/branch_cond
	uut/branch
H-Jumps
	clk
	uut/pc_current
	uut/instr
	uut/alu_op
	uut/reg_write_en
	uut/alu_b_src
	uut/alu_a_src
	uut/immediate
	uut/branch_cond
	uut/branch
	uut/rd_src
	uut/regs/reg_array[3]
	uut/rd_value
	uut/pc_next
I-Large-Immediate
	clk
	uut/pc_current
	uut/instr
	uut/alu_out
	uut/reg_write_en
	uut/alu_a_value
	uut/alu_b_value
	uut/rd_value
	uut/regs/reg_array[1]
	uut/regs/reg_array[2]
	uut/regs/reg_array[3]
	uut/regs/reg_array[4]
J-Data-Word
	clk
	uut/pc_current
	uut/instr
	uut/data_read_en
	uut/data_write_en
	uut/data_size
	uut/alu_out
	uut/mem_out
	uut/rs2_value
	uut/regs/reg_array[2]
	uut/regs/reg_array[3]
	uut/dm/d_mem[5]
K-Data-Aligned
	clk
	uut/pc_current
	uut/instr
	uut/data_read_en
	uut/data_write_en
	uut/data_size
	uut/alu_out
	uut/mem_out
	uut/rs2_value
	uut/regs/reg_array[2]
	uut/regs/reg_array[3]
	uut/dm/d_mem[5]
L-Data-Misaligned
	clk
	uut/pc_current
	uut/instr
	uut/data_read_en
	uut/data_write_en
	uut/data_size
	uut/alu_out
	uut/mem_out
	uut/rs2_value
	uut/regs/reg_array[2]
	uut/regs/reg_array[3]
	uut/dm/mA[5]
	uut/dm/mB[5]
	uut/dm/mC[5]
	uut/dm/mD[5]
M-Input-Output
	clk
	uut/pc_current
	uut/SW
	uut/alu_op
	uut/alu_out
	uut/io1_en
	uut/led_out
	uut/LED
	uut/regs/reg_array[4]
	uut/regs/reg_array[6]
N-SOC
	clk
	uut/pc_current
	uut/SW
	uut/alu_op
	uut/alu_out
	uut/io1_en
	uut/led_out
	uut/LED
	uut/regs/reg_array[4]
	uut/regs/reg_array[6]
```
