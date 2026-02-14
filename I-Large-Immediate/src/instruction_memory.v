`define inst_words        256
`define test_prog         "test_prog.mem"

module InstructionMemory(
  input  [31:0] addr,
  output [31:0] instr
  );

  // create the memory
  reg [31:0] memory [`inst_words - 1:0];
  
  // memory access will wrap at the limit of the 
  // number of words,  and is word aligned so we 
  // ignore the lower two bits
  
  wire [31:0] word_addr;
  assign word_addr = addr[31 : 2];
  
  initial
    begin
      $readmemb(`test_prog, memory);
    end
  
  assign instr = memory[word_addr]; 
endmodule


