`timescale 1ns / 1ps
//teste

module Controller (
    //Input
    input logic [6:0] Opcode,
    //7-bit opcode field from the instruction

    //Outputs
    output logic ALUSrc,
    //0: The second ALU operand comes from the second register file output (Read data 2); 
    //1: The second ALU operand is the sign-extended, lower 16 bits of the instruction.
    output logic MemtoReg,
    //0: The value fed to the register Write data input comes from the ALU.
    //1: The value fed to the register Write data input comes from the data memory.
    output logic RegWrite, //The register on the Write register input is written with the value on the Write data input 
    output logic MemRead,  //Data memory contents designated by the address input are put on the Read data output
    output logic MemWrite, //Data memory contents designated by the address input are replaced by the value on the Write data input.
    output logic [1:0] ALUOp,  //00: LW/SW; 01:Branch; 10: Rtype
    output logic Branch,  //0: branch is not taken; 1: branch is taken
    output logic JalrSel,  //0 branch não é seguido, 1 branch é seguido
    output logic [1:0] RWSel,
    output logic Jump,  
    output logic Halt  
);

  logic [6:0] R_TYPE, LW, SW, BR, INT_IMED_REG, JAL, JALR, LUI;

  assign R_TYPE = 7'b0110011;  //add,and,or,sub,xor
  assign LW = 7'b0000011;  //lw
  assign SW = 7'b0100011;  //sw
  
  assign BR = 7'b1100011;  //beq,bne,blt,bge
  
  assign INT_IMED_REG = 7'b0010011; //addi

  assign JAL = 7'b1101111; // jal

  assign JALR = 7'b1100111; // jalr

  assign LUI = 7'b0110111; // lui

  assign HALT = 7'b1111111; // halt
  

  assign ALUSrc = (Opcode == LW || Opcode == SW || Opcode == INT_IMED_REG || Opcode == LUI || Opcode == JAL || Opcode == JALR);
  assign MemtoReg = (Opcode == LW);
  assign RegWrite = (Opcode == R_TYPE || Opcode == LW || Opcode == INT_IMED_REG || Opcode == LUI || Opcode == JAL || Opcode == JALR);
  assign MemRead = (Opcode == LW);
  assign MemWrite = (Opcode == SW);
  assign ALUOp[0] = (Opcode == BR || Opcode == LUI);
  assign ALUOp[1] = (Opcode == R_TYPE || Opcode == INT_IMED_REG || Opcode == LUI || Opcode == JALR);
  assign Branch = (Opcode == BR);
  assign JalrSel = (Opcode == JALR);
  assign RWSel[0] = (Opcode == JAL || Opcode == JALR);
  assign RWSel[1] = (0);
  assign Jump = (Opcode == JAL || Opcode == JALR);
  assign Halt = (Opcode == HALT);

endmodule
