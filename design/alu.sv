`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb
        begin
            case(Operation)
                4'b0000:        // AND
                        ALUResult = SrcA & SrcB;
                4'b0001:        // OR
                        ALUResult = SrcA | SrcB;
                4'b0010:        // ADD,ADDI
                        ALUResult = $signed(SrcA) + $signed(SrcB);
                4'b0011:        // SUB
                        ALUResult = $signed(SrcA) - $signed(SrcB);
                4'b0110:       // XOR
                        ALUResult = SrcA ^ SrcB;
                4'b1000:        // Equal
                        ALUResult = (SrcA == SrcB) ? 1 : 0;
                4'b1001:        // NotEqual
                        ALUResult = (SrcA == SrcB) ? 0 : 1;
                4'b1010:        // BLT
                        ALUResult = (SrcA < SrcB) ? 1 : 0;
                4'b1011:        // BGE
                        ALUResult = (SrcA >= SrcB) ? 1 : 0;
                4'b1111:        // LUI
                        ALUResult = SrcB;
                4'b1100:        // SLTI
                        ALUResult = (SrcA < SrcB) ? 1 : 0; 
                4'b0100:
                        ALUResult = SrcA << SrcB;
                4'b0101: 
                        ALUResult = SrcA >> SrcB;
                4'b0111: 
                        ALUResult = $signed(SrcA) >>> SrcB;
                
                default:
                        ALUResult = 0;
            endcase
        end
endmodule

