`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:54 05/18/2017 
// Design Name: 
// Module Name:    paddle 
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
module paddle(
     l_btn,
     r_btn,
     d_btn,
     u_btn,
	  v_pos,
	  h_pos,
	  clk_5
    );

input l_btn;
input r_btn;
input d_btn;
input u_btn;
input clk_5;
output reg[10:0] v_pos;
output reg[10:0] h_pos;
wire [10:0] diff;
reg [9:0] htemp;
reg [3:0] b;

initial 
begin
	v_pos=10;
	h_pos=325;
end

//posedge l_btn or posedge r_btn
always @(posedge clk_5)
begin
		
		h_pos = h_pos + (~r_btn) * (-10) + (~l_btn) * (10);	
		if (h_pos < 10)
		 h_pos = 10;
		
		if (h_pos > 530)
		  h_pos = 530;
		  
	
		v_pos = v_pos + (~u_btn) *(-10) + (~d_btn) *(10);
		if (v_pos < 10)
		 v_pos = 10;
		if (v_pos > 200)
		  v_pos = 200;
		/*diff = htemp - 734;
		if (diff > 734)
		htemp = 734;
		
		assign diff = htemp - 224;
		if (diff < 224)
		htemp = 224;
		
		h_pos = htemp;*/


end



endmodule
