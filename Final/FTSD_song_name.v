`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:37:02 06/19/2016 
// Design Name: 
// Module Name:    FTSD_song_name 
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

`define NO  15'b11111111_111111_1
`define A 15'b00010000_111111_1
`define B	15'b00001110_101101_1
`define C	15'b01100011_111111_1
`define D	15'b00001111_101101_1
`define E	 15'b01100000_111111_1
`define F	 15'b01110000_111111_1
`define G	 15'b01000010_111111_1
`define H	15'b10010000_111111_1
`define I	 15'b01101111_101101_1
`define J	15'b10000111_111111_1
`define K	15'b11110001_110110_1
`define L	 15'b11100011_111111_1
`define M	 15'b10010011_010111_1
`define N	 15'b10010011_011110_1
`define O	15'b00000011_111111_1
`define P	15'b00110000_111111_1
`define Q	15'b00000011_111110_1
`define R	 15'b00110000_111110_1
`define S	15'b01001000_111111_1
`define T	15'b01111111_101101_1
`define U	15'b10000011_111111_1
`define V	15'b11110011_110011_1
`define W	15'b10010011_111010_1
`define X	15'b11111111_010010_1
`define Y	15'b11111111_010101_1
`define Z	15'b01101111_110011_1
module FTSD_song_name(
    input [2:0]value,
	input [2:0]song,
    output reg[14:0]display
);
	always@(*)
		begin
			case(song)
				3'd0:
				begin
					case(value)                     //varies when different values      
						3'd0: display = `S;          
						3'd1: display = `O;             
						3'd2: display = `N;           
						3'd3: display = `G;          
						3'd4: display = 15'b00000011_111111_1;          
						3'd5: display = 15'b10011111_111111_1;
						default: display = 15'b11111111_111111_1; //others, display nothing     
					endcase
				end
				
				3'd1:
				begin
					case(value)                     //varies when different values      
						3'd0: display = `S;          
						3'd1: display = `O;             
						3'd2: display = `N;           
						3'd3: display = `G;          
						3'd4: display = 15'b00000011_111111_1;          
						3'd5: display = 15'b01100100_111111_1;
						default: display = 15'b11111111_111111_1; //others, display nothing     
					endcase
				end
				
				3'd2:
				begin
					case(value)                     //varies when different values      
						3'd0: display = `S;          
						3'd1: display = `O;             
						3'd2: display = `N;           
						3'd3: display = `G;          
						3'd4: display = 15'b00000011_111111_1;          
						3'd5: display = 15'b00001100_111111_1;
						default: display = 15'b11111111_111111_1; //others, display nothing     
					endcase
				end
				
				3'd3:
				begin
					case(value)                     //varies when different values      
						3'd0: display = `S;          
						3'd1: display = `O;             
						3'd2: display = `N;           
						3'd3: display = `G;          
						3'd4: display = 15'b00000011_111111_1;          
						3'd5: display = 15'b10011000_111111_1;
						default: display = 15'b11111111_111111_1; //others, display nothing     
					endcase
				end
				
				3'd4:
				begin
					case(value)                     //varies when different values      
						3'd0: display = `S;          
						3'd1: display = `O;             
						3'd2: display = `N;           
						3'd3: display = `G;          
						3'd4: display = 15'b00000011_111111_1;          
						3'd5: display = 15'b01001000_111111_1;
						default: display = 15'b11111111_111111_1; //others, display nothing     
					endcase
				end
				
				3'd5:
				begin
					case(value)                   //varies when different values      
						3'd0: display = `S;          
						3'd1: display = `O;             
						3'd2: display = `N;           
						3'd3: display = `G;          
						3'd4: display = 15'b00000011_111111_1;          
						3'd5: display = 15'b01000000_111111_1;
						default: display = 15'b11111111_111111_1; //others, display nothing     
					endcase
				end
				
				default:
					display = 15'd11111111_111111_1;
			endcase
		end
			
endmodule
