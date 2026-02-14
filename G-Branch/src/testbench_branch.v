`timescale 1ns / 1ps

module testbench_branch(
    );

reg  [31:0] a_val;
reg  [31:0] b_val;
reg  [2:0]  branch_cond;
wire        branch;

// Unit under test

Branch uut(
  .a(a_val),
  .b(b_val),
  .branch_cond(branch_cond),
  .branch(branch)
  );

initial 
  begin
    #5;
    $display("a        b        cond  branch  desc   status");
    
    a_val <= 32'h0000_0000;
    b_val <= 32'h0000_0000;
    branch_cond <= 3'b000;  
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "beq", 
      branch == 1 ?
      "pass" : "fail");

    a_val <= 32'h0000_0000;
    b_val <= 32'h0000_0001;
    branch_cond <= 3'b000;  
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "beq", 
      branch == 0 ?
      "pass" : "fail");   

    a_val <= 32'h0000_0000;
    b_val <= 32'h0000_0001;
    branch_cond <= 3'b001; 
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "bne", 
      branch == 1 ?
      "pass" : "fail");  

    a_val <= 32'h0000_0000;
    b_val <= 32'h0000_0004;
    branch_cond <= 3'b110;  
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "bltu", 
      branch == 1 ?
      "pass" : "fail");



    a_val <= 32'hffff_ffff;
    b_val <= 32'h0000_0000;
    branch_cond <= 3'b111;  
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "bgeu", 
      branch == 1 ?
      "pass" : "fail");
      
      
    a_val <= 32'hffff_ffff;
    b_val <= 32'hffff_ffff;
    branch_cond <= 3'b111;  
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "bgeu", 
      branch == 1 ?
      "pass" : "fail");
        
        
    a_val <= 32'hffff_ffff;
    b_val <= 32'h0000_0000;
    branch_cond <= 3'b100;  
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "blt", 
      branch == 1 ?
      "pass" : "fail");       
      
        
    a_val <= 32'h0000_0005;
    b_val <= 32'hffff_ffff;
    branch_cond <= 3'b100;  
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "blt", 
      branch == 0 ?
      "pass" : "fail");       
          
          
        
    a_val <= 32'hffff_ffff;
    b_val <= 32'h0000_0000;
    branch_cond <= 3'b101;   
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "bge", 
      branch == 0 ?
      "pass" : "fail");       
          
         
    a_val <= 32'hffff_ffff;
    b_val <= 32'hffff_ffff;
    branch_cond <= 3'b101;   
    #5;
    $display("%8h %8h %3b   %1b      %5s    %5s",
      a_val, b_val, branch_cond, branch, "bge", 
      branch == 1 ?
      "pass" : "fail");          
                                                            
    $finish;
  end
endmodule

