`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:25:54 05/30/2017
// Design Name:   vga640x480
// Module Name:   C:/Users/152/Desktop/NERP_demo-20170530T210710Z-001/NERP_demo/vga_tb.v
// Project Name:  NERP_demo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga640x480
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_tb;

	// Inputs
	reg dclk;
	reg clr;
	reg [10:0] paddle_v;
	reg [10:0] paddle_h;
	reg [10:0] ball_v;
	reg [10:0] ball_h;
	reg [23:0] bricks;

	// Outputs
	wire hsync;
	wire vsync;
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;

	// Instantiate the Unit Under Test (UUT)
	vga640x480 uut (
		.dclk(dclk), 
		.clr(clr), 
		.paddle_v(paddle_v), 
		.paddle_h(paddle_h), 
		.ball_v(ball_v), 
		.ball_h(ball_h), 
		.bricks(bricks), 
		.hsync(hsync), 
		.vsync(vsync), 
		.red(red), 
		.green(green), 
		.blue(blue)
	);

	initial begin
		// Initialize Inputs
		dclk = 0;
		clr = 0;
		paddle_v = 0;
		paddle_h = 0;
		ball_v = 0;
		ball_h = 0;
	//	bricks = ~24b'0;

		// Wait 100 ns for global reset to finish
		#100;
      // for 
		// Add stimulus here

	end
      
endmodule

