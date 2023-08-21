module CLK_DIV(
input  wire  CLKSYS,
input  wire  RST,
output reg   CLK );

always@(posedge CLKSYS or negedge RST)
begin
if(!RST)
	begin
		CLK = 0;
	end
else
	begin
		CLK = ~CLK;
	end
end



endmodule
