`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:10 05/25/2017 
// Design Name: 
// Module Name:    bricks 
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
module bricks(bv_pos, bh_pos, clk, arr, rst,bdirect_v,bdirect_h
	
    );
output reg [23:0] arr;
input[10:0] bv_pos;
input[10:0] bh_pos;
input clk;
input rst;
input bdirect_h;
input bdirect_v;

reg[2:0] v;
reg[3:0] h;

integer i,j;

initial
begin
	for(i = 0; i< 3; i = i+1)
	begin
		for(j = 0; j< 8; j = j+1)
		begin
				arr[(i*8)+j] = 1;
		end
	end
end

always @(posedge clk or posedge rst)
begin
	if(rst == 1)
	begin
		for(i = 0; i< 3; i = i+1)
		begin
			for(j = 0; j< 8; j = j+1)
			begin
					arr[(i*8)+j] = 1;
			end
		end
	end
	else
	begin
		if(bh_pos >= 64 && bh_pos<640-64 && 480-bv_pos >=64 && 480-bv_pos< 64+96)	
		begin
			h = (bh_pos-64)>>6;
			v = (480-bv_pos-64)>>5;

			if(arr[(v*8)+h] == 1)
				arr[(v*8)+h] = 0;
		end
	end
	
end

endmodule
