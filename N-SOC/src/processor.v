module Processor(
  input clk,
  output [31:0] io_addr,
  output [31:0] io_wr_val,
  output io_write_en,
  output io_read_en,
  output io_data_size,  
  input [31:0] io_rd_val 
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
  
  // Registers and values
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
  
  // Memory and IO
  // Memory mapped 0x0_0000 to 0x1_ffff

  // Memory address decoding
  
  wire mem_en;    
  wire io_en;
  
  assign mem_en = (| alu_out[31:17] == 0) ? 1 : 0; 
  assign io_en = !mem_en;
    
  // Data memory
  wire [31:0] mem_out;

  DataMemory dm(
    .clk(clk),
    .mem_access_addr(alu_out),
    .mem_wr_val(rs2_value),
    .mem_write_en(data_write_en & mem_en),
    .mem_read_en(data_read_en & mem_en),
    .mem_data_size(data_size),  
    .mem_rd_val(mem_out)
   );

  // IO assignments for external module
  assign io_addr = alu_out;
  assign io_write_en = data_write_en & io_en;
  assign io_read_en = data_read_en & io_en; 
  assign io_data_size = data_size;
  assign io_wr_val = rs2_value;
     
  // Chose data memory or IO
  reg  [31:0] data_out;   
  
  always @(*) begin
    if (mem_en)
      data_out = mem_out;
    else 
      data_out = io_rd_val;
  end 
  
  // Register write
  assign rd_value = rd_src == 2'b10 ?
                    pc_current + 4 : 
                      (rd_src == 2'b01 ? 
                       data_out : alu_out);
                   
  // PC next    
  assign pc_next =  branch == 1 ? 
                    alu_out :  pc_current + 4;

endmodule