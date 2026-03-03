`timescale 1ns / 1ps

module testbench_registers(
    );

reg         clk;
reg         reg_write_en;
reg  [4:0]  rd;
reg  [31:0] rd_value;
reg  [4:0]  rs1;
reg  [4:0]  rs2;
wire [31:0] rs1_value;
wire [31:0] rs2_value;

// Unit under test

Registers uut(
  .clk(clk),
  .reg_write_en(reg_write_en),
  .rd(rd), 
  .rd_value(rd_value),
  .rs1(rs1),
  .rs2(rs2),
  .rs1_value(rs1_value),
  .rs2_value(rs2_value)
  );

initial 
  begin
    clk <= 0;
    rd <= 5'd1;
    rd_value <= 32'hff00_aa55;
    reg_write_en <= 1;
    rs1 <= 5'd1;
    
    #5;
    clk <= 1;

    $display("store and read rs1: %8h %s", rs1_value,
             rs1_value == 32'hff00_aa55 ? "pass" : "fail");
             

    rd <= 5'd5;
    rd_value <= 32'h1234_5678;
    reg_write_en <= 1;
    rs1 <= 5'd5;
    
    #5;
    clk <= 0;
    #5;
    clk <= 1;

    $display("store and read rs5: %8h %s", rs1_value,
              rs1_value == 32'h1234_5678 ? "pass" : "fail");
    $finish;
  end
endmodule

