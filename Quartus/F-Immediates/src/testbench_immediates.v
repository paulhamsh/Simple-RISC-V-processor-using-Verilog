`timescale 1ns / 1ps

module testbench_immediates(
    );

reg  [31:0] instr;
wire [31:0] val;

// Unit under test

Imm uut(
  .instr(instr),
  .imm(val)
  );

initial 
  begin
    #5;
    
    // I type
    instr = 32'b0_11111111111_0000000000000_0110011;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000000000000_11111111111 ?
      "pass" : "fail");
 
    // I type - sign extension
    instr = 32'b1_11111111111_0000000000000_0110011;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b111111111111111111111_11111111111 ?
      "pass" : "fail");
                                      
                   
    // S type - upper part
    instr = 32'b0_111111_00000_00000_000_00000_0100011;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000000000000_111111_00000 ?
      "pass" : "fail");

    // S type - lower part
    instr = 32'b0_000000_00000_00000_000_11111_0100011;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000000000000_000000_11111 ?
      "pass" : "fail");
   
    // S type - sign extension
    instr = 32'b1_111111_00000_00000_000_11111_0100011;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b111111111111111111111_111111_11111 ?
      "pass" : "fail");                   


    // U type 
    instr = 32'b1_111111_11111_11111_111_11111_0110111;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b1_111111_11111_11111_111_00000_0000000 ?
      "pass" : "fail");

    // U type 
    instr = 32'b0_101010_10101_01010_101_11111_0010111;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b0_101010_10101_01010_101_00000_0000000 ?
      "pass" : "fail");


    // B type - upper part
    instr = 32'b0_111111_00000_00000_000_0000_0_1100011;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000000000000_111111_0000_0 ?
      "pass" : "fail");

    // B type - lower part
    instr = 32'b0_000000_00000_00000_000_1111_0_1100011;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000000000000_000000_1111_0 ?
      "pass" : "fail");

    // B type - mid part
    instr = 32'b0_000000_00000_00000_000_0000_1_1100011;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000000000001_000000_0000_0 ?
      "pass" : "fail");
      

    // J type - upper part
    instr = 32'b0_1111111111_0_00000000_00000_1101111;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000_00000000_0_1111111111_0 ?
      "pass" : "fail");

    // J type - lower part
    instr = 32'b0_0000000000_0_11111111_00000_1101111;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000_11111111_0_0000000000_0 ?
      "pass" : "fail");

    // J type - mid part
    instr = 32'b0_0000000000_1_00000000_00000_1101111;
    #5;
    $display("%32b %s",
      val, 
      val == 32'b000000000000_00000000_1_0000000000_0 ?
      "pass" : "fail");
                                                             
    $finish;
  end
  
endmodule

