module ControlUnit(
  input      [31:0] instr,
  output reg  [3:0] alu_op,
  output reg        reg_write_en,
  output reg        alu_b_src,
  output reg        alu_a_src,
  output reg  [2:0] branch_cond,
  output reg  [1:0] rd_src,
  output reg        data_read_en,
  output reg        data_write_en,
  output reg  [2:0] data_size
  );

  wire [6:0] opcode;
  wire [2:0] funct3;
  wire [6:0] funct7;

  assign opcode = instr[6:0];
  assign funct3 = instr[14:12];
  assign funct7 = instr[31:25];

  always @(*)
  begin
    case(opcode) 
      7'b011_0011: begin // arithmetic reg
        alu_op         = {funct7[5], funct3};
        reg_write_en   = 1'b1;    // write to rd
        alu_b_src      = 1'b1;    // use rs2
        alu_a_src      = 1'b1;    // use rs1
        branch_cond    = 3'b010;  // no branch 
        rd_src         = 2'b00;   // alu_out  
        data_read_en   = 1'b0;    // no read from memory 
        data_write_en  = 1'b0;    // no write to memory
        data_size      = 3'b000;
      end     
      7'b001_0011: begin // arithemetic imm
        alu_op         = {funct3 == 3'b101 ? 
                          funct7[5] : 0, funct3}; 
        reg_write_en   = 1'b1;    // write to rd
        alu_b_src      = 1'b0;    // use immediate
        alu_a_src      = 1'b1;    // use rs1
        branch_cond    = 3'b010;  // no branch 
        rd_src         = 2'b00;   // alu_out 
        data_read_en   = 1'b0;    // no read from memory 
        data_write_en  = 1'b0;    // no write to memory
        data_size      = 3'b000;
      end            
      7'b110_0011: begin // branch
        alu_op         = 4'b0000; // add
        reg_write_en   = 1'b0;    // no write to rd
        alu_b_src      = 1'b0;    // use immediate
        alu_a_src      = 1'b0;    // pc_current  
        branch_cond    = funct3;  // match funct3
        rd_src         = 2'b00;   // alu_out
        data_read_en   = 1'b0;    // no read from memory 
        data_write_en  = 1'b0;    // no write to memory
        data_size      = 3'b000;
      end
      7'b110_0111: begin // jalr         
        alu_op         = 4'b0000; // add
        reg_write_en   = 1'b1;    // write to rd
        alu_b_src      = 1'b0;    // use immediate
        alu_a_src      = 1'b1;    // use rs1  
        branch_cond    = 3'b011;  // branch always
        rd_src         = 2'b10;   // pc + 4   
        data_read_en   = 1'b0;    // no read from memory 
        data_write_en  = 1'b0;    // no write to memory
        data_size      = 3'b000;
      end    
      7'b110_1111: begin // jal   
        alu_op         = 4'b0000; // add
        reg_write_en   = 1'b1;    // write to rd
        alu_b_src      = 1'b0;    // use immediate
        alu_a_src      = 1'b0;    // pc_current  
        branch_cond    = 3'b011;  // branch always
        rd_src         = 2'b10;   // pc + 4
        data_read_en   = 1'b0;    // no read from memory 
        data_write_en  = 1'b0;    // no write to memory
        data_size      = 3'b000;
      end  
      7'b011_0111: begin  // lui        
        alu_op         = 4'b1001; // pass through alu_b
        reg_write_en   = 1'b1;    // write to rd
        alu_b_src      = 1'b0;    // use immediate
        alu_a_src      = 1'b1;    // use rs1
        branch_cond    = 3'b010;  // no branch
        rd_src         = 2'b00;   // alu_out
        data_read_en   = 1'b0;    // no read from memory 
        data_write_en  = 1'b0;    // no write to memory
        data_size      = 3'b000;
      end       
      7'b001_0111: begin // auipc 
        alu_op         = 4'b0000; // add
        reg_write_en   = 1'b1;    // write to rd
        alu_b_src      = 1'b0;    // use immediate
        alu_a_src      = 1'b0;    // pc_current  
        branch_cond    = 3'b010;  // no branch
        rd_src         = 2'b00;   // alu_out
        data_read_en   = 1'b0;    // no read from memory 
        data_write_en  = 1'b0;    // no write to memory
        data_size      = 3'b000;
      end
      7'b010_0011: begin // store
        alu_op         = 4'b0000;  // add
        reg_write_en   = 1'b0;     // no write to rd
        alu_b_src      = 1'b0;     // use immediate
        alu_a_src      = 1'b1;     // use rs1
        branch_cond    = 3'b010;   // no branch
        rd_src         = 2'b00;    // alu_out
        data_read_en   = 1'b0;     // no read from memory   
        data_write_en  = 1'b1;     // write to memory
        data_size      = funct3;
      end  
      7'b000_0011: begin // load
        alu_op         = 4'b0000;  // add
        reg_write_en   = 1'b1;     // write to rd
        alu_b_src      = 1'b0;     // use immediate
        alu_a_src      = 1'b1;     // use rs1
        branch_cond    = 3'b010;   // no branch
        rd_src         = 2'b01;    // data from memory
        data_read_en   = 1'b1;     // read from memory
        data_write_en  = 1'b0;     // no write to memory
        data_size      = funct3;
      end
      default: begin
        alu_op         = 4'b0000; // add
        reg_write_en   = 1'b0;    // no write to rd
        alu_b_src      = 1'b1;    // use rs2
        alu_a_src      = 1'b1;    // use rs1
        branch_cond    = 3'b010;  // no branch 
        rd_src         = 2'b00;   // alu_out
        data_read_en   = 1'b0;    // no read from memory 
        data_write_en  = 1'b0;    // no write to memory
        data_size      = 3'b000;
      end  
    endcase
  end
endmodule



