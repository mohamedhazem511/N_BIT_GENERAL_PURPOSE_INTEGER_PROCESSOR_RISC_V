
`timescale 1us/1ns

//*************** TestBench for Control Unit Block ***************//

module Control_Unit_tb;
  
  //input & outpot declerastion


  reg            CLK_tb;
  reg  [6:0]     OP_tb;
  reg  [2:0]     funct3_tb;
  reg            funct7_tb;
  reg            RST_tb;
  reg            Zero_tb;
  wire           PCWrite_tb;
  wire           AdrSrc_tb;
  wire           MemWrite_tb;
  wire           IRWrite_tb;
  wire  [1:0]    ResultSrc_tb;
  wire  [2:0]    ALUControl_tb;
  wire  [1:0]    ALUSrcB_tb;
  wire  [1:0]    ALUSrcA_tb;
  wire  [1:0]    ImmSrc_tb;
  wire           RegWrite_tb;
  
 
    //initalization
initial 
  begin

    $dumpfile("Control_Unit_TOP.vcd ") ;
    $dumpvars ;

   //  initial values

    CLK_tb = 1'b0;
    RST_tb = 1'b1;
    #5
    RST_tb = 1'b0;
    #5
    RST_tb = 1'b1;
    
    
    OP_tb     = 7'b0000011;              //  LW  
    funct3_tb = 3'bxxx;
    funct7_tb = 1'bx;
    Zero_tb   = 1'b0;    
    #50                                  //  SW
    OP_tb     =7'b0100011;              
    funct3_tb =3'bxxx;
    funct7_tb =1'bx;
        
    #50 
    OP_tb      =7'b0110011;              //  ExcuteR  
    funct3_tb  =3'b110;
    funct7_tb  =1'bx;
        
     
       
    #50
    OP_tb      =7'b1101111;              //  jal at Z=0   S9
    Zero_tb    =1'b0;
        
    #50 
    OP_tb      =7'b1101111;              //  jal at Z=1     S9
    funct3_tb  =3'bxxx;
    funct7_tb  =1'bx;
    Zero_tb    =1'b1;
       
       
    #50 
    OP_tb      =7'b1100011;              //  BeQ     S10
    funct3_tb  =3'bxxx;
    funct7_tb  =1'bx;

    #200

    $stop;    
     
    end
    ////////////////// Clock Generator  ////////////////////


always #5 CLK_tb = !CLK_tb ;

    //instant unit under test

Control_Unit  U0_Control_Unit(
    .CLK         (CLK_tb),
    .RST         (RST_tb),  
    .OP          (OP_tb),
    .Zero        (Zero_tb),
    .funct3      (funct3_tb),
    .funct7      (funct7_tb),
    .PCWrite     (PCWrite_tb),
    .AdrSrc      (AdrSrc_tb),
    .RegWrite    (RegWrite_tb),
    .MemWrite    (MemWrite_tb),
    .IRWrite     (IRWrite_tb),
    .ResultSrc   (ResultSrc_tb),
    .ALUSrcB     (ALUSrcB_tb),
    .ALUSrcA     (ALUSrcA_tb),
    .ALUControl  (ALUControl_tb),
    .ImmSrc      (ImmSrc_tb)
    );
    
endmodule
    
  
     
   