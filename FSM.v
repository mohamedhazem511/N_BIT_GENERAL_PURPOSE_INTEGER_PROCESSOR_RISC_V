/*
   Created by : Mohamed Hazem Mamdouh
   28-11-2022
   1:38 AM


 */

//*************** FSM of Control Unit Module ***************//



module FSM  (

//*************** Inputs && Outputs Port Declaration ***************//


 input   wire                  CLK,
 input   wire                  RST,
 input   wire     [6:0]        OP, 
 output  reg                   PCUpdate,
 output  reg                   Branch,
 output  reg                   AdrSrc,
 output  reg                   MemWrite,
 output  reg                   IRWrite,
 output  reg      [1:0]        ResultSrc,
 output  reg      [1:0]        ALUSrcB,
 output  reg      [1:0]        ALUSrcA, 
 output  reg      [1:0]        ALUOP, 
 output  reg                   RegWrite

);


//*************** gray state encoding ***************//


parameter   [3:0]      Fetch     = 4'b0000,
                       Fetch2    = 4'b0001,    
                       Decode    = 4'b0011,
					             MemAdr    = 4'b0010,
					             MemRead   = 4'b0110,
					             MemWB     = 4'b0111,
                       Mem_Write = 4'b0101,
                       ExecuteR  = 4'b0100,
					             ALUWB     = 4'b1100,
					             ExecuteI  = 4'b1101,
					             JAL       = 4'b1111,
                       BEQ       = 4'b1110;


parameter   [6:0]      lw    = 7'b0000011,
                       sw    = 7'b0100011,
					             R     = 7'b0110011,
					             I     = 7'b0010011,
					             jal   = 7'b1101111,
                       beq   = 7'b1100011;

                       
//*************** internal signals ***************//


reg      [3:0]        current_state , next_state ;


			
//*************** state transition ***************//


always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    current_state <= Fetch ;
   end
  else
   begin
    current_state <= next_state  ;
   end
 end
 

//*************** Next State Logic ***************//

always @ (*)
 begin
  case(current_state)
  Fetch    : begin
            next_state = Fetch2 ;
            end
  Fetch2   : begin
            next_state = Decode ;
            end          
  Decode   : begin
            if ( ( OP == lw ) || ( OP == sw))
            begin
            next_state = MemAdr;
            end 
            else if ( OP == R )
            begin
            next_state = ExecuteR;
            end
            else if ( OP == I )
            begin
            next_state = ExecuteI;
            end
            else if ( OP == jal )
            begin
            next_state = JAL;
            end
            else if ( OP == beq )
            begin
            next_state = BEQ;
            end
            else
            begin
            next_state = Decode;
            end
            end
  MemAdr   : begin
            if ( OP == lw )
            begin
            next_state = MemRead;
            end
            else if ( OP == sw )
            begin
            next_state = Mem_Write;
            end
            else
            begin
            next_state = MemAdr;
            end			
            end
  MemRead  : begin
			      next_state = MemWB;
            end
  MemWB    : begin
			      next_state = Fetch;
            end
  Mem_Write : begin
            next_state = Fetch; 			
            end
  ExecuteR : begin
			      next_state = ALUWB; 	
            end
  ALUWB    : begin
            next_state = Fetch; 			
            end
  ExecuteI : begin
			      next_state = ALUWB; 
            end
  JAL      : begin
			      next_state = ALUWB; 
            end
  BEQ      : begin
			      next_state = Fetch ; 
            end		         	
  default  : begin
		        next_state = Fetch ; 
            end	
  endcase                 	   
 end 

//*************** Glitch-Free Outputs ***************//

always @ (posedge CLK or negedge RST)
  if(!RST)
   begin
            AdrSrc     <= 'b0;
            MemWrite   <= 'b0;
            IRWrite    <= 'b0;
            ResultSrc  <= 'b0;
            ALUSrcB    <= 'b0;
            ALUSrcA    <= 'b0;
            RegWrite   <= 'b0;
            ALUOP      <= 'b0;
            PCUpdate   <= 'b0;
            Branch     <= 'b0; 
   end
   else
   begin
            AdrSrc    <= 1'b0;
            IRWrite   <= 1'b0;	
            ALUSrcA   <= 2'b00;
            ALUSrcB   <= 2'b10;
            ALUOP     <= 2'b00;
            ResultSrc <= 2'b11;
            PCUpdate  <= 1'b0;
            RegWrite  <= 1'b0;
            Branch    <= 1'b0;
            MemWrite  <= 1'b0;

 case(current_state)
 
  Fetch    : begin
            
            AdrSrc    <= 1'b0;
            IRWrite   <= 1'b1;	
            ALUSrcA   <= 2'b00;
            ALUSrcB   <= 2'b10;
            ALUOP     <= 2'b00;
            ResultSrc <= 2'b10;
            PCUpdate  <= 1'b1;
            end         
  Decode   : begin
		        ALUSrcA   <= 2'b01;
            ALUSrcB   <= 2'b01;
            ALUOP     <= 2'b00;
            end
  MemAdr   : begin
            ALUSrcA   <= 2'b10;
            ALUSrcB   <= 2'b01;
            ALUOP     <= 2'b00;			
            end
  MemRead  : begin
	          ResultSrc <= 2'b00;
            AdrSrc    <= 1'b1;
            ALUOP     <= 2'b00;
            end
  MemWB    : begin
		        ResultSrc <= 2'b01;
            RegWrite  <= 1'b1;
            ALUSrcA   <= 2'b10;
            ALUSrcB   <= 2'b01;
            ALUOP     <= 2'b00;
       
            end
  Mem_Write : begin
            ResultSrc <= 2'b00;
            AdrSrc    <= 1'b1;
            MemWrite  <= 1'b1;
            ALUSrcA   <= 2'b10;
            ALUSrcB   <= 2'b01;
            ALUOP     <= 2'b00;			
            end
  ExecuteR : begin
		        ALUSrcA   <= 2'b10;
            ALUSrcB   <= 2'b00;
            ALUOP     <= 2'b10;	
            end
  ALUWB    : begin
            ResultSrc <= 2'b00;
            RegWrite  <= 1'b1;			
            end
  ExecuteI : begin
		        ALUSrcA   <= 2'b10;
            ALUSrcB   <= 2'b01;
            ALUOP     <= 2'b10;	
            end
  JAL      : begin
		        ALUSrcA   <= 2'b01;
            ALUSrcB   <= 2'b10;
            ALUOP     <= 2'b00;
            ResultSrc <= 2'b00;
            PCUpdate  <= 1'b1;	
            end
  BEQ      : begin
		        ALUSrcA   <= 2'b10;
            ALUSrcB   <= 2'b00;
            ALUOP     <= 2'b01;
            ResultSrc <= 2'b00;
            Branch    <= 1'b1;	
            end		         	
  
  endcase            
 end 

endmodule
 