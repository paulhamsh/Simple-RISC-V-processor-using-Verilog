module Processor(
  input clk,
  input [4:0] BTN,
  input [15:0] SW,
  output reg [15:0] LED
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
  
  // Memory and IO
  // Memory mapped 0x0_0000 to 0x1_ffff
  // IO1 mapped    0x2_0004
  // IO2 mapped    0x2_0008
  wire mem_en;
  wire io1_en;
  wire io2_en;
  
  assign mem_en = (| alu_out[31:17] == 0) ? 1 : 0; 
  assign io1_en = (alu_out == 32'h0002_0004) ? 1 : 0;
  assign io2_en = (alu_out == 32'h0002_0008) ? 1 : 0;
  
  reg  [31:0] data_out;   
  wire [31:0] io1_rd_val;
  wire [31:0] io2_rd_val;
  
  // io1 - only a read
  assign io1_rd_val = {16'b0, SW[15:0]};
  
  // io2 - read from buttons, write to LEDs
  assign io2_rd_val = {27'b0, BTN[4:0]};

  always @(posedge clk) begin
    if (io2_en & data_write_en) 
      LED <=  rs2_value[15:0];
  end

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

  always @(*) begin
    if (mem_en)
      data_out = mem_out;
    else if (io1_en)
      data_out = io1_rd_val;
    else if (io2_en)
      data_out = io2_rd_val;
    else
      data_out = 0;
  end 

  assign rd_value = rd_src == 2'b10 ?
                    pc_current + 4 : 
                      (rd_src == 2'b01 ? 
                       data_out : alu_out);
                       
  assign pc_next =  branch == 1 ? 
                    alu_out :  pc_current + 4;

endmodule