`timescale 1ns / 1ps
module full_adder 
(
   input     wire  A,
   input     wire  B,
   input     wire [2:0] ALUControl_f,
   input     wire  Cin,
   output    reg   Result,
   output    reg   CarryOut
);
reg C;
    always @ (*)
    begin
    if (ALUControl_f==3'b0)
    begin
      Result= A^B^Cin;
      CarryOut=(A&B)| ((A^B)&Cin);
    end
    else
    begin
    C=B^1'b1;
    Result= A^C^Cin;
    CarryOut=(A&C)| ((A^C)&Cin);
    end 
    end
endmodule

`timescale 1ns / 1ps
 module ALU
   (
   input     wire  [31:0]  SrcA,
   input     wire  [31:0]  SrcB,
   input     wire  [2:0]   ALUControl,
   output    reg   [31:0]  ALUResult,
   output    wire          Zero
   );

 genvar i;
 wire [31:0] ALUResult_G;
 wire        [32:0] carry;
 assign carry[0]= (ALUControl==3'b0)?1'b0 :1'b1;


   generate 
             for (i=0;i<32;i=i+1'b1)
             begin : genbit
             full_adder full_add_inst
             (
              .A(SrcA[i]),
              .B(SrcB[i]),
              .ALUControl_f(ALUControl),
              .Cin(carry[i]),
              .Result(ALUResult_G[i]),
              .CarryOut(carry[i+1])
             ); 
             end
            endgenerate
            
 always @(*) // Cobinational Always
   begin
   case (ALUControl)
	 3'b000: begin  //ADD
	           
            ALUResult = ALUResult_G;
             end
	 3'b001: begin  //SUB
             ALUResult =ALUResult_G; 
             end
	 3'b010: begin  //AND 
             ALUResult = SrcA&SrcB;
             end
	 3'b011: begin  //OR
             ALUResult = SrcA|SrcB; 
             end
	 3'b101: begin  // SIL
			    if(SrcA < SrcB)
                  begin
				  ALUResult = 32'b1;
                  end 
				else
                  begin
				  ALUResult = 0;
                  end
	         end
   default: begin
                         ALUResult = 32'b0;
                         end  
  endcase
  end      
  assign Zero = (ALUResult ==1'b0 ) ? 1'b1 :1'b0; 
endmodule
