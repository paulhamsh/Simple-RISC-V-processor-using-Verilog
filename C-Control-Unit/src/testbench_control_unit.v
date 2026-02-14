`timescale 1ns / 1ps

module testbench_control_unit(
    );

reg [31:0] instr;

// Unit under test

ControlUnit uut(instr);

initial 
  begin
    #5;
    $display("instruction                      opcode  status");
    instr <= 32'b0000000_0000000000_000_00000_1111111;
    #5;
    $display("%32b %7b %s", instr, uut.opcode, 
             uut.opcode == 7'b1111111 ? "pass" : "fail"); 
    #5;
    instr <= 32'b1111111_1111111111_111_11111_0000000;
    #5;
    $display("%32b %7b %s", instr, uut.opcode, 
             uut.opcode == 7'b0000000 ? "pass" : "fail"); 
    #5;
    $display();
    $display("instruction                      funct3  status");
    instr <= 32'b0000000_0000000000_111_00000_0000000;
    #5;
    $display("%32b %3b     %s", instr, uut.funct3, 
             uut.funct3 == 3'b111 ? "pass" : "fail"); 
    #5;
    instr <= 32'b1111111_1111111111_000_11111_1111111;
    #5;
    $display("%32b %3b     %s", instr, uut.funct3, 
             uut.funct3 == 3'b000 ? "pass" : "fail");
    $display();          
    $display("instruction                      funct7  status");     
    #5;
    instr <= 32'b1111111_0000000000_000_00000_0000000;
    #5
    $display("%32b %7b %s", instr, uut.funct7, 
             uut.funct7 == 7'b1111111 ? "pass" : "fail"); 
    #5;
    instr <= 32'b0000000_1111111111_111_11111_1111111;
    #5
    $display("%32b %7b %s", instr, uut.funct7, 
             uut.funct7 == 7'b0000000 ? "pass" : "fail");   
    $finish;
  end
endmodule

