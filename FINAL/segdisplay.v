`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:56 03/19/2013 
// Design Name: 
// Module Name:    segdisplay 
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
module segdisplay(
	input wire segclk,		//7-segment clock
	input wire clr,			//asynchronous reset
	input[3:0] s1,
	input[3:0] s2, 
	input[3:0] s3,
	input[4:0] l,
	output reg [6:0] seg,	//7-segment display LEDs
	output reg [3:0] an		//7-segment display anode enable
	);


reg [3:0] val;

initial 
begin
an=4'b1110;
seg=0;

end

always @(posedge segclk)
begin
	an={an[2:0],an[3]};
	val = (1-an[0])*s1+(1-an[1])*s2+ (1-an[2])*s3+ (1-an[3])*
			(l[0]+l[1]*2 + l[2]*3 + l[3]*4 + l[4]*5);
	
	seg=pattern(val);

end


function [6:0] pattern;
input [3:0] number;
begin
case(number)
	0: pattern = ~ 7'b0111111; 
	1: pattern = ~ 7'b0000110;
	2: pattern = ~ 7'b1011011;
	3: pattern = ~ 7'b1001111;
	4: pattern = ~ 7'b1100110;
	5: pattern = ~ 7'b1101101;
	6: pattern = ~ 7'b1111101;
	7: pattern = ~ 7'b0000111;
	8: pattern = ~ 7'b1111111;
	9: pattern = ~ 7'b1101111;
	default: pattern = 7'b1111111;
	//default: pattern = 7'b0;
endcase
end
endfunction
endmodule
