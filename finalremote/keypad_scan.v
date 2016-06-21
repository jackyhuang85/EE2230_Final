`timescale 1ns / 1ps
`include"param.v"
module keypad_scan(key, pressed, row_n, col_n, clk, rst_n);
	output reg [3:0]key, row_n;
	output reg pressed;
	input [3:0]col_n;
	input clk, rst_n;
	
	reg [3:0]sel_row, sel_row_nx;
	reg key_pressed_detected, next_pressed;
	reg [3:0]key_detected, key_next;
	reg keypad_state, keypad_state_next;
	reg [`KEYPAD_PAUSE_PERIOD_BIT_WIDTH-1:0] pause, pause_next;
	
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) sel_row <= 2'b00;
		else sel_row <= sel_row_nx;
	end
	
	always @(sel_row)
		sel_row_nx = sel_row + 2'b01;
	
	always @(sel_row) begin
		case(sel_row)
			2'b00: row_n = 4'b0111;
			2'b01: row_n = 4'b1011;
			2'b10: row_n = 4'b1101;
			2'b11: row_n = 4'b1110;
			default: row_n = 4'b1111;
		endcase
	end
	
	always @(row_n or col_n) begin
		case({row_n, col_n})
			`KEYPAD_DEC_WIDTH'b0111_0111: begin		//press F
				key_detected = `KEY_F;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b0111_1011: begin		//press E
				key_detected = `KEY_E;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b0111_1101: begin		//press D
				key_detected = `KEY_D;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b0111_1110: begin		//press C
				key_detected = `KEY_C;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1011_0111: begin		//press B
				key_detected = `KEY_B;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1011_1011: begin		//press 3
				key_detected = `KEY_3;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1011_1101: begin		//press 6
				key_detected = `KEY_6;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1011_1110: begin		//press 9
				key_detected = `KEY_9;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1101_0111: begin		//press A
				key_detected = `KEY_A;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1101_1011: begin		//press 2
				key_detected = `KEY_2;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1101_1101: begin		//press 5
				key_detected = `KEY_5;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1101_1110: begin		//press 8
				key_detected = `KEY_8;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1110_0111: begin		//press 0
				key_detected = `KEY_0;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1110_1011: begin		//press 1
				key_detected = `KEY_1;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1110_1101: begin		//press 4
				key_detected = `KEY_4;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			`KEYPAD_DEC_WIDTH'b1110_1110: begin		//press 7
				key_detected = `KEY_7;
				key_pressed_detected = `KEYPAD_PRESSED;
			end
			default: begin
				key_detected = `KEY_F;
				key_pressed_detected = `KEYPAD_NOT_PRESSED;
			end
		endcase
	end
	
	always @(key_pressed_detected or pause or key_detected or key or keypad_state) begin
		case(keypad_state)
			`SCAN: begin
				if(key_pressed_detected == `KEYPAD_PRESSED) begin
					keypad_state_next = `PAUSE;
					next_pressed = `KEYPAD_PRESSED;
					pause_next = `KEYPAD_PAUSE_PERIOD_BIT_WIDTH'b0000;
					key_next = key_detected;
				end
				else begin
					keypad_state_next = `SCAN;
					next_pressed = `KEYPAD_NOT_PRESSED;
					pause_next = `KEYPAD_PAUSE_PERIOD_BIT_WIDTH'b0000;
					key_next = key;
				end
			end
			`PAUSE: begin
				if(pause == `KEYPAD_PAUSE_PERIOD_BIT_WIDTH'b1111) begin
					keypad_state_next = `SCAN;
					next_pressed = key_pressed_detected;
					pause_next = `KEYPAD_PAUSE_PERIOD_BIT_WIDTH'b0000;
					key_next = key;
				end
				else begin
					keypad_state_next = `PAUSE;
					next_pressed = `KEYPAD_PRESSED;
					pause_next = pause + `KEYPAD_PAUSE_PERIOD_BIT_WIDTH'b0001;
					key_next = key;
				end
			end
			default: begin
				keypad_state_next = `SCAN;
				next_pressed = `KEYPAD_NOT_PRESSED;
				pause_next = `KEYPAD_PAUSE_PERIOD_BIT_WIDTH'b0000;
				key_next = key;
			end
		endcase
	end
	/* fsm */
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) keypad_state <= `SCAN;
		else keypad_state <= keypad_state_next;
	end
	
	/* pause */
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) pause <= `KEYPAD_PAUSE_PERIOD_BIT_WIDTH'b0000;
		else pause <= pause_next;
	end
	
	/* pressed-state */
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) pressed <= `KEYPAD_NOT_PRESSED;
		else pressed <= next_pressed;
	end
	
	/* key-output */
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) key <= `KEY_F;
		else key <= key_next;
	end
endmodule
