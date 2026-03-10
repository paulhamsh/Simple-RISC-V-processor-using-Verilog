# Single-cycle RISC-V processor using Verilog

A single-cycle RISC V processor written in Verilog.    

Supporting files for this book ```RISC-V single-cycle processor using Verilog```    
ISBN-13 ‏ : ‎ 979-8249151010     


<img src="cover.jpg">


All the files for the book are here.    
They are tested with Quartus 13.0sp1 on a DE2 board, and Vivado 2018.2 on a Nexys 4 DDR board.   

# Installation instuctions 

These are isntructions for Windows.   
The Tcl for Vivado should work in Linux.   
The batch files will need conversion to Linux.   

## General instructions (Vivado or Quartus)    

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

This may be of use if you want to create your own testbench waveforms from scratch.
They are also listed in the Vivado ```.wcfg``` wave configuration file and the Quartus '''wave.do''' file.    

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

## Example implementation report for Vivado Nexys 4 DDR    

```
Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-------------------------------------------------------------------------------------------------
| Tool Version : Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
| Date         : Fri Mar  6 18:06:01 2026
| Host         : 264533-1-1 running 64-bit major release  (build 9200)
| Command      : report_utilization -file soc_utilization_synth.rpt -pb soc_utilization_synth.pb
| Design       : soc
| Device       : 7a100tcsg324-1
| Design State : Synthesized
-------------------------------------------------------------------------------------------------

Utilization Design Information

Table of Contents
-----------------
1. Slice Logic
1.1 Summary of Registers by Type
2. Memory
3. DSP
4. IO and GT Specific
5. Clocking
6. Specific Feature
7. Primitives
8. Black Boxes
9. Instantiated Netlists

1. Slice Logic
--------------

+----------------------------+------+-------+-----------+-------+
|          Site Type         | Used | Fixed | Available | Util% |
+----------------------------+------+-------+-----------+-------+
| Slice LUTs*                | 1028 |     0 |     63400 |  1.62 |
|   LUT as Logic             |  900 |     0 |     63400 |  1.42 |
|   LUT as Memory            |  128 |     0 |     19000 |  0.67 |
|     LUT as Distributed RAM |  128 |     0 |           |       |
|     LUT as Shift Register  |    0 |     0 |           |       |
| Slice Registers            |   51 |     0 |    126800 |  0.04 |
|   Register as Flip Flop    |   51 |     0 |    126800 |  0.04 |
|   Register as Latch        |    0 |     0 |    126800 |  0.00 |
| F7 Muxes                   |   66 |     0 |     31700 |  0.21 |
| F8 Muxes                   |    0 |     0 |     15850 |  0.00 |
+----------------------------+------+-------+-----------+-------+
* Warning! The Final LUT count, after physical optimizations and
full implementation, is typically lower. Run opt_design after
synthesis, if not already completed, for a more realistic count.


1.1 Summary of Registers by Type
--------------------------------

+-------+--------------+-------------+--------------+
| Total | Clock Enable | Synchronous | Asynchronous |
+-------+--------------+-------------+--------------+
| 0     |            _ |           - |            - |
| 0     |            _ |           - |          Set |
| 0     |            _ |           - |        Reset |
| 0     |            _ |         Set |            - |
| 0     |            _ |       Reset |            - |
| 0     |          Yes |           - |            - |
| 0     |          Yes |           - |          Set |
| 0     |          Yes |           - |        Reset |
| 0     |          Yes |         Set |            - |
| 51    |          Yes |       Reset |            - |
+-------+--------------+-------------+--------------+


2. Memory
---------

+----------------+------+-------+-----------+-------+
|    Site Type   | Used | Fixed | Available | Util% |
+----------------+------+-------+-----------+-------+
| Block RAM Tile |    0 |     0 |       135 |  0.00 |
|   RAMB36/FIFO* |    0 |     0 |       135 |  0.00 |
|   RAMB18       |    0 |     0 |       270 |  0.00 |
+----------------+------+-------+-----------+-------+
* Note: Each Block RAM Tile only has one FIFO logic available
and therefore can accommodate only one FIFO36E1 or one FIFO18E1.
However, if a FIFO18E1 occupies a Block RAM Tile, that tile can
still accommodate a RAMB18E1


3. DSP
------

+-----------+------+-------+-----------+-------+
| Site Type | Used | Fixed | Available | Util% |
+-----------+------+-------+-----------+-------+
| DSPs      |    0 |     0 |       240 |  0.00 |
+-----------+------+-------+-----------+-------+


4. IO and GT Specific
---------------------

+-----------------------------+------+-------+-----------+-------+
|          Site Type          | Used | Fixed | Available | Util% |
+-----------------------------+------+-------+-----------+-------+
| Bonded IOB                  |   38 |     0 |       210 | 18.10 |
| Bonded IPADs                |    0 |     0 |         2 |  0.00 |
| PHY_CONTROL                 |    0 |     0 |         6 |  0.00 |
| PHASER_REF                  |    0 |     0 |         6 |  0.00 |
| OUT_FIFO                    |    0 |     0 |        24 |  0.00 |
| IN_FIFO                     |    0 |     0 |        24 |  0.00 |
| IDELAYCTRL                  |    0 |     0 |         6 |  0.00 |
| IBUFDS                      |    0 |     0 |       202 |  0.00 |
| PHASER_OUT/PHASER_OUT_PHY   |    0 |     0 |        24 |  0.00 |
| PHASER_IN/PHASER_IN_PHY     |    0 |     0 |        24 |  0.00 |
| IDELAYE2/IDELAYE2_FINEDELAY |    0 |     0 |       300 |  0.00 |
| ILOGIC                      |    0 |     0 |       210 |  0.00 |
| OLOGIC                      |    0 |     0 |       210 |  0.00 |
+-----------------------------+------+-------+-----------+-------+


5. Clocking
-----------

+------------+------+-------+-----------+-------+
|  Site Type | Used | Fixed | Available | Util% |
+------------+------+-------+-----------+-------+
| BUFGCTRL   |    1 |     0 |        32 |  3.13 |
| BUFIO      |    0 |     0 |        24 |  0.00 |
| MMCME2_ADV |    0 |     0 |         6 |  0.00 |
| PLLE2_ADV  |    0 |     0 |         6 |  0.00 |
| BUFMRCE    |    0 |     0 |        12 |  0.00 |
| BUFHCE     |    0 |     0 |        96 |  0.00 |
| BUFR       |    0 |     0 |        24 |  0.00 |
+------------+------+-------+-----------+-------+


6. Specific Feature
-------------------

+-------------+------+-------+-----------+-------+
|  Site Type  | Used | Fixed | Available | Util% |
+-------------+------+-------+-----------+-------+
| BSCANE2     |    0 |     0 |         4 |  0.00 |
| CAPTUREE2   |    0 |     0 |         1 |  0.00 |
| DNA_PORT    |    0 |     0 |         1 |  0.00 |
| EFUSE_USR   |    0 |     0 |         1 |  0.00 |
| FRAME_ECCE2 |    0 |     0 |         1 |  0.00 |
| ICAPE2      |    0 |     0 |         2 |  0.00 |
| PCIE_2_1    |    0 |     0 |         1 |  0.00 |
| STARTUPE2   |    0 |     0 |         1 |  0.00 |
| XADC        |    0 |     0 |         1 |  0.00 |
+-------------+------+-------+-----------+-------+


7. Primitives
-------------

+----------+------+---------------------+
| Ref Name | Used | Functional Category |
+----------+------+---------------------+
| LUT6     |  445 |                 LUT |
| LUT5     |  258 |                 LUT |
| LUT4     |  175 |                 LUT |
| LUT3     |   77 |                 LUT |
| RAMD64E  |   72 |  Distributed Memory |
| RAMD32   |   72 |  Distributed Memory |
| MUXF7    |   66 |               MuxFx |
| FDRE     |   51 |        Flop & Latch |
| CARRY4   |   35 |          CarryLogic |
| RAMS32   |   24 |  Distributed Memory |
| IBUF     |   22 |                  IO |
| LUT2     |   19 |                 LUT |
| OBUF     |   16 |                  IO |
| RAMS64E  |    8 |  Distributed Memory |
| LUT1     |    2 |                 LUT |
| BUFG     |    1 |               Clock |
+----------+------+---------------------+


8. Black Boxes
--------------

+----------+------+
| Ref Name | Used |
+----------+------+


9. Instantiated Netlists
------------------------

+----------+------+
| Ref Name | Used |
+----------+------+
```
