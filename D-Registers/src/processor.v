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
  
  // Control Unit

  ControlUnit cu(
    .instr(instr)
    );
  
  // Registers
  
  wire [4:0]  rd;
  wire [31:0] rd_value;
  wire [4:0]  rs1;
  wire [31:0] rs1_value;
  wire [4:0]  rs2;
  wire [31:0] rs2_value;
  
  wire reg_write_en;
  
  // Map the register numbers to fields in the instruction 
  assign rs1    = instr[19:15];
  assign rs2    = instr[24:20];
  assign rd     = instr[11:7];
  
  Registers regs(
    .clk(clk),
    .reg_write_en(reg_write_en),
    .rd(rd), 
    .rd_value(rd_value),
    .rs1(rs1),
    .rs2(rs2),
    .rs1_value(rs1_value),
    .rs2_value(rs2_value)
    );
  
  
endmodule