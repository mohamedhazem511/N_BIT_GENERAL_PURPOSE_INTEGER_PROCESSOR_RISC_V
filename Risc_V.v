//***************  Risc-v Top Module ***************//
module Risc_V  
(
 input   wire                        CLKSYS,
 input   wire                        RST,
 //input   wire        [4:0]           sel,
 output  wire          [7:0]              test

);

/***************** Internal signal ***************/
 wire                  CLK;
 wire     [6:0]        OP_c;
 wire                  Zero_c;
 wire     [2:0]        funct3_c;
 wire                  funct7_c;
 wire                  PCWrite_c;
 wire                  AdrSrc_c;
 wire                  RegWrite_c;
 wire                  MemWrite_c;
 wire                  IRWrite_c;
 wire      [1:0]       ResultSrc_c;
 wire      [1:0]       ALUSrcB_c;
 wire      [1:0]       ALUSrcA_c;
 wire      [2:0]       ALUControl_c;
 wire      [1:0]       ImmSrc_c;
wire       [31:0]      PC_c;
wire       [31:0]      Result;
wire       [31:0]      Adr;
wire       [31:0]      WriteData;   
wire       [31:0]      ReadData;        
wire       [31:0]      Instr;
wire       [31:0]      OldPC; 
wire       [31:0]      RD2;
wire       [31:0]      RD1;
wire       [31:0]      A;
wire       [31:0]      SrcA;
wire       [31:0]      SrcB;
wire       [31:0]      ImmExt;
wire       [31:0]      Data;
wire       [31:0]      ALU_Result;
wire       [31:0]      ALU_OUT;
//wire       [31:0]      test_32;


//////////////////////////////// Clock Dvider ///////////////////////////
CLK_DIV CLK_DIV(
.CLKSYS(CLKSYS),
.RST(RST),
.CLK(CLK) );
/*
///////////////////////// Buffering CLock ////////////////////////////

IBUFDS IBUFDS_INIT_CLK(
.I(CLK_P),
.IB(CLK_N),
.O(CLK_i)
); 

BUFG initclk_bufg_i (
.I(CLK_i),
.O(CLK)
);

*/

//////////////////////// Port Mapping for Control Unit /////////////////////


Control_Unit U0_Control_Unit (

    .CLK(CLK),
    .RST(RST),
    .OP(Instr[6:0]),
    .Zero(Zero_c),
    .funct3(Instr[14:12]),
    .funct7(Instr[30]), 
    .PCWrite(PCWrite_c),
    .AdrSrc(AdrSrc_c),
    .RegWrite(RegWrite_c),
    .MemWrite(MemWrite_c),
    .IRWrite(IRWrite_c),
    .ResultSrc(ResultSrc_c),
    .ALUSrcB(ALUSrcB_c),
    .ALUSrcA(ALUSrcA_c), 
    .ALUControl(ALUControl_c),
    .ImmSrc(ImmSrc_c)

);

PC pc(
.pc_next(Result),
.CLK(CLK),
.EN(PCWrite_c),
.rst(RST),
.pc(PC_c) 
);



mul_2 mul_2(
.pc(PC_c),
.result(Result),
.AdrSrc(AdrSrc_c),
.Adr(Adr) 
);


Instr_Data_Mem Instr_Data_Mem(
.CLK(CLK),
.RST(RST),
.A(Adr),
.WD3(WriteData),
.WE(MemWrite_c),
.Adrsrc(AdrSrc_c),
.RD(ReadData),
.test(test) 
);

INSTR_IR INSTR_IR(
.PC(PC_c),
.RD(ReadData),
.CLK(CLK),
.RST(RST),
.IRWrite(IRWrite_c),
.OldPC(OldPC),
.Instr(Instr)
 );



Register_File Register_File( 
.A1(Instr[19:15]),
.A2(Instr[24:20]),
.A3(Instr[11:7]),
.WD3(Result),
.CLK(CLK),
.RST(RST),
.WE3(RegWrite_c),
.RD1(RD1),
.RD2(RD2)
  );

Register_File_IR Register_File_IR(
.CLK(CLK),
.RST(RST),
.RD1(RD1),
.RD2(RD2),
.A(A),
.B(WriteData)
);

mux_3x1 mux_3x1_SRCA
(
.w0(PC_c),
.w1(OldPC),
.w2(A),
.s(ALUSrcA_c),
.f(SrcA)
);


mux_3x1 mux_3x1_SRCB
(
.w0(WriteData),
.w1(ImmExt),
.w2('b100),
.s(ALUSrcB_c),
.f(SrcB)
);

 Extend Extend(
.INSTR(Instr[31:7]),
.IMMSrc(ImmSrc_c),
.IMMExt(ImmExt)
);

Read_IR Read_IR(
.ReadData(ReadData),
.CLK(CLK),
.RST(RST),
.Data(Data)
);

ALU_IR ALU_IR(
.ALU_Result(ALU_Result),
.CLK(CLK),
.RST(RST),
.ALU_OUT(ALU_OUT)
);

mux_3x1 mux_3x1_Result
(
.w0(ALU_OUT[31:0]),
.w1(Data),
.w2(ALU_Result[31:0]),
.s(ResultSrc_c),
.f(Result)
);

ALU  ALU (
 .SrcA(SrcA),
 .SrcB(SrcB),
 .ALUControl(ALUControl_c),
 .ALUResult(ALU_Result),
 .Zero(Zero_c)
   );
   
   /*
Mux_32x1 Mux_32x1(
.test_32(test_32),
.CLK(CLK),
.RST(RST),
.sel(sel),    
.test_1(test)
);
  
*/
endmodule
