`define data_words        64
 
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

  
  reg [7:0] mA [`data_words - 1:0];
  reg [7:0] mB [`data_words - 1:0];
  reg [7:0] mC [`data_words - 1:0];
  reg [7:0] mD [`data_words - 1:0];
           
  wire [31:0] ind, nxt;  
  wire  [1:0] bank_sel;
    
  assign ind = mem_access_addr[31 : 2];
  assign nxt = ind + 1;
  assign bank_sel  = mem_access_addr[1:0];
  
  initial
    begin
      $readmemb("test_data_ramA.mem", mA);      
      $readmemb("test_data_ramB.mem", mB);      
      $readmemb("test_data_ramC.mem", mC);      
      $readmemb("test_data_ramD.mem", mD);
    end
    
  always @(posedge clk) begin
    if (mem_write_en) begin  
      case (mem_data_size)
        3'b000:
          case (bank_sel)
            2'b00:    mD[ind] <= mem_wr_val[7:0];
            2'b01:    mC[ind] <= mem_wr_val[7:0];
            2'b10:    mB[ind] <= mem_wr_val[7:0];
            2'b11:    mA[ind] <= mem_wr_val[7:0];              
          endcase
        3'b001:
          case (bank_sel)
            2'b00: begin
              mD[ind] <= mem_wr_val[7:0];
              mC[ind] <= mem_wr_val[15:8];
            end
            2'b01: begin
              mC[ind] <= mem_wr_val[7:0];
              mB[ind] <= mem_wr_val[15:8];
            end
            2'b10: begin
              mB[ind] <= mem_wr_val[7:0];
              mA[ind] <= mem_wr_val[15:8];
            end
            2'b11: begin
              mA[ind] <= mem_wr_val[7:0];
              // next row of memory
              mD[nxt] <= mem_wr_val[15:8];  
            end
          endcase
        default: // really 3'b010
          case (bank_sel)
            2'b00: begin
              mD[ind] <= mem_wr_val[7:0];
              mC[ind] <= mem_wr_val[15:8];
              mB[ind] <= mem_wr_val[23:16];
              mA[ind] <= mem_wr_val[31:24];
            end
            2'b01: begin
              mC[ind] <= mem_wr_val[7:0];
              mB[ind] <= mem_wr_val[15:8];
              mA[ind] <= mem_wr_val[23:16];
              mD[nxt] <= mem_wr_val[31:24];
            end
            2'b10: begin
              mB[ind] <= mem_wr_val[7:0];
              mA[ind] <= mem_wr_val[15:8];
              mD[nxt] <= mem_wr_val[23:16];
              mC[nxt] <= mem_wr_val[31:24];
            end
            2'b11: begin
              mA[ind] <= mem_wr_val[7:0];
              mD[nxt] <= mem_wr_val[15:8];
              mC[nxt] <= mem_wr_val[23:16];
              mB[nxt] <= mem_wr_val[31:24];
            end
          endcase
      endcase
    end
  end
  
  reg [31:0] m;
  
  always @(*) begin
    if (mem_read_en)
      case (mem_data_size)
        3'b000, 3'b100:   // lb?
          case (bank_sel)
            2'b00: m = { 24'b0, mD[ind] };   
            2'b01: m = { 24'b0, mC[ind] };   
            2'b10: m = { 24'b0, mB[ind] };  
            2'b11: m = { 24'b0, mA[ind] };   
          endcase
        3'b001, 3'b101:   // lh?
          case (bank_sel) 
            2'b00: m = { 16'b0, mC[ind], mD[ind] };
            2'b01: m = { 16'b0, mB[ind], mC[ind] };   
            2'b10: m = { 16'b0, mA[ind], mB[ind] };
            2'b11: m = { 16'b0, mD[nxt], mA[ind] };  
          endcase
        default:  
          case (bank_sel) 
            2'b00: m={mA[ind], mB[ind], mC[ind], mD[ind]}; 
            2'b01: m={mD[nxt], mA[ind], mB[ind], mC[ind]}; 
            2'b10: m={mC[nxt], mD[nxt], mA[ind], mB[ind]}; 
            2'b11: m={mB[nxt], mC[nxt], mD[nxt], mA[ind]};
          endcase
      endcase
     else
       m = 32'd0;
  end  
  
  // make the number sign extended if required
  always @(*) begin
    case (mem_data_size)
      3'b000:  mem_rd_val = { {24{ m[7]  }},  m[7:0]  };   
      3'b001:  mem_rd_val = { {16{ m[15] }},  m[15:0] };  
      default: mem_rd_val = m; 
    endcase
  end
 
endmodule