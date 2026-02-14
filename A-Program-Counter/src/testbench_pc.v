`timescale 1ns / 1ps

module testbench_pc(
    );

reg clk;
    
// Unit under test

processor uut(
  .clk(clk)
);

initial 
  begin
    clk <= 0;
    #5;
    $display("pc_current  pc_next   status");
    $display("%8x    %8x  %s", uut.pc_current, uut.pc_next, 
             uut.pc_current == 32'h0000 && 
             uut.pc_next    == 32'h0004 ? "pass" : "fail");
    clk <= 1;
    #5;
    $display("%8x    %8x  %s", uut.pc_current, uut.pc_next, 
             uut.pc_current == 32'h0004 && 
             uut.pc_next    == 32'h0008 ? "pass" : "fail");
    clk <= 0;
    #5;
    $display("%8x    %8x  %s", uut.pc_current, uut.pc_next, 
             uut.pc_current == 32'h0004 && 
             uut.pc_next    == 32'h0008 ? "pass" : "fail");
    clk <= 1;
    #5;
    $display("%8x    %8x  %s", uut.pc_current, uut.pc_next, 
             uut.pc_current == 32'h0008 && 
             uut.pc_next    == 32'h000c ? "pass" : "fail");
    $finish;
  end
endmodule
