module Processor(
  input clk
  );

  // Program counter
  reg  [31:0] pc_current;
  wire [31:0] pc_next;
     
  initial begin
    pc_current <= 0;
  end
 
  // Update to pc_next on rising clock
  always @(posedge clk)
  begin 
    pc_current <= pc_next;   
  end


  // Instruction memory
  wire [31:0] instr;
  InstructionMemory im(
    .addr(pc_current),
    .instr(instr)
    ); 
  
  // Control Unit
  wire [3:0] alu_op;
  wire reg_write_en;
  wire alu_b_src;
  wire alu_a_src;
  wire [2:0] branch_cond;
  
  ControlUnit cu(
    .instr(instr),
    .alu_op(alu_op),
    .reg_write_en(reg_write_en),
    .alu_b_src(alu_b_src),
    .alu_a_src(alu_a_src),
    .branch_cond(branch_cond)
    );
  
  // Registers
  wire [4:0]  rd;
  wire [31:0] rd_value;
  wire [4:0]  rs1;
  wire [31:0] rs1_value;
  wire [4:0]  rs2;
  wire [31:0] rs2_value;
  
 
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
  
  // Immediate
  wire [31:0] immediate;
  
  Imm imm(
      .instr(instr),
      .imm(immediate)
      );
  
 
  // ALU
  wire [31:0] alu_out;
  wire [31:0] alu_b_value;
  wire [31:0] alu_a_value;
  
  assign alu_b_value = alu_b_src == 1 ? 
                       rs2_value : immediate;
  assign alu_a_value = alu_a_src == 1 ?
                       rs1_value : pc_current;
  
  ALU alu(
    .a(alu_a_value),
    .b(alu_b_value),
    .alu_op(alu_op),
    .result(alu_out) 
    );

  // Branch
  wire branch;
  
  Branch br(
    .a(rs1_value),
    .b(rs2_value),
    .branch_cond(branch_cond),
    .branch(branch)
  );
  
  assign rd_value = alu_out;
  
    // MUST CHANGE THIS BIT
  assign pc_next = branch == 1 ? alu_out :  pc_current + 4;
  
  
endmodule