`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,
    input logic [31:0] Imm,
    input logic Branch,
    input logic Jump,
    input logic Halt,
    input logic JalrSel,
    input logic [31:0] AluResult,
    output logic [31:0] PC_Imm,
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel
);

  logic Branch_Sel;
  logic [31:0] PC_Full;
  logic Halt_Sel;

  assign PC_Full = {23'b0, Cur_PC};
  assign PC_Imm = (JalrSel) ? (AluResult) : (PC_Full + Imm);
  assign Halt_Sel = Halt;

  assign PC_Four = PC_Full + 32'b100;
  assign Branch_Sel = (Branch && AluResult [0]) || Jump;

  assign BrPC = (Branch_Sel) ? PC_Imm : ((Halt_Sel) ? PC_Full : 32'b0 );  // Branch -> PC+Imm   // Otherwise, BrPC value is not important
  assign PcSel = Branch_Sel || Jump || Halt_Sel;  // 1:branch is taken; 0:branch is not taken(choose pc+4)

endmodule