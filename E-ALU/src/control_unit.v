module ControlUnit(
  input      [31:0] instr,
  output reg [3:0]  alu_op,
  output reg        reg_write_en
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
      7'b011_0011: begin
        alu_op         = {funct7[5], funct3};
        reg_write_en   = 1'b1;    // write to rd
      end               
      default: begin
        alu_op         = 4'b0000;
        reg_write_en   = 1'b0;    // no write to rd
      end  
    endcase
  end
endmodule



