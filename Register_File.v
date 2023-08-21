module Register_File( 
    input  wire [4:0]    A1,
    input  wire [4:0]    A2,
    input  wire [4:0]    A3,
    input  wire [31:0]   WD3,
    input  wire          CLK,
    input  wire          RST,
    input  wire          WE3,
    output wire [31:0]   RD1,
    output wire [31:0]   RD2  
  );

//Internal Signals
reg [31:0] MEM [31:0];
integer i ;
 
always@(posedge CLK or negedge RST)
begin
     if(!RST)
        begin
         for(i=0;i<=31;i=i+1)
          begin
            MEM[i] <= 0 ;
          end
        end
      else if(WE3)
        begin
         MEM[A3] <= WD3 ;     
        end
end 

assign RD1 = MEM[A1];
assign RD2 = MEM[A2];
 
 
endmodule

