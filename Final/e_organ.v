`timescale 1ns / 1ps

module e_organ(display, ftsd_ctl, row_n, col_n, au_appsel, au_sysclk, au_bck, au_ws, au_data, clk, rst_n);
	output [14:0]display;
	output [3:0]ftsd_ctl;
	output [3:0]row_n;
	output au_appsel, au_sysclk, au_bck, au_ws, au_data;
	input [3:0]col_n;
	input clk, rst_n;
	
	wire clk_debounce;
	wire [1:0]clk_ftsd;
	wire [3:0]key;
	wire key_pressed;
	wire [19:0]pitch_note, pitch_name;
	wire [15:0]au_left, au_right;
	wire [4:0]ftsd;
	wire key_debounce;
	wire clk_keypad;
	freqdiv FREQDIV(
		.clk_keypad(clk_keypad), 
		.clk_debounce(clk_debounce), 
		.clk_ftsd_scan(clk_ftsd), 
		.clksys(clk), 
		.rst_n(rst_n)
	);
	keypad_scan KEYPAD(
		.key(key), 
		.pressed(key_pressed), 
		.row_n(row_n), 
		.col_n(col_n), 
		.clk(clk_keypad), 
		.rst_n(rst_n)
	);
	debounce_circuit DEBOUNCE(
		.debounce_out(key_debounce), 
		.clk(clk_debounce), 
		.rst_n(rst_n), 
		.debounce_in(key_pressed)
	);
	note NOTE(
		.pitch_name(pitch_name),
		.pitch(pitch_note), 
		.key(key), 
		.pressed(key_debounce)
	);
	buzzer_control BUZZER(
		.clk(clk), 
		.rst_n(rst_n), 
		.note_div(pitch_note), 
		.au_left(au_left),
		.au_right(au_right)
	);
	speaker_control SPEAKER(
		.au_appsel(au_appsel), 
		.au_sysclk(au_sysclk), 
		.au_bck(au_bck), 
		.au_ws(au_ws), 
		.au_data(au_data), 
		.au_in_left(au_left), 
		.au_in_right(au_right), 
		.clk(clk), 
		.rst_n(rst_n)
	);
	scan_ctl SCAN(
		.ftsd_ctl(ftsd_ctl), 
		.ftsd(ftsd), 
		.in0(pitch_name[19:15]), 
		.in1(pitch_name[14:10]),
		.in2(pitch_name[9:5]),
		.in3(pitch_name[4:0]),
		.ftsd_ctl_en(clk_ftsd)
	);
	ftsd FTSD(
		.display_value(display),
		.value(ftsd)
	);
endmodule
