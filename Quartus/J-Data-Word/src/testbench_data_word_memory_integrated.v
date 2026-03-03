`timescale 1ns / 1ps

module testbench_data_word_memory_integrated(
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
    clock_tick();
 
    $display("lw  reg       value      status");
    $display("    x%1d        %8h     %s",
              2, uut.regs.reg_array[2], 
              uut.regs.reg_array[2] == 32'h0000_0010 ?
              "pass" : "fail");

    clock_tick();
    
    $display("    x%1d        %8h     %s",
              3, uut.regs.reg_array[3], 
              uut.regs.reg_array[3] == 32'h0000_000c ?
              "pass" : "fail");

    clock_tick();
   
    $display("sw  addr      value      status");
    $display("    %8h  %8h     %s",
              32'h0014, uut.dm.d_mem[5], 
              uut.dm.d_mem[5] == 32'h0000_0010 ?
              "pass" : "fail");
    $finish;
  end
endmodule

