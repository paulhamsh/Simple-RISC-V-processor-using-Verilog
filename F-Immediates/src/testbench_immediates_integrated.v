`timescale 1ns / 1ps

module testbench_immediates_integrated(
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
    uut.regs.reg_array[1] <= 1;
    uut.regs.reg_array[2] <= 2;   
    clk <= 0;

    #5;
    $display("a          op  b        result   status");  
    
    $display("%8h %4b  %8h %8h %s",
              uut.rs1_value, uut.alu_op, 
              uut.rs2_value, uut.alu_out, 
              uut.alu_out == 5 ? "pass" : "fail");
              
    clk <= 1;
    #5;
    
    $display("%8h %4b  %8h %8h %s",
              uut.rs1_value, uut.alu_op, 
              uut.rs2_value, uut.alu_out, 
              uut.alu_out == 3 ? "pass" : "fail");   

    clock_tick();
    
    $display("%8h %4b  %8h %8h %s",
              uut.rs1_value, uut.alu_op, 
              uut.rs2_value, uut.alu_out, 
              uut.alu_out == 7 ? "pass" : "fail");   

    clock_tick();
    
    $display("%8h %4b  %8h %8h %s",
              uut.rs1_value, uut.alu_op, 
              uut.rs2_value, uut.alu_out, 
              uut.alu_out == 32'hffff_fff8 ? 
              "pass" : "fail");   

    clock_tick();
    
    $display("%8h %4b  %8h %8h %s",
              uut.rs1_value, uut.alu_op, 
              uut.rs2_value, uut.alu_out, 
              uut.alu_out == 32'hffff_fffe ? 
              "pass" : "fail");   
    $finish;
  end
endmodule

