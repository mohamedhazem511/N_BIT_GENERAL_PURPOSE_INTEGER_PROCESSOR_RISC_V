module Register_File_IR(
input  wire              CLK,
input  wire              RST,
input  wire   [31:0]     RD1,
input  wire   [31:0]     RD2,
output reg    [31:0]     A,
output reg    [31:0]     B
);

always@(posedge CLK or negedge RST)
begin
if(!RST)
 begin
  A <= 0 ;
  B <= 0 ;
 end
else
 begin
  A <= RD1;
  B <= RD2;
 end
end
endmodule
