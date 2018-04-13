`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:14:21 05/12/2017 
// Design Name: 
// Module Name:    Debouncer 
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
module Debouncer(
	input clk, //this is a 50MHz clock provided on FPGA pin PIN_Y2
    input btn,  //this is the input to be debounced
    output reg btn_state  //this is the debounced switch
);
/*This module debounces the pushbutton btn.
 *It can be added to your project files and called as is:
 *DO NOT EDIT THIS MODULE
 */

// Synchronize the switch input to the clock
reg btn_sync_0;
always @(posedge clk) btn_sync_0 <= btn; 
reg btn_sync_1;
always @(posedge clk) btn_sync_1 <= btn_sync_0;

// Debounce the switch
reg [15:0] btn_cnt;
always @(posedge clk)
if(btn_state==btn_sync_1)
    btn_cnt <= 0;
else
begin
    btn_cnt <= btn_cnt + 1'b1;  
    if(btn_cnt == 16'hffff) btn_state <= ~btn_state;  
end
endmodule

