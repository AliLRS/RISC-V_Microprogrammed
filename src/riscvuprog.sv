///////////////////////////////////////////////////////////////
// riscvuprog
//
// Micro-programmed RISC-V microprocessor
///////////////////////////////////////////////////////////////

module riscvuprog(
            input  logic        clk, reset,
            input  logic [31:0] ReadData,
            output logic        MemWrite,
            output logic [31:0] Adr, WriteData);

    logic [1:0] ResultSrc;
	logic [2:0] ALUControl;
	logic [1:0] ALUSrcA;
	logic [1:0] ALUSrcB;
	logic [1:0] ImmSrc;
	logic RegWrite, AdrSrc;
	logic IRWrite, PCWrite;
	logic Zero;
	logic [31:0] Instr; 
	logic [31:0] Data;
	
	
	flopenr#(32) IR(clk, reset, IRWrite, ReadData, Instr);
	flopr#(32) dataReg(clk, reset, ReadData, Data);
	
	datapath dp(clk, reset, ResultSrc, ALUControl, ALUSrcA, ALUSrcB, ImmSrc,
                RegWrite, AdrSrc, IRWrite, PCWrite, Instr, Data, Zero, Adr, WriteData);
					
	controller ctrl(clk, reset, Instr[6:0], Instr[14:12], Instr[30], Zero, ImmSrc, 
                    ALUSrcA, ALUSrcB, ResultSrc, AdrSrc, ALUControl, IRWrite, PCWrite, RegWrite, MemWrite);
endmodule