`timescale 1ns / 1ps

module testbench_registers_integrated(
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
    $display("rs1   value     rs2    value     rd  status");
    uut.regs.reg_array[1]  <= 32'h11;
    uut.regs.reg_array[2]  <= 32'h22;
    uut.regs.reg_array[3]  <= 32'h33;     
    uut.regs.reg_array[31] <= 32'hff; 
    clk <= 0;
    #5;
    
    $display("%3d   %8h  %3d    %8h %3d  %s",
              uut.rs1, uut.rs1_value, 
              uut.rs2, uut.rs2_value, uut.rd,
              uut.rs1 == 0 && uut.rs1_value == 0 &&
              uut.rs2 == 0 && uut.rs2_value == 0 &&
              uut.rd  == 0 ? "pass" : "fail");   
              
    clk <= 1;
    #5;
    
    $display("%3d   %8h  %3d    %8h %3d  %s",
              uut.rs1, uut.rs1_value, 
              uut.rs2, uut.rs2_value, uut.rd,
              uut.rs1 == 1 && uut.rs1_value == 32'h11 &&
              uut.rs2 == 2 && uut.rs2_value == 32'h22 &&
              uut.rd  == 0 ? "pass" : "fail");  
 
     clock_tick();
     
     $display("%3d   %8h  %3d    %8h %3d  %s",
              uut.rs1, uut.rs1_value, 
              uut.rs2, uut.rs2_value, uut.rd,
              uut.rs1 == 3 && uut.rs1_value == 32'h33 &&
              uut.rs2 == 2 && uut.rs2_value == 32'h22 &&
              uut.rd  == 0 ? "pass" : "fail");                  

     clock_tick();
     
     $display("%3d   %8h  %3d    %8h %3d  %s",
              uut.rs1, uut.rs1_value, 
              uut.rs2, uut.rs2_value, uut.rd,
              uut.rs1 == 31 && uut.rs1_value == 32'hff &&
              uut.rs2 == 31 && uut.rs2_value == 32'hff &&
              uut.rd  == 4 ? "pass" : "fail");  
    $finish;
  end
endmodule

