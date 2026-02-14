module Registers(
  input         clk,
  input         reg_write_en,
  input  [4:0]  rd, 
  input  [31:0] rd_value,
  input  [4:0]  rs1,
  input  [4:0]  rs2,
  output [31:0] rs1_value,
  output [31:0] rs2_value
  );
  
  reg    [31:0] reg_array [31:0];

  integer i;
  initial begin
    for(i = 0; i <= 31; i = i + 1)
      reg_array[i] <= 0;
  end
    
  always @ (posedge clk ) begin
    if (reg_write_en && (rd != 0)) begin
      reg_array[rd] <= rd_value;
    end
  end
  
  assign rs1_value = (rs1 == 0) ? 0 : reg_array[rs1];
  assign rs2_value = (rs2 == 0) ? 0 : reg_array[rs2];

endmodule
