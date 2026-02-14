module Processor(
  input clk
  );

  // Program counter

  reg [31:0] pc_current;
  wire [31:0] pc_next;
     
  initial begin
    pc_current <= 0;
  end
 
  // Update to pc_next on rising clock
  
  always @(posedge clk)
  begin 
    pc_current <= pc_next;   
  end

  assign pc_next = pc_current + 4;
  
  
  // Instruction memory
  
  wire [31:0] instr;
  InstructionMemory im(
    .addr(pc_current),
    .instr(instr)
    ); 
  
  ControlUnit cu(
    .instr(instr)
    );
  
endmodule