module Extend #(parameter width = 32)(
    input wire [width-1 : 7] INSTR ,
	 input wire [1 : 0] IMMSrc ,
	 output reg [width-1 : 0] IMMExt
    );
	 
	 always @(*)
	 begin
	   case(IMMSrc)
		  2'b00 : begin 
		         IMMExt = {{20{INSTR[width-1]}} , INSTR[width-1 : 20]} ;
		       end
		  2'b01 : begin 
		         IMMExt = {{20{INSTR[width-1]}} , INSTR[width-1 : 25] , INSTR[11 : 7]} ;
		       end
		  2'b10 : begin
		         IMMExt = {{20{INSTR[width-1]}}, INSTR[7], INSTR[width-2 : 25], INSTR[11 : 8], 1'b0} ;
		       end
		  2'b11 : begin 
		         IMMExt = {{12{INSTR[width-1]}}, INSTR[19 : 12], INSTR[20], INSTR[width-2 : 21], 1'b0} ;
		       end
                 default : IMMExt =32'b0;
		endcase
	 end


endmodule
