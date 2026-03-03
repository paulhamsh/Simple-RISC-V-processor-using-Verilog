module soc(
  input clk,
  input [4:0] BTN,
  input [15:0] SW,
  output reg [15:0] LED
  );

  wire [31:0] io_addr;
  wire [31:0] io_wr_val;
  wire io_write_en;
  wire io_read_en;
  wire io_data_size;  
  reg [31:0] io_rd_val;

  Processor riscv(
    .clk(clk),
    .io_addr(io_addr),
    .io_wr_val(io_wr_val),
    .io_write_en(io_write_en),
    .io_read_en(io_read_en),
    .io_data_size(io_data_size),  
    .io_rd_val(io_rd_val)
  );

  wire [31:0] io1_rd_val;
  wire [31:0] io2_rd_val;
  
  wire io1_en;
  wire io2_en;
  
  assign io1_en = (io_addr == 32'h0002_0004) ? 1 : 0;
  assign io2_en = (io_addr == 32'h0002_0008) ? 1 : 0;  

  assign io1_rd_val = {16'b0, SW[15:0]};
  assign io2_rd_val = {27'b0, BTN[4:0]};

  always @(posedge clk) begin
    if (io2_en & io_write_en) 
      LED <=  io_wr_val[15:0];
  end
  
  always @(*) begin
    if (io1_en)
      io_rd_val = io1_rd_val;
    else if (io2_en)
      io_rd_val = io2_rd_val;
    else
      io_rd_val = 0;
  end 
  
endmodule
