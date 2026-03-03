`timescale 1ns / 1ps

module testbench_data_memory_misaligned_integrated(
    );

reg clk;
    
// Unit under test

Processor uut(
  .clk(clk)
);

task clock_tick();
  begin
    clk <= 0;
    #5;
    clk <= 1;
    #5;
  end
endtask

initial 
  begin
    $display("x2        x3        mem[0x16]    status");
  
    clock_tick();
       
    $display("%8h  %8h  %2h%2h%2h%2h     %s",
            uut.regs.reg_array[2], uut.regs.reg_array[3],
            uut.dm.mA[5], uut.dm.mB[5], 
            uut.dm.mC[5], uut.dm.mD[5],
            uut.regs.reg_array[2] == 32'h0000_0010 ?
            "pass" : "fail");
 

    clock_tick();

    $display("%8h  %8h  %2h%2h%2h%2h     %s",
            uut.regs.reg_array[2], uut.regs.reg_array[3],
            uut.dm.mA[5], uut.dm.mB[5], 
            uut.dm.mC[5], uut.dm.mD[5],
            uut.regs.reg_array[3] == 32'h0000_330f ?
            "pass" : "fail");  
               
    clock_tick();
                 
    $display("%8h  %8h  %2h%2h%2h%2h     %s",
             uut.regs.reg_array[2], uut.regs.reg_array[3],
             uut.dm.mA[5], uut.dm.mB[5], 
             uut.dm.mC[5], uut.dm.mD[5],
             {uut.dm.mA[5], uut.dm.mB[5], 
              uut.dm.mC[5], uut.dm.mD[5]} == 32'h0f0f_0000 ?
             "pass" : "fail");
             
    clock_tick();
    
    $display("%8h  %8h  %2h%2h%2h%2h     %s",
             uut.regs.reg_array[2], uut.regs.reg_array[3],
             uut.dm.mA[5], uut.dm.mB[5], 
             uut.dm.mC[5], uut.dm.mD[5],
             {uut.dm.mA[5], uut.dm.mB[5], 
              uut.dm.mC[5], uut.dm.mD[5]} == 32'h0f33_0f00 ?
             "pass" : "fail");     
    
    $finish;
  end
endmodule


