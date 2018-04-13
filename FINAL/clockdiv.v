`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:49:36 03/19/2013 
// Design Name: 
// Module Name:    clockdiv 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clockdiv(
	input wire clk,		//master clock: 50MHz
	input wire clr,		//asynchronous reset
	output wire dclk,		//pixel clock: 25MHz
	output wire segclk,	//7-segment clock: 381.47Hz
	output wire clk1,
	output reg clk2,
	output reg clk3,
	output reg clk4,
	output wire clk5
	);

// 17-bit counter variable
reg [22:0] q;
reg [23:0] ct2;
reg [23:0] ct3;
reg [23:0] ct4;
// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.


initial begin
	ct2 = 0;
	ct3 = 0;
	ct4 = 0;
end

always @(posedge clk)
begin
	// reset condition
	if (clr == 1)
		q <= 0;
	// increment counter by one
	else
		q <= q + 1;
	if(ct2 == 900000)
	begin
		clk2 = ~clk2;
		ct2 = 0;
	end
	else
		ct2 = ct2 + 1;
		
	if(ct3 == 770000)
	begin
		clk3 = ~clk3;
		ct3 = 0;
	end
	else 
		ct3 = ct3+ 1;
	
	if(ct4 == 620000)
	begin
		clk4 = ~clk4;
		ct4 = 0;
	end
	else 
		ct4 = ct4+ 1;
end

// 50Mhz ÷ 2^17 = 381.47Hz
assign segclk = q[17];

assign clk1 = q[20];
assign clk5 = q[19];



// 50Mhz ÷ 2^1 = 25MHz
assign dclk = q[1];

endmodule
