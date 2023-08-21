`timescale 1ns/1ps
module Risc_V_tb ();
  
reg                 CLK_tb;
reg                 RST_tb;
//reg     [4:0]       sel_tb;
wire     [7:0]           test_tb;






initial 
begin
CLK_tb = 1'b0;
RST_tb =1'b0;

#3
RST_tb = 1'b1;
/*
#600
#125
sel_tb = 5'd0;

#100
sel_tb = 5'd1;

#100
sel_tb = 5'd2;

#100
sel_tb = 5'd3;

#100
sel_tb = 5'd4;
*/
#4000
$stop;
end



////////////////////////////////////////// Clock Generator //////////////////////////////////////
always #5 CLK_tb = ~CLK_tb;
////////////////////////////////////////////////////////////////////////////////////////////////





Risc_V DUT(
.CLKSYS(CLK_tb),
.RST(RST_tb),
//.sel(sel_tb),
.test(test_tb)
);
endmodule