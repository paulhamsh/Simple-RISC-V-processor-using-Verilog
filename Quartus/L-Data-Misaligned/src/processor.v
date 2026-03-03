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
    // last bit set to 0 (for jalr)
    pc_current <= {pc_next[31:1], 1'b0};     
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
  wire [1:0] rd_src;
  wire data_read_en;
  wire data_write_en;
  wire [2:0] data_size;
     
  ControlUnit cu(
    .instr(instr),
    .alu_op(alu_op),
    .reg_write_en(reg_write_en),
    .alu_b_src(alu_b_src),
    .alu_a_src(alu_a_src),
    .branch_cond(branch_cond),
    .rd_src(rd_src),
    .data_read_en(data_read_en),
    .data_write_en(data_write_en),
    .data_size(data_size)
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
  

  // Data memory
  wire [31:0] mem_out;

  DataMemory dm(
    .clk(clk),
    .mem_access_addr(alu_out),
    .mem_wr_val(rs2_value),
    .mem_write_en(data_write_en),
    .mem_read_en(data_read_en),
    .mem_data_size(data_size),  
    .mem_rd_val(mem_out)
   );

  assign rd_value = rd_src == 2'b10 ?
                    pc_current + 4 : 
                      (rd_src == 2'b01 ? 
                       mem_out : alu_out);
                       
  assign pc_next =  branch == 1 ? 
                    alu_out :  pc_current + 4;

endmodule