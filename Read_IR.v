module Read_IR(
input  wire  [31:0]    ReadData,
input  wire            CLK,
input  wire            RST,
output reg   [31:0]    Data
);

always@(posedge CLK or negedge RST)
begin
if(!RST)
    begin
      Data <= 0 ;
    end
else
     begin
       Data <= ReadData ;
     end
end
endmodule
