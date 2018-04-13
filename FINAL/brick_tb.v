`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:22:35 05/30/2017
// Design Name:   bricks
// Module Name:   C:/Users/152/Desktop/NERP_demo-20170530T210710Z-001/NERP_demo/brick_tb.v
// Project Name:  NERP_demo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bricks
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module brick_tb;

	// Inputs
	reg [10:0] bv_pos;
	reg [10:0] bh_pos;
	reg clk;
	reg [2:0] a;
	// Outputs
	wire [23:0] arr;

	// Instantiate the Unit Under Test (UUT)
	bricks uut (
		.bv_pos(bv_pos), 
		.bh_pos(bh_pos), 
		.clk(clk), 
		.arr(arr)
	);

	initial begin
		// Initialize Inputs
		bv_pos = 0;
		bh_pos = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
       a=121/5;
		// Add stimulus here
	
	end
      
endmodule

