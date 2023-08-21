module Instr_Data_Mem(
input    wire                  CLK,
input    wire                  RST,
input    wire    [31:0]        A,
input    wire    [31:0]        WD3,
input    wire                  WE,
input    wire                  Adrsrc,
output   reg    [31:0]         RD,
output   reg   [7:0]         test
);

integer i ;
wire [7:0] test_t ;
reg  [31:0]   MEM_WB     [49:0] ;
wire [31:0]   Read_INS;                     
wire [4:0]    Rom_addr;

always@(posedge CLK or negedge RST)
begin
    if(!RST)
        begin
            for (i=0;i<=49;i=i+1)
                begin
                    MEM_WB[i] <= 0 ;
                end
        end
    else if(WE)
        begin
          MEM_WB[A] <= WD3 ;
        end
end

always@(*)
begin
if(Adrsrc && !WE)
    begin
		 RD = MEM_WB[A];
    end
else if (!Adrsrc  && !WE)
    begin
       RD = Read_INS;
    end
else
    begin
       RD = 0;
    end
 
end 
 
always@(posedge CLK or negedge RST)
    begin
	   if(!RST)
        begin
            
          test <= 0 ;
		  end
		else
		  begin
		    test <= test_t ;
		  end
	 end
 
assign test_t = MEM_WB[32][7:0];                            //for testing
assign Rom_addr = A>>2;

ROM INS_MEM(
  .a(Rom_addr), 
  .spo(Read_INS) 
);
endmodule
