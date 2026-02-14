`define data_words        64
`define test_data         "test_data.mem"

module DataMemory(
  input clk,
  // address input, shared by read and write port
  input      [31:0] mem_access_addr,
  input      [31:0] mem_wr_val,
  input             mem_write_en,
  input             mem_read_en,
  input       [2:0] mem_data_size,  
  output reg [31:0] mem_rd_val
  );

  // create the memory
  reg [31:0] d_mem [`data_words - 1:0];
         
  // this needs to split the address range
  // into highest 30 bits (words)
  // and bottom 2 bits (byte in word)
  
  wire [31:2] addr;   
   
  assign addr = mem_access_addr[31 : 2];
     
  initial
    begin
      $readmemb(`test_data, d_mem);
    end
  
  always @(posedge clk) begin
    if (mem_write_en)
      begin  
        d_mem[addr] <= mem_wr_val;
      end
  end

 
  always @(*) begin
    if (mem_read_en)
      mem_rd_val = d_mem[addr];
    else
      mem_rd_val = 32'd0;
  end  
endmodule