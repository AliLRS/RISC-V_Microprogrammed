module datapath(
			input  logic clk, rst,
			input  logic [1:0] ResultSrc,
			input  logic [2:0] ALUControl,
			input  logic [1:0] ALUSrcA,
			input  logic [1:0] ALUSrcB,
			input  logic [1:0] ImmSrc, 
			input  logic RegWrite,
			input  logic AdrSrc,
			input  logic IRWrite, PCWrite, 
			input  logic [31:0] Instr,
			input  logic [31:0] Data, 
			output logic zero,
			output logic [31:0] Adr, WriteData);

	logic [31:0] PC, OldPC;
	logic [31:0] RD1, RD2;
	logic [31:0] A;
	logic [31:0] ImmExt;
	logic [31:0] SrcA, SrcB;
	logic [31:0] ALUResult;
	logic [31:0] ALUOut;
	logic [31:0] Result;
	
	flopenr#(32) PCReg(clk, rst, PCWrite, Result, PC);
	mux2#(32) addressMux(PC,Result, AdrSrc, Adr);

	flopenr#(32) oldPCReg(clk, rst, IRWrite, PC, OldPC);

	regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, RD1, RD2);
	
	flopr#(32) RD1Reg(clk, rst, RD1, A);
	flopr#(32) rd2Saver(clk, rst, RD2, WriteData);

	extend extendUnit(Instr[31:7], ImmSrc, ImmExt);

	mux3#(32) muxSrcA(PC, OldPC, A, ALUSrcA, SrcA);
	mux3#(32) muxSrcB(WriteData, ImmExt, 32'd4, ALUSrcB, SrcB);

	alu#(32) ALU(SrcA, SrcB, ALUControl, ALUResult, zero);
	flopr#(32) aluReg(clk, rst, ALUResult, ALUOut);

	mux3#(32) resultMux(ALUOut, Data, ALUResult, ResultSrc, Result);

endmodule