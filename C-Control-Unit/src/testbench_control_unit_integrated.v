`timescale 1ns / 1ps

module testbench_control_unit_integrated(
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
    clk <= 0;

    #5;
    $display("opcode  funct3 funct7   status");
    $display("%7b %3b    %7b  %s", 
             uut.cu.opcode, uut.cu.funct3, uut.cu.funct7,
             uut.cu.opcode == 7'b0100101 &&
             uut.cu.funct3 == 3'b010 &&
             uut.cu.funct7 == 7'b1111000 ? "pass" : "fail");

    clk <= 1;
    #5;
    $display("%7b %3b    %7b  %s",  
             uut.cu.opcode, uut.cu.funct3, uut.cu.funct7,
             uut.cu.opcode == 7'b1011010 &&
             uut.cu.funct3 == 3'b101 &&
             uut.cu.funct7 == 7'b0000111 ? "pass" : "fail");
             
    clock_tick();
    
    $display("%7b %3b    %7b  %s", 
            uut.cu.opcode, uut.cu.funct3, uut.cu.funct7,
            uut.cu.opcode == 7'b0000000 &&
            uut.cu.funct3 == 3'b111 &&
            uut.cu.funct7 == 7'b1111111 ? "pass" : "fail"); 
              
    clock_tick();
    
    $display("%7b %3b    %7b  %s", 
            uut.cu.opcode, uut.cu.funct3, uut.cu.funct7,
            uut.cu.opcode == 7'b1111111 &&
            uut.cu.funct3 == 3'b000 &&
            uut.cu.funct7 == 7'b0000000 ? "pass" : "fail"); 
    
    $finish;
  end
endmodule

