`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:47 05/25/2017 
// Design Name: 
// Module Name:    ball 
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
module ball(
rst,pause,clk,dh,dv,v_pos,h_pos
    );
input rst;
input pause;
input clk;
input dv; // dv : 1: up, 0: down
input dh;  // dh: 1:right, 0, left
output reg[10:0] v_pos;
output reg[10:0] h_pos;


initial
begin
	v_pos = 300;
   h_pos = 200;
end

always @(posedge clk or posedge rst )
begin
	if (rst==1)
	begin
		v_pos = 300;
		h_pos = 200;	
	end 
	else
		begin
		if(pause ==0)
		begin
		  //v_pos = v_pos + dv * (-2) + (~dv) * (2) ;
		  //h_pos = h_pos + dh * 2 + (~dh) * (-2) ;
		  if (dh == 1)
		  h_pos = h_pos + 2;
		  else
		  h_pos = h_pos -2;
		  
		  if (dv == 1)
		  v_pos = v_pos +2;
		  else
		  v_pos = v_pos - 2;
	  end
  end
	
end
endmodule
