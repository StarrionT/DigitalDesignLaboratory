`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:28:25 03/19/2013 
// Design Name: 
// Module Name:    NERP_demo_top 
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
module NERP_demo_top(
	input wire[1:0] sw,
	input wire r_btn,
	input wire l_btn,
	input wire d_btn,
	input wire u_btn,
	input wire clk,			//master clock = 50MHz
	input wire clr,			//right-most pushbutton for reset
	output wire [6:0] seg,	//7-segment display LEDs
	output wire [3:0] an,	//7-segment display anode enable
	output wire dp,			//7-segment display decimal point
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [1:0] blue,	//blue vga output - 2 bits
	output wire hsync,		//horizontal sync out
	output wire vsync			//vertical sync out
	);


reg game_over;
wire [23:0] barr;
// 7-segment clock interconnect
wire segclk;

// VGA display clock interconnect
wire dclk;

// Paddle & Ball clock
wire pbclk;

// Bricks & Ball reset
wire bbrst; 

//Clocks for each level
wire clk_1;
wire clk_2;
wire clk_3;
wire clk_4;
wire clk_5;
reg level_up;

// disable the 7-segment decimal points
assign dp = 1;



wire[10:0] pv_pos;
wire[10:0] ph_pos;
wire[10:0] bv_pos;
wire[10:0] bh_pos;
reg direct_v;
reg direct_h;	

//current grid coord
reg[4:0] vc;
reg[4:0] hc;
//previoud grid coord
reg[4:0] vp;
reg[4:0] hp;

//for 7-segment display
reg[3:0] score1;
reg[3:0] score2;
reg[3:0] score3;
reg[4:0] level;


wire pause;
wire pause_btn;
wire left_btn;
wire right_btn;
wire up_btn;
wire down_btn;


// generate 7-segment clock & display clock
clockdiv U1(
	.clk(clk),
	.clr(clr),
	.segclk(segclk),
	.dclk(dclk),
	.clk1(clk_1),
	.clk2(clk_2),
	.clk3(clk_3),
	.clk4(clk_4),
	.clk5(clk_5)
	);

// 7-segment display controller
segdisplay U2(
	.segclk(segclk),
	.clr(clr),
	.s1(score1),
	.s2(score2),
	.s3(score3),
	.l(level),
	.seg(seg),
	.an(an)
	);

// VGA controller
vga640x480 U3(
	.dclk(dclk),
	.clr(clr),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue),
	.paddle_v(pv_pos),
	.paddle_h(ph_pos),
	.ball_v(bv_pos),
	.ball_h(bh_pos), 
	.barr(barr),
	.gameover(game_over)
	);
	
paddle PD(
	.l_btn(left_btn),
	.r_btn(right_btn),
	.u_btn(up_btn),
	.d_btn(down_btn),
	.v_pos(pv_pos),
	.h_pos(ph_pos),
	.clk_5(pbclk)
);


ball b(
	.rst(bbrst),
	.pause(pause),
	.clk(pbclk),
	.dh(direct_h),
	.dv(direct_v),
	.v_pos(bv_pos),
	.h_pos(bh_pos)
);

bricks bk(
	.clk(clk),
	.bv_pos(bv_pos),
	.bh_pos(bh_pos),
	.bdirect_v(direct_v),
	.bdirect_h(direct_h),
	.arr(barr),
	.rst(bbrst)
);

Debouncer l_btnd(
.clk(clk),
.btn(l_btn),
.btn_state(left_btn)
);

Debouncer r_btnd(
.clk(clk),
.btn(r_btn),
.btn_state(right_btn)
);

Debouncer u_btnd(
.clk(clk),
.btn(u_btn),
.btn_state(up_btn)
);

Debouncer d_btnd(
.clk(clk),
.btn(d_btn),
.btn_state(down_btn)
);

Debouncer p_sw(
.clk(clk),
.btn(sw[0]),
.btn_state(pause_btn)
);


assign pause= pause_btn|game_over;
assign pbclk = level[0]*clk_1 + level[1]*clk_2 + level[2]*clk_3+level[3]*clk_4 + level[4]*clk_5;
assign bbrst = clr | level_up;
integer i ,j;
initial begin
	direct_v=0;
	direct_h=0;
	game_over=0;
	
	vc=(480-bv_pos)>>5;
	hc=bh_pos>>6;
	hp=hc;
	vp=vc;
	
	level = 1;
	score1 = 0;
	score2 = 0;
	score3 = 0;
	level_up = 0;
end

always @(posedge clk)
begin
	level_up = 0;
	vc=(480-bv_pos)>>5;
	hc=(bh_pos)>>6;
	
	if(hc>=1 && hc<=8 && vc >=2 && vc <=4 && barr[(hc-1)+(vc-2)*8]==1)
	begin
		if(hc>hp)
			direct_h=0;
		if(hc<hp)
			direct_h=1;
		if(vc>vp)
			direct_v=1;
		if(vc<vp)
			direct_v=0; 
			
		score1 = score1 + level[0] +level[1]*2 + level[2]*3 + level[3]*4 + level[4]*5;
	end

	if(score1 > 9)
	begin
		score1 = score1 - 10;
		score2 = score2 + 1;
	end
	if(score2 > 9)
	begin
		score2 = score2 -10;
		score3 = score3 + 1;
	end
	if(score3 > 9)
	begin
		score1 = 0;
		score2 = 0;
		score3 = 0;
	end



	hp=hc;
	vp=vc;
	


	if (bh_pos < 5)
		direct_h = 1;
	else if (bh_pos > 625)
		direct_h = 0;

	if (bv_pos > 474  )
		direct_v = 0;

	if(bv_pos >= pv_pos + 20 && bv_pos <= pv_pos + 25 && bh_pos >= ph_pos 
	&& bh_pos <= ph_pos + 100)
	begin
		direct_v = 1;
	end
	
	if( level[4] == 0)
		begin
			i = 0;
			j = 1;
			for(i = 0; i <= 23; i = i+1)
			begin
				if(barr[i] == 1)
					j = 0;
			end
			if(j == 1)
			begin
			  level = level << 1;
			  level_up = 1;
			end
		end
	else
		begin
			i = 0;
			j = 1;
			for(i = 0; i <= 23; i = i+1)
			begin
				if(barr[i] == 1)
					j = 0;
			end
			if(j == 1)
			begin
			  game_over = 1;
			end
		end
		
		
	if(clr==0)
	begin
		if(bv_pos<10)
		begin 
			game_over=1;
		end
	end
	else
	begin 
		score1 = 0;
		score2 = 0;
		score3 = 0;
		level = 1;
		game_over=0;
	end

end





endmodule
