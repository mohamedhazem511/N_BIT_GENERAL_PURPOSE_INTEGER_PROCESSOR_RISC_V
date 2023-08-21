 `timescale 1ns / 1ps
 module ALU_tb ();
  reg        [31:0]    A;
  reg        [31:0]    B;
  reg        [2:0]     control;
  wire       [31:0]    Result;
  wire                 Zero_flag;
  
 initial
  begin
  $dumpfile("ALU_32.vcd");
  $dumpvars ;
  A = 32'b0;
  B = 32'b0;
  control =3'b000;	 
  $display ("*** TEST CASE 1 ***");
  A = 32'b01111;
  B = 32'b01010;
  control =3'b000;
  #2   
  if(Result == 32'b011001  )
  $display ("ADDITION IS SUCCESS") ; 
  else
  $display ("ADDITION IS FAILED") ; 	 
  #5 control = 001;
  #2
  if(Result == 32'b00101  )
  $display ("SUBTRATION IS SUCCESS") ; 
  else
  $display ("subtraction IS FAILED") ; 
  #5  control = 010;
  #2
  if(Result == 32'b01010 )
  $display ("ADDITION IS SUCCESS") ; 
  else
  $display ("ADDITION IS FAILED") ; 		 
  #5  control = 011;
  #2
  if(Result == 32'b01111  )
  $display ("OR IS SUCCESS") ; 
  else
  $display ("OR IS FAILED") ; 
  #5  control = 100;
  #2 
  if(Result == 32'b1  )
  $display ("SLT IS SUCCESS") ; 
  else
  $display ("SLT IS FAILED") ; 
  #5  control = 101;
  #2
  if(Result == 32'b010010110 )
  $display ("MULTIPLY IS SUCCESS") ; 
  else
  $display ("MULTIPLY IS FAILED") ; 
  #5  control = 110;
  #2
  if(Result == 32'b01  )
  $display ("DIVIVION IS SUCCESS") ; 
  else
  $display ("DIVISIONIS FAILED") ; 		
  #5  control = 111;
  #2
  if(Result == 32'b00111  )
  $display ("SHIFT RIGHT IS SUCCESS") ; 
  else
  $display ("SHIFT RIGHT FAILED") ; 
  #5 
  A = 32'b0;
  B = 32'b0;
  control = 000;
  #2
  if(Result == 32'b0 )
  $display ("ADDITION IS SUCCESS") ; 
  else
  $display ("ADDITION IS FAILED") ; 
  $stop;         
  end	
  
  ALU d1(
  .SrcA(A),
  .SrcB(B),
  .ALUControl(control),
  .ALUResult(Result),
  .Zero(Zero_flag) 
  );

endmodule

