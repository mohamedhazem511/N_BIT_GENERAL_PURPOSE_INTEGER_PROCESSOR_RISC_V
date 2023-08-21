module mul_2 #(parameter width = 32)(
    input wire [width-1 : 0] pc ,
	input wire [width-1 : 0] result ,
	input wire AdrSrc ,
	output wire [width-1 : 0] Adr 
    );
  
  assign Adr = AdrSrc ? result : pc ;

endmodule
