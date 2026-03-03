`timescale 1ns / 1ps

module testbench_data_memory_aligned_integrated(
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
    
    $display("%8h  %8h  %8h     %s",
            uut.regs.reg_array[2], uut.regs.reg_array[3],
            uut.dm.d_mem[5],
            uut.regs.reg_array[2] == 32'h0000_0010 ?
            "pass" : "fail");
            
    clock_tick();

    $display("%8h  %8h  %8h     %s",
            uut.regs.reg_array[2], uut.regs.reg_array[3],
            uut.dm.d_mem[5],
            uut.regs.reg_array[3] == 32'h0000_330f ?
            "pass" : "fail");     
     
    clock_tick();
     
    $display("%8h  %8h  %8h     %s",
             uut.regs.reg_array[2], uut.regs.reg_array[3],
             uut.dm.d_mem[5],
             uut.dm.d_mem[5] == 32'h0f0f_0000 ?
             "pass" : "fail");
                  
    clock_tick();
     
    $display("%8h  %8h  %8h     %s",
             uut.regs.reg_array[2], uut.regs.reg_array[3],
             uut.dm.d_mem[5],
             uut.dm.d_mem[5] == 32'h0f0f_330f ?
             "pass" : "fail");     
    
    $finish;
  end
endmodule

