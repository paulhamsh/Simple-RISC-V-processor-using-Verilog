`timescale 1ns / 1ps

module testbench_alu(
    );

reg  [31:0] a;
reg  [31:0] b;
reg   [3:0] opcode;
wire [31:0] result;

// Unit under test

ALU alu(
  .a(a),
  .b(b),
  .alu_op(opcode),
  .result(result)
  );

initial 
  begin
    #5;
    $display("a          op  b        result   status");  

     // add    
    a <= 32'd0;
    b <= 32'd1;
    opcode <= 4'b0000;
    #5;
    $display("%8h %4s  %8h %8h   %s",
              a, "add", b,  result, 
              result == 32'h0000_0001 ? 
              "pass" : "fail");
              
     a <= 32'h7fff_ffff;
     b <= 32'h0000_0001;
     opcode <= 4'b0000;
     #5;
     $display("%8h %4s  %8h %8h   %s",
               a,  "add", b, result, 
               result == 32'h8000_0000 ? 
               "pass" : "fail");
               
     a <= 32'h8000_0000;
     b <= 32'h0000_0001;
     opcode <= 4'b0000;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "add",b, result, 
              result == 32'h8000_0001 ? 
              "pass" : "fail");  
              
     // sub
     a <= 32'h0000_0000;
     b <= 32'h0000_0001;          
     opcode <= 4'b1000;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sub", b,  result, 
              result == 32'hffff_ffff ? 
              "pass" : "fail");  

     a <= 32'hffff_ffff;
     b <= 32'h0000_0001;          
     opcode <= 4'b1000;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sub", b, result, 
              result == 32'hffff_fffe ? 
              "pass" : "fail");  

     a <= 32'h8000_0000;
     b <= 32'h0000_0001;          
     opcode <= 4'b1000;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sub", b, result, 
              result == 32'h7fff_ffff ? 
              "pass" : "fail");

     // or, and, xor
     a <= 32'hf0a7_5c7a;
     b <= 32'hf518_a300;          
     opcode <= 4'b0110;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "or", b, result, 
              result == 32'hf5bf_ff7a ? 
              "pass" : "fail");

     a <= 32'h8080_ff00;
     b <= 32'hff00_faff;          
     opcode <= 4'b0111;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "and", b, result, 
              result == 32'h8000_fa00 ? 
              "pass" : "fail");

     a <= 32'hf0a7_3c7a;
     b <= 32'hf518_330f;          
     opcode <= 4'b0100;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "xor", b, result, 
              result == 32'h05bf_0f75 ? 
              "pass" : "fail");

     // slt 
     a <= 32'h0000_0001;
     b <= 32'h0000_0002;          
     opcode <= 4'b0010;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "slt", b, result, 
              result == 32'h0000_0001 ? 
              "pass" : "fail");

     a <= 32'h8000_0000;
     b <= 32'h0000_0001;          
     opcode <= 4'b0010;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "slt", b, result, 
              result == 32'h0000_0001 ? 
              "pass" : "fail");
              
     // sltu
     a <= 32'h0000_0001;
     b <= 32'h0000_0002;          
     opcode <= 4'b0011;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sltu", b, result, 
              result == 32'h0000_0001 ? 
              "pass" : "fail");

     a <= 32'h8000_0000;
     b <= 32'h0000_0001;          
     opcode <= 4'b0011;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sltu", b, result, 
              result == 32'h0000_0000 ? 
              "pass" : "fail");
              
     // sll
     a <= 32'hffff_ff00;
     b <= 32'h0000_0004;          
     opcode <= 4'b0001;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sll", b, result, 
              result == 32'hffff_f000 ? 
              "pass" : "fail");

     a <= 32'hffff_ff00;
     b <= 32'h0000_0024;          
     opcode <= 4'b0001;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sll", b, result, 
              result == 32'hffff_f000 ? 
              "pass" : "fail");     
                                                               
     // srl
     a <= 32'hffff_ff00;
     b <= 32'h0000_0004;          
     opcode <= 4'b0101;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "srl", b, result, 
              result == 32'h0fff_fff0 ? 
              "pass" : "fail");

     a <= 32'hffff_ff00;
     b <= 32'h0000_0024;          
     opcode <= 4'b0101;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "srl", b, result, 
              result == 32'h0fff_fff0 ? 
              "pass" : "fail");   

     // sra
     a <= 32'hffff_ff00;
     b <= 32'h0000_0004;          
     opcode <= 4'b1101;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sra", b, result, 
              result == 32'hffff_fff0 ? 
              "pass" : "fail"); 

     a <= 32'h7fff_ff00;
     b <= 32'h0000_0008;          
     opcode <= 4'b1101;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sra", b, result, 
              result == 32'h007f_ffff ? 
              "pass" : "fail");               

     a <= 32'h7fff_ff00;
     b <= 32'h0000_0028;          
     opcode <= 4'b1101;
     #5;
     $display("%8h %4s  %8h %8h   %s",
              a, "sra", b, result, 
              result == 32'h007f_ffff ? 
              "pass" : "fail"); 
     $finish;
  end
endmodule

