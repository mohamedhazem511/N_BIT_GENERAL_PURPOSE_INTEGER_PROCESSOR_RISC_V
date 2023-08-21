
//***************  ALU DECODER Module  ***************//



module ALU_Decoder 
 (


  
  input   wire    [2:0]     funct3,
  input   wire              funct7,
  input   wire    [1:0]     ALUOP,
  input   wire              OP,
  output  reg     [2:0]     ALUControl
  
 );

 //*************** internal signals ***************//


  



  parameter   [2:0]      add           = 3'b000,
                         sub           = 3'b001,
					          less_than     = 3'b101,
					          OR            = 3'b011,
                         AND           = 3'b010;

  //*************** monitore the change if inputs ***************//
  
  always@(*)
  begin
    case(ALUOP)

      2'b00: begin
             ALUControl = add;
             end 
      2'b01: begin
             ALUControl = sub;
             end
      2'b10: begin
             if (funct3 == 3'b000)
                begin
                if( {OP,funct7} == 2'b11 )
                begin
                ALUControl = sub;
                end
                else
                begin
                ALUControl = add;
                end
                end

             else if (funct3 == 3'b010)
                begin
                ALUControl = less_than;
                end
             else if (funct3 == 3'b110)
                begin
                ALUControl = OR;
                end
             else /* condition */
                begin
                ALUControl = AND;
                end
             end
    default: begin
             ALUControl = add;
             end 
   endcase
 end     
 
 
endmodule