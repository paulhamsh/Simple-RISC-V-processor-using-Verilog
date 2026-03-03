`timescale 1ns / 1ps

module testbench_instruction_memory(
    );

wire [31:0] instr;
reg  [31:0] addr;

// Unit under test

InstructionMemory uut(
  .addr(addr),
  .instr(instr)
);

initial 
  begin
    #5;
    addr <= 32'h0000;
    #5
    $display("address   instruction  status");
    $display("%8h  %8h     %s", addr, uut.instr, 
              uut.instr == 32'hf0f0_a5a5 ? "pass" : "fail"); 
    #5;
    addr <= 32'h0008;
    #5
    $display("%8h  %8h     %s", addr, uut.instr, 
              uut.instr == 32'hff00_ff00 ? "pass" : "fail");    
    
    $finish;
  end
endmodule

