`timescale 1ns / 1ps
 
module testbench_data_memory_misaligned(
  );

reg         clk;
reg  [31:0] addr;
reg  [31:0] data_write_val;
wire [31:0] data_read_val;
reg  [2:0]  data_size;
reg         read_en;
reg         write_en;

// Unit under test

DataMemory uut(
  .clk(clk),
  .mem_access_addr(addr),
  .mem_wr_val(data_write_val),
  .mem_write_en(write_en),
  .mem_read_en(read_en),
  .mem_data_size(data_size),  
  .mem_rd_val(data_read_val)
  );

integer i;

task write(input [31:0]add, input [2:0] size, input [31:0] val);
  begin
    for (i = 0; i < 4; i = i + 1) begin
      uut.mA[i] <= 0;
      uut.mB[i] <= 0;
      uut.mC[i] <= 0;
      uut.mD[i] <= 0;
    end
    write_en <= 1;
    read_en <= 0;
    data_write_val <= val;
    addr <= add;
    data_size <= size;

    clk <= 0;
    #5; 
    clk <= 1; 
    #5;
  end
endtask

task read(input [31:0]add, input [2:0] size);
  begin
    for (i = 0; i < 4; i = i + 1) begin
      uut.mD[i] <= 8'hc1 + i * 16;
      uut.mC[i] <= 8'hc1 + i * 16 + 1;
      uut.mB[i] <= 8'hc1 + i * 16 + 2;
      uut.mA[i] <= 8'hc1 + i * 16 + 3;
    end
    write_en <= 0;
    read_en <= 1;
    addr <= add;
    data_size <= size;

    clk <= 0;
    #5; 
    clk <= 1; 
    #5;
  end
endtask

task check_w(input [31:0] val, input [31:0] read_val);
  $display("%4h %2h%2h%2h%2h %2h%2h%2h%2h %2h%2h%2h%2h %8h  %s",
       addr,  
       uut.mA[2], uut.mB[2], uut.mC[2], uut.mD[2],
       uut.mA[1], uut.mB[1], uut.mC[1], uut.mD[1],
       uut.mA[0], uut.mB[0], uut.mC[0], uut.mD[0],
       data_write_val,
       read_val == val ?
       "pass" : "fail");
endtask

task check_r(input [31:0] val);
  $display("%4h %2h%2h%2h%2h %2h%2h%2h%2h %2h%2h%2h%2h %8h  %s",
       addr, 
       uut.mA[2], uut.mB[2], uut.mC[2], uut.mD[2],
       uut.mA[1], uut.mB[1], uut.mC[1], uut.mD[1],
       uut.mA[0], uut.mB[0], uut.mC[0], uut.mD[0],
       data_read_val,
       data_read_val == val ?
       "pass" : "fail");
endtask
    
initial 
  begin
    $display("addr 0x0008   0x0004   0x0000   value     status");
    
    $display("sw");
    write(32'h0004, 3'b010, 32'hf7f6f5f4);
    check_w(32'hf7f6f5f4, 
            {uut.mA[1], uut.mB[1], uut.mC[1], uut.mD[1]});
    write(32'h0005, 3'b010, 32'hf7f6f5f4);
    check_w(32'hf7f6f5f4, 
            {uut.mD[2], uut.mA[1], uut.mB[1], uut.mC[1]});
    write(32'h0006, 3'b010, 32'hf7f6f5f4);
    check_w(32'hf7f6f5f4, 
            {uut.mC[2], uut.mD[2], uut.mA[1], uut.mB[1]});
    write(32'h0007, 3'b010, 32'hf7f6f5f4);
    check_w(32'hf7f6f5f4, 
            {uut.mB[2], uut.mC[2], uut.mD[2], uut.mA[1]});     
    $display();
    
    $display("sh");
    write(32'h0004, 3'b001, 32'hf7f6f5f4);
    check_w(32'h0000f5f4, {16'h0, uut.mC[1], uut.mD[1]});
    write(32'h0005, 3'b001, 32'hf7f6f5f4);
    check_w(32'h0000f5f4, {16'h0, uut.mB[1], uut.mC[1]});
    write(32'h0006, 3'b001, 32'hf7f6f5f4);
    check_w(32'h0000f5f4, {16'h0, uut.mA[1], uut.mB[1]});
    write(32'h0007, 3'b001, 32'hf7f6f5f4);
    check_w(32'h0000f5f4, {16'h0, uut.mD[2], uut.mA[1]});     
    $display();

    $display("sb");
    write(32'h0004, 3'b000, 32'hf7f6f5f4);
    check_w(32'h000000f4, {24'h0, uut.mD[1]});
    write(32'h0005, 3'b000, 32'hf7f6f5f4);
    check_w(32'h000000f4, {24'h0, uut.mC[1]});
    write(32'h0006, 3'b000, 32'hf7f6f5f4);
    check_w(32'h000000f4, {24'h0, uut.mB[1]});
    write(32'h0007, 3'b000, 32'hf7f6f5f4);
    check_w(32'h000000f4, {24'h0, uut.mA[1]});     
    $display();       

    $display("addr 0x0008   0x0004   0x0000   value     status");
    $display("lb");
    read(32'h0004, 3'b000);
    check_r(32'hffffffd1);
    read(32'h0005, 3'b000);
    check_r(32'hffffffd2);
    read(32'h0006, 3'b000);
    check_r(32'hffffffd3);
    read(32'h0007, 3'b000);
    check_r(32'hffffffd4);      
    $display();
 
    $display("lbu");
    read(32'h0004, 3'b100);
    check_r(32'h000000d1);
    read(32'h0005, 3'b100);
    check_r(32'h000000d2);
    read(32'h0006, 3'b100);
    check_r(32'h000000d3);
    read(32'h0007, 3'b100);
    check_r(32'h000000d4);      
    $display(); 
        
    $display("lh");
    read(32'h0004, 3'b001);
    check_r(32'hffffd2d1);
    read(32'h0005, 3'b001);
    check_r(32'hffffd3d2);
    read(32'h0006, 3'b001);
    check_r(32'hffffd4d3);
    read(32'h0007, 3'b001);
    check_r(32'hffffe1d4); 
    $display(); 
 
    $display("lhu");
    read(32'h0004, 3'b101);
    check_r(32'h0000d2d1);
    read(32'h0005, 3'b101);
    check_r(32'h0000d3d2);
    read(32'h0006, 3'b101);
    check_r(32'h0000d4d3);
    read(32'h0007, 3'b101);
    check_r(32'h0000e1d4); 
    $display(); 
    
    $display("lw");
    read(32'h0004, 3'b010);
    check_r(32'hd4d3d2d1);
    read(32'h0005, 3'b010);
    check_r(32'he1d4d3d2);
    read(32'h0006, 3'b010);
    check_r(32'he2e1d4d3);
    read(32'h0007, 3'b010);
    check_r(32'he3e2e1d4); 
    $display();     
                                                                                                
    $finish;
  end
endmodule
