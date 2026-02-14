`timescale 1ns / 1ps

module testbench_jumps_integrated(
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
    $display("pc        x3        rd_val    pc_next   status");  
    uut.regs.reg_array[3] <= 0;
    clk <= 0;
    #5;

    $display("%8h  %8h  %8h  %8h    %4s",
              uut.pc_current, uut.regs.reg_array[3], 
              uut.rd_value, uut.pc_next, 
              uut.regs.reg_array[3] == 32'h0000_0000 &&
              uut.rd_value == 32'h0000_0004 &&
              uut.pc_next  == 32'h0000_0008 ? 
               "pass" : "fail");

    clock_tick();
    
    $display("%8h  %8h  %8h  %8h    %4s",
              uut.pc_current, uut.regs.reg_array[3], 
              uut.rd_value, uut.pc_next, 
              uut.regs.reg_array[3] == 32'h0000_0004 &&
              uut.rd_value == 32'h0000_000c &&
              uut.pc_next  == 32'h0000_0004 ? 
               "pass" : "fail");

    clock_tick();
    
    $display("%8h  %8h  %8h  %8h    %4s",
              uut.pc_current, uut.regs.reg_array[3], 
              uut.rd_value, uut.pc_next, 
              uut.regs.reg_array[3] == 32'h0000_000c &&
              uut.rd_value == 32'h0000_0008 &&
              uut.pc_next  == 32'h0000_000c ? 
              "pass" : "fail");
 
    clock_tick();
    
    $display("%8h  %8h  %8h  %8h    %4s",
              uut.pc_current, uut.regs.reg_array[3], 
              uut.rd_value, uut.pc_next,
              uut.regs.reg_array[3] == 32'h0000_0008 &&
              uut.rd_value == 32'h0000_0010 &&
              uut.pc_next  == 32'h0000_0000 ? 
              "pass" : "fail");
    $finish;
  end
endmodule

