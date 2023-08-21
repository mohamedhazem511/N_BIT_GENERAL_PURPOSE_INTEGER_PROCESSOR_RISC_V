module ALU_IR(
input   wire    [31:0]     ALU_Result,
input   wire               CLK,
input   wire               RST,
output  reg     [31:0]     ALU_OUT
);

always@(posedge CLK or negedge RST)
begin
if(!RST)
    begin
        ALU_OUT <= 0;
    end
else
    begin
        ALU_OUT <= ALU_Result;
    end


end
endmodule
