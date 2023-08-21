module PC #(parameter width = 32 )(
    input wire [width-1 : 0] pc_next ,
	 input wire CLK ,
	 input wire EN ,
	 input wire rst ,
	 output reg [width-1 : 0] pc 
    );
  
  always @(posedge CLK or negedge rst)
   if(!rst)
     begin
       pc <= 32'b0 ;
     end
   else
     begin  
       if(EN)
	      begin
		     pc <= pc_next ;
		  end
	 end	

endmodule
