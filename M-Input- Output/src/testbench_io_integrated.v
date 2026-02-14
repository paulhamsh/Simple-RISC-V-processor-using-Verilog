`timescale 1ns / 1ps

module testbench_io_integrated(
    );

reg clk;
reg [4:0] btn;
wire [15:0] led;
reg [15:0] sw;

// Unit under test

Processor uut(
  .clk(clk),
  .LED(led),
  .SW(sw),
  .BTN(btn)
);

initial 
  begin
    clk <= 0;
    btn <= 0;
    sw <= 16'h00ff;
    #140;
    $finish;
  end

always
  begin
    #5 clk <= ~clk;
  end
  
endmodule

