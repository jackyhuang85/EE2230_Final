`timescale 1ns / 1ps

module musicfan(dip2, led, song_sel_out, pause_out, speed_out, dip_out, data_request, data_ack, dip, lcd_rst, lcd_cs, lcd_rw, lcd_di, lcd_d, lcd_e, button_music_pp, display, ftsd_ctl, row_n, col_n, button, clk, rst_n);
	input [5:0]button;
	input button_music_pp;
	output [14:0]display;
	output [3:0]ftsd_ctl;
	output [3:0]row_n;
	output [1:0]speed_out;
	input [3:0]col_n;
	input clk, rst_n;
	output lcd_rst; // LCD reset
	output [1:0] lcd_cs; // LCD frame selection
	output lcd_rw; // LCD read/write control
	output lcd_di; // LCD data/instruction
	output [7:0] lcd_d; // LCD data
	output lcd_e; // LCD enable
	input dip;
	output dip_out;
	output data_request, data_ack;
	output pause_out;
	output [2:0]song_sel_out;
	output [15:0]led;
	input dip2;
	wire [1:0]speed;
	wire clk_de, clk_1us, clk_5Hz, clk_8Hz, clk_2hz;
	wire [3:0]key;
	//wire de_pause, op_pause;
	wire [2:0]song_sel;
	wire pressed;
	wire clk_1hz;
	wire [2:0]ftsd, data0, data1, data2, data3;
	wire [1:0]clk_ftsd;
	assign dip_out = dip;
	assign song_sel_out = song_sel;
	assign speed_out = speed;
	//assign pause_out = button_music_pp;
	clk_div #(
		.counter_width(20),
		.half_cycle(10000000)
	) clk_2Hz(
		.rst_n(rst_n), 
		.clk(clk), 
		.clk_div(clk_2hz)
	);
	fsm_fan_speed FSM_SPEED(
		.key(key), 
		.speed(speed), 
		.clk(clk), 
		.rst_n(rst_n)
	);
	fsm2 FSMLED(
		.clk(clk_2hz),
		.rst_n(rst_n),
		.dip2(dip2),
		.out1(led[15:11]),
		.out2(led[10:6]),
		.out3(led[5:0])
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
	keypad_scan KEYPAD(
		.key(key), 
		.pressed(pressed), 
		.row_n(row_n), 
		.col_n(col_n), 
		.clk(clk), 
		.rst_n(rst_n)
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
	
	clk_div #(
		.counter_width(25),
		.half_cycle(20000000)
	) clk_1Hz(
		.rst_n(rst_n), 
		.clk(clk), 
		.clk_div(clk_1hz)
	);
	
	debounce_circuit DEBOUNCE_PAUSE(
		.debounce_out(de_pause), 
		.clk(clk_de), 
		.rst_n(rst_n), 
		.debounce_in(button_music_pp)
	);
	one_pulse ONE_PAUSE(
		.one_pulse_out(op_pause), 
		.clk(clk), 
		.rst_n(rst_n), 
		.in_trig(de_pause)
	);
	fsm FSM_PAUSE(
		.count_en(pause_out), 
		.clk(clk), 
		.rst_n(rst_n), 
		.btn_press(op_pause)
	);
	song_sel SONG_SELECT(
		.button(button), 
		.song_sel(song_sel), 
		.clk(clk), 
		.rst_n(rst_n)
	);
	shifter SHIFTER(
		.Q0(data0), 
		.Q1(data1), 
		.Q2(data2), 
		.Q3(data3), 
		.clk(clk_1hz), 
		.rst_n(rst_n)
	);
	freqdiv FREQDIV(
		.clk_ftsd_scan(clk_ftsd), 
		.clksys(clk), 
		.rst_n(rst_n)
	);
	scan_ctl SCAN_CTL(
		.ftsd_ctl(ftsd_ctl), 
		.ftsd(ftsd), 
		.in0(data0), 
		.in1(data1), 
		.in2(data2), 
		.in3(data3), 
		.ftsd_ctl_en(clk_ftsd)
	);
	FTSD_song_name FTSD(
		.value(ftsd),
		.song(song_sel),
		.display(display)
	);
endmodule
