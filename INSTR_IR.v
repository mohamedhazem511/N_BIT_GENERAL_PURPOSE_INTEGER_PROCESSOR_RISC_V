module INSTR_IR(
input   wire   [31:0]    PC ,
input   wire   [31:0]    RD ,
input   wire             CLK,
input   wire             RST,
input   wire             IRWrite,
output  reg    [31:0]    OldPC,
output  reg    [31:0]    Instr
 );
 
 always@(posedge CLK or negedge RST)
 begin
if(!RST) 
    begin
      OldPC <= 0 ;
      Instr <= 0;
    end
else if(IRWrite)
    begin
     OldPC <= PC;
     Instr <= RD ;
    end
 end 
endmodule
