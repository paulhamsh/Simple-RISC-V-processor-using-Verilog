`timescale 1ns / 1ps

module testbench_branch_integrated(
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
    uut.regs.reg_array[1] <= 2;
    uut.regs.reg_array[2] <= 4;
    uut.regs.reg_array[3] <= 32'hffff_fffe; // -2   
    clk <= 0;
    #5;
    $display("comp   rs1  rs2    result   status");  
    
    $display("%4b   %3d  %3d  %8h     %s",
              uut.branch_cond,
              uut.rs1, uut.rs2, uut.pc_next, 
              uut.pc_next == 32'h0000_0008 ? 
              "pass" : "fail");
    clk <= 1;
    #5;
    
    $display("%4b   %3d  %3d  %8h     %s",
              uut.branch_cond,
              uut.rs1, uut.rs2, uut.pc_next, 
              uut.pc_next == 32'h0000_000c ? 
              "pass" : "fail");

    clock_tick();
    
    $display("%4b   %3d  %3d  %8h     %s",
              uut.branch_cond,
              uut.rs1, uut.rs2, uut.pc_next, 
              uut.pc_next == 32'h0000_0004 ? 
              "pass" : "fail");

    clock_tick();
    
    $display("%4b   %3d  %3d  %8h     %s",
              uut.branch_cond,
              uut.rs1, uut.rs2, uut.pc_next, 
              uut.pc_next == 32'h0000_0010 ? 
              "pass" : "fail");

    clock_tick();
    
    $display("%4b   %3d  %3d  %8h     %s",
              uut.branch_cond,
              uut.rs1, uut.rs2, uut.pc_next, 
              uut.pc_next == 32'h0000_000c ? 
              "pass" : "fail");
    $finish;
  end
endmodule

