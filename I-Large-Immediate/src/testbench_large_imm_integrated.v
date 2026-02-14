`timescale 1ns / 1ps

module testbench_large_imm_integrated(
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
    $display("reg  reg_value   status");
    clock_tick();

    $display("x%1d   %8h    %4s",
             1, uut.regs.reg_array[1], 
             uut.regs.reg_array[1] == 32'hffff_f000 ?
             "pass" : "fail");

    clock_tick(); 

    $display("x%1d   %8h    %4s",
              2, uut.regs.reg_array[2], 
              uut.regs.reg_array[2] == 32'h1234_5000 ?
              "pass" : "fail");

    clock_tick();

    $display("x%1d   %8h    %4s",
             3,  uut.regs.reg_array[3], 
             uut.regs.reg_array[3] == 32'h1234_5008 ?
             "pass" : "fail");

    clock_tick(); 

    $display("x%1d   %8h    %4s",
             4,  uut.regs.reg_array[4], 
             uut.regs.reg_array[4] == 32'hffff_f00c ?
             "pass" : "fail"); 
 
    $finish;
  end
endmodule

