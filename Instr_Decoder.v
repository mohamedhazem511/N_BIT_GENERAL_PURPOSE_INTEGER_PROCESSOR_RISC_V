
//***************  Instraction DECODER Module  ***************//

module Instr_Decoder
 (

 
  input        wire  [6:0]    OP,
  output       reg   [1:0]    ImmSrc

 );

 
 

  parameter   [6:0]     lw    = 7'b0000011,
                        sw    = 7'b0100011,
			                  R     = 7'b0110011,
			                  I     = 7'b0010011,
			                  jal   = 7'b1101111,
                        beq   = 7'b1100011;
  
   //***************  monitore the change if inputs  ***************//

  always@(*)
  
  begin
    case(OP)
      sw        : begin
                  ImmSrc = 2'b01;
                  end
      beq       : begin
                  ImmSrc = 2'b10;
                  end

      jal       : begin
                  ImmSrc = 2'b11;
                  end
      default   : begin
                  ImmSrc = 2'b00;
                  end
    endcase
  end
  

endmodule
