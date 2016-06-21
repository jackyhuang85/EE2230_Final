`timescale 1ns / 1ps

module musicfan(pb_pause, /*pause,*/ song_sel, speed, data_request, data_ack, dip, lcd_rst, lcd_cs, lcd_rw, lcd_di, lcd_d, lcd_e, fan_spd, fan_dic, au_appsel, au_sysclk, au_bck, au_ws, au_data, clk, rst_n);
	input [1:0]speed;
	output fan_spd;
	output fan_dic;
	output au_appsel, au_sysclk, au_bck, au_ws, au_data;
	input clk, rst_n;
	output lcd_rst; // LCD reset
	output [1:0] lcd_cs; // LCD frame selection
	output lcd_rw; // LCD read/write control
	output lcd_di; // LCD data/instruction
	output [7:0] lcd_d; // LCD data
	output lcd_e; // LCD enable
	input dip, pb_pause;
	output data_request, data_ack;
	input [2:0]song_sel;
//	input pause;
	wire clk_de;
	wire clk_1us, clk_5Hz, clk_8Hz;
	wire [19:0]note_div;
	wire [15:0]au_left_data, au_right_data;
	wire clk_1hz;
	wire [2:0]ftsd, data0, data1, data2, data3;
	wire de_pause, op_pause;
	wire pause_en;
	clk_div #(
		.counter_width(5),
		.half_cycle(20)
	) clk_1Us(
		.rst_n(rst_n), 
		.clk(clk), 
		.clk_div(clk_1us)
	);
	
	clk_div #(
		.counter_width(22),
		.half_cycle(4000000)
	) clk_5hz(
		.rst_n(rst_n), 
		.clk(clk), 
		.clk_div(clk_5Hz)
	);
	
	fan_direction FAN_DIRECT(
		.fan_dic(fan_dic), 
		.dip(dip), 
		.clk_us(clk_1us), 
		.clk_5Hz(clk_5Hz),
		.rst_n(rst_n)
		
	);
	
	fan_speed FAN_SPEED(
		.speed_ctl(fan_spd), 
		.speed(speed), 
		.clk_us(clk_1us), 
		.rst_n(rst_n)
	);
	
	lcd_display LCD_DISPLAY(
		.clk(clk), // system clock
		.rst_n(rst_n), // active low reset
		.lcd_rst(lcd_rst), // LCD reset
		.lcd_cs(lcd_cs), // LCD frame selection
		.lcd_rw(lcd_rw), // LCD read/write control
		.lcd_di(lcd_di), // LCD data/instruction
		.lcd_d(lcd_d), // LCD data
		.lcd_e(lcd_e), // LCD enable
		.speed(speed),
		.data_request(data_request),
		.data_ack(data_ack)
	);
	//-----
	clk_div #(
		.counter_width(4),
		.half_cycle(15)
	) clk_De(
		.rst_n(rst_n), 
		.clk(clk), 
		.clk_div(clk_de)
	);
	debounce_circuit DEBOUNCE_PAUSE(
		.debounce_out(de_pause), 
		.clk(clk_de), 
		.rst_n(rst_n), 
		.debounce_in(pb_pause)
	);
	one_pulse ONE_PAUSE(
		.one_pulse_out(op_pause), 
		.clk(clk), 
		.rst_n(rst_n), 
		.in_trig(de_pause)
	);
	fsm FSM_PAUSE(
		.count_en(pause_en), 
		.clk(clk), 
		.rst_n(rst_n), 
		.btn_press(op_pause)
	);
	clk_div #(
		.counter_width(22),
		.half_cycle(2500000)
	) clk_8hz(
		.rst_n(rst_n), 
		.clk(clk), 
		.clk_div(clk_8Hz)
	);
	
	music_player SONG_CTL(
		.song_sel(song_sel),
		.clk_8hz(clk_8Hz),
		.rst_n(rst_n),
		//.clk(clk),
		.pause(pause_en),
		.note_div(note_div)
	);
	
	buzzer_control BUZZER(
		.clk(clk), 
		.rst_n(rst_n), 
		.note_div(note_div), 
		.au_left(au_left_data), 
		.au_right(au_right_data)
	);
	
	speaker_control SPEAKER(
		.au_appsel(au_appsel), 
		.au_sysclk(au_sysclk), 
		.au_bck(au_bck), 
		.au_ws(au_ws), 
		.au_data(au_data), 
		.au_in_left(au_left_data), 
		.au_in_right(au_right_data), 
		.clk(clk), 
		.rst_n(rst_n)
	);
endmodule
