

module Logic  (
    
 input      wire                  Branch,
 input      wire                  Zero,
 input      wire                  PCUpdate,
 output     wire                  PCWrite 
  
);


assign PCWrite = ( ( Zero & Branch) | (PCUpdate) ) ? 1'b1 : 1'b0 ;

endmodule