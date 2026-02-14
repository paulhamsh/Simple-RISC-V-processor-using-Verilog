module Imm(
  input      [31:0] instr,
  output reg [31:0] imm
    );
    
  wire [6:0] opcode;
  assign opcode = instr[6:0];
  
  always @(*)
    case (opcode)
      // I type (jalr, arithmetic immediate, load)
      7'b110_0111, 7'b001_0011, 7'b000_0011:  
         imm = { {21{instr[31]}},  instr[30:20] };
      // S type (store)
      7'b010_0011:  
         imm = { {21{instr[31]}}, instr[30:25], 
                     instr[11:7] };
      // B type (branch)
      7'b110_0011: 
        imm = { {20{instr[31]}},  instr[7], 
                    instr[30:25], instr[11:8],  1'b0 };
      // J type (jal)
      7'b110_1111:
        imm = { {12{instr[31]}},  instr[19:12], 
                    instr[20],    instr[30:21], 1'b0 };
      // U type (lui, auipc)
      7'b011_0111, 7'b001_0111:
        imm = {     instr[31],    instr[30:12], 12'b0 }; 
      // R type (arithmetic register)
      7'b011_0011: // not required so default
        imm = { {21{instr[31]}},  instr[30:20] };
      default:     // not required so default
        imm = { {21{instr[31]}},  instr[30:20] };
    endcase    
endmodule

