module ControlUnit(
  input [31:0] instr
  );

  wire [6:0] opcode;
  wire [3:0] funct3;
  wire [7:0] funct7;

  assign opcode = instr[6:0];
  assign funct3 = instr[14:12];
  assign funct7 = instr[31:25];

  always @(*)
  begin
    case(opcode) 
      7'b011_0011: begin
      end               
      default: begin
      end  
    endcase
  end
endmodule



