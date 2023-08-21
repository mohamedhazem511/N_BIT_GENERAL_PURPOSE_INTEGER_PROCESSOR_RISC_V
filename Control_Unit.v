/*
   Created by : Mohamed Hazem Mamdouh
   30-11-2022
   7:30 PM
 */

//***************  Control Unit Module Top ***************//

module Control_Unit 
(
 input   wire                  CLK,
 input   wire                  RST,
 input   wire     [6:0]        OP,
 input   wire                  Zero,
 input   wire     [2:0]        funct3,
 input   wire                  funct7, 
 output  wire                  PCWrite,
 output  wire                  AdrSrc,
 output  wire                  RegWrite,
 output  wire                  MemWrite,
 output  wire                  IRWrite,
 output  wire      [1:0]       ResultSrc,
 output  wire      [1:0]       ALUSrcB,
 output  wire      [1:0]       ALUSrcA, 
 output  wire      [2:0]       ALUControl,
 output  wire      [1:0]       ImmSrc

);

//*************** internal signals ***************//

wire                            PCUpdate_c,Branch_c;

wire               [1:0]        ALUOP_c;          



//*************** Port Mapping For FSM ***************//

FSM  U0_FSM  (
 .CLK(CLK),
 .RST(RST),
 .OP(OP), 
 .PCUpdate(PCUpdate_c),
 .Branch(Branch_c),
 .AdrSrc(AdrSrc),
 .MemWrite(MemWrite),
 .IRWrite(IRWrite),
 .ResultSrc(ResultSrc),
 .ALUSrcB(ALUSrcB),
 .ALUSrcA(ALUSrcA), 
 .ALUOP(ALUOP_c), 
 .RegWrite(RegWrite)
);

//*************** Port Mapping For The Logic of and , or gates  ***************//

Logic U0_Logic (
  .Zero(Zero),
  .Branch(Branch_c),
  .PCUpdate(PCUpdate_c),
  .PCWrite(PCWrite)
);

//*************** Port Mapping For ALU_Decoder ***************//

ALU_Decoder U0_ALU_Decoder  (
  .funct3(funct3),
  .funct7(funct7),
  .ALUOP(ALUOP_c),
  .OP(OP[5]),
  .ALUControl(ALUControl)
);

//*************** Port Mapping For Instr_Decoder ***************//

Instr_Decoder U0_Instr_Decoder  (
  .OP(OP),
  .ImmSrc(ImmSrc)
);


endmodule