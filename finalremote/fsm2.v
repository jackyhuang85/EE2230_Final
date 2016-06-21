`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  Pei-Rong Li
// 
// Create Date:    15:52:03 05/30/2016 
// Design Name: 
// Module Name:    fsm2 
// Project Name:    MusicFan
// Target Devices:  EVS6
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

module fsm2(
    input clk,
    input rst_n,
	 input dip2,
	 output reg [4:0]out1,
	 output reg [4:0]out2,
	 output reg [5:0]out3
    );
    
	 reg [2:0]state;
	 reg [2:0]next_state;
	 
	 always @*
	 begin
	   case(state)
		3'd0:
		  if (dip2 == 1'd0) begin
		    next_state = 3'd1;
		    out1 = 5'b00000;
			 out2 = 5'b00000;
			 out3 = 6'b000000;
		  end
		  
		  else begin
		    next_state = 3'd1;
			 out1 = 5'b11111;
			 out2 = 5'b10000;
			 out3 = 6'b000000;
		  end
		  
		3'd1:
		  if (dip2 == 1'd0) begin
		    next_state = 3'd2;
			 out1 = 5'b00000;
			 out2 = 5'b00000;
			 out3 = 6'b000000;
		  end
		  
		  else begin
		    next_state = 3'd2;
			 out1 = 5'b11111;
			 out2 = 5'b11100;
			 out3 = 6'b000000; 
		  end
		  
		3'd2:
			if (dip2 == 1'd0) begin
		    next_state = 3'd3;
			 out1 = 5'b00000;
			 out2 = 5'b00000;
			 out3 = 6'b000000;
		  end
		  
		  else begin
		    next_state = 3'd3;
			 out1 = 5'b11111;
			 out2 = 5'b11111;
			 out3 = 6'b000000;
		  end
		  
		 3'd3:
		    if (dip2 == 1'd0) begin
		    next_state = 3'd4;
			 out1 = 5'b00000;
			 out2 = 5'b00000;
			 out3 = 6'b000000;
		  end
		  
		  else begin
		    next_state = 3'd4;
			 out1 = 5'b11111;
			 out2 = 5'b11111;
			 out3 = 6'b110000;
		  end
		  
		 3'd4:
		    if (dip2 == 1'd0) begin
		    next_state = 3'd5;
			 out1 = 5'b00000;
			 out2 = 5'b00000;
			 out3 = 6'b000000;
		  end
		  
		  else begin
		    next_state = 3'd5;
			 out1 = 5'b11111;
			 out2 = 5'b11111;
			 out3 = 6'd111100;
		  end
		  
		 3'd5:
		    if (dip2 == 1'd0) begin
		    next_state = 3'd6;
			 out1 = 5'b00000;
			 out2 = 5'b00000;
			 out3 = 6'b000000;
		  end
		  
		  else begin
		    next_state = 3'd6;
			 out1 = 5'b11111;
			 out2 = 5'b11111;
			 out3 = 6'b110000;
		  end
		  
		 3'd6:
		    if (dip2 == 1'd0) begin
		    next_state = 3'd7;
			 out1 = 5'b00000;
			 out2 = 5'b00000;
			 out3 = 6'b000000;
		  end
		  
		  else begin
		    next_state = 3'd7;
			 out1 = 5'b11111;
			 out2 = 5'b11111;
			 out3 = 6'b000000;
		  end
		  
		 3'd7:
		    if (dip2 == 1'd0) begin
		    next_state = 3'd0;
			 out1 = 5'b00000;
			 out2 = 5'b00000;
			 out3 = 6'b000000;
		  end
		  
		  else begin
		    next_state = 3'd0;
			 out1 = 5'b11111;
			 out2 = 5'b11100;
			 out3 = 6'b000000;
		  end	    
		  
		default:
		  begin
          next_state = 3'd0;
          out1 = 5'b11111;
			 out2 = 5'b11111;
			 out3 = 6'b111111;
        end			 
	   endcase	
    end
	 
	 always @(posedge clk or negedge rst_n)
	 begin
	   if (~rst_n) state <= 3'd0;
		else state <= next_state;
	  end
	  
endmodule

 
