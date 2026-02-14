# Simple-RISC-V-processor-using-Verilog
Simple RISC V processor using Verilog

# Vivado

To create the Vivado projects, download all the files from github to your directory (D:/RVSC in this example)    

Edit  Run-All.tcl to have the correct location of all the project files and the part you are using (PATH and PART)   
```
set ::PATH D:/RVSC
set ::PART xc7a12ticsg325-1L
```

In Vivado TCL console, run

```
source d:/RVSC/Run-All.tcl
```

The directory D:/RVSC should start like this.    

```
dir /b /ad
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
M-Input-Output
N-SOC

dir *.tcl /b
A-Build.tcl
B-Build.tcl
C-Build.tcl
D-Build.tcl
E-Build.tcl
F-Build.tcl
G-Build.tcl
H-Build.tcl
I-Build.tcl
J-Build.tcl
K-Build.tcl
L-Build.tcl
M-Build.tcl
N-Build.tcl
Run-All.tcl
```
