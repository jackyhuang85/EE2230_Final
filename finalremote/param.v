`timescale 1ns / 1ps
// Keypad scan
`define KEYPAD_ROW_WIDTH 4 // keypad Row width
`define KEYPAD_COL_WIDTH 4 // keypad column width
`define KEYPAD_DEC_WIDTH 8 // #bits of keypad decoding (row+col)
`define KEY_0 4'd0 // key '0'
`define KEY_1 4'd1 // key '1'
`define KEY_2 4'd2 // key '2'
`define KEY_3 4'd3 // key '3'
`define KEY_4 4'd4 // key '4'
`define KEY_5 4'd5 // key '5'
`define KEY_6 4'd6 // key '6'
`define KEY_7 4'd7 // key '7'
`define KEY_8 4'd8 // key '8'
`define KEY_9 4'd9 // key '9'
`define KEY_A 4'd10 // key 'A'
`define KEY_B 4'd11 // key 'B'
`define KEY_C 4'd12 // key 'C'
`define KEY_D 4'd13 // key 'D'
`define KEY_E 4'd14 // key 'E'
`define KEY_F 4'd15 // key 'F'
`define KEYPAD_PRESSED 1'b1 // key pressed indicator
`define KEYPAD_NOT_PRESSED 1'b0 // key not pressed indicator
`define SCAN 1'b1 // keypad readout FSM: scan
`define PAUSE 1'b0 // keypad readout FSM: pause
`define KEYPAD_PAUSE_PERIOD_BIT_WIDTH 4 // #bits for keypad pause period