module mux_3x1 #(parameter N =32 )
				(
					input [N-1:0] w0,
					input [N-1:0] w1,
					input [N-1:0] w2,
					input [1:0] s,
					output reg [N-1:0] f
				);
				
				
				always @(w0,w1,w2,s)
				 begin
					case (s)
					 2'b00 : f = w0;
					 2'b01 : f =w1;
					 2'b10 : f = w2;
					 default : f = 0;
					endcase
				 end

    
endmodule
