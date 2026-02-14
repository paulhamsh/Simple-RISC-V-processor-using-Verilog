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
  wire  [1:0] byte_sel;
  wire        half_sel;
   
  assign addr     = mem_access_addr[31 : 2];
  assign byte_sel = mem_access_addr[1 : 0];
  assign half_sel = byte_sel[1:1];
  
  initial
    begin
      $readmemb(`test_data, d_mem);
    end
  
  always @(posedge clk) begin
    if (mem_write_en) 
      case (mem_data_size)
        3'b000: case (byte_sel)
          2'b00: d_mem[addr][7:0]   <= mem_wr_val[7:0];
          2'b01: d_mem[addr][15:8]  <= mem_wr_val[7:0];
          2'b10: d_mem[addr][23:16] <= mem_wr_val[7:0];
          2'b11: d_mem[addr][31:24] <= mem_wr_val[7:0];              
        endcase
        3'b001: case (half_sel)
          1'b0:  d_mem[addr][15:0]  <= mem_wr_val[15:0];
          1'b1:  d_mem[addr][31:16] <= mem_wr_val[15:0];
        endcase
        default: d_mem[addr] <= mem_wr_val;
      endcase
  end
 
  reg [31:0] m;     // value of memory read
  reg [31:0] se;    // sign extended value
  
  always @(*) begin
    if (mem_read_en)
      begin
        case (mem_data_size)
          3'b100, 3'b000: case (byte_sel) // lbx 
            2'b00: m = { 24'b0, d_mem[addr][7:0]   };   
            2'b01: m = { 24'b0, d_mem[addr][15:8]  };   
            2'b10: m = { 24'b0, d_mem[addr][23:16] };  
            2'b11: m = { 24'b0, d_mem[addr][31:24] };   
            endcase
          3'b101, 3'b001: case (half_sel) // lhx
            1'b0:  m = { 16'b0, d_mem[addr][15:0]  };   
            1'b1:  m = { 16'b0, d_mem[addr][31:16] };  
            endcase
          default: m = d_mem[addr];  
        endcase
  
        case (mem_data_size)
          3'b000:  se = { { 24{m[7]}}, m[7:0]  }; // lb
          3'b001:  se = { {16{m[15]}}, m[15:0] }; // lh
          default: se = m;
        endcase
        mem_rd_val = se;
      end
    else
      mem_rd_val = 32'd0;
  end
  
endmodule