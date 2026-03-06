# Single-cycle RISC-V processor using Verilog

A single-cycle RISC V processor written in Verilog

Supporting files for this book ```RISC-V single-cycle processor using Verilog```   
ISBN-13 ‏ : ‎ 979-8249151010

# Installation instuctions - Windows

Either clone the repo or down load a zip.   
Assume it is installed at d:\RiscV\   
The folder has each source module as a sub-folder, and one for the Vivado files and one for the Quartus files.   
The module folders need to be copied into the Vivado and Quartus folders.   
This folder should now look like this 
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

So run these commands in a Windows command shell.  

```
robocopy . Vivado /s /xd  Vivado Quartus
robocopy . Quartus /s /xd  Vivado Quartus
```

## Quartus 13.0sp1

The project file for each module is in the ```working``` sub-folder.     

For example
```
E-ALU / working / E-ALU.qpf
```
Double click and it will open the Quartus project with an appropriate simulation configured.    

## Vivado 2018.2


Edit  Vivado\Run-All.tcl to have the correct location of all the project files and the part you are using (PATH and PART)   
```
set ::PATH d:/RiscV
set ::PART xc7a12ticsg325-1L
```

In Vivado TCL console, run

```
source d:/RiscV/Run-All.tcl
```

Then the project file is in the sub-folder, for example:
```
d:\RiscV\A-Program-Counter\A-Program-Counter.xpr
```
