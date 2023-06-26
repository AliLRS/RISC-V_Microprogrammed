///////////////////////////////////////////////////////////////
// top
//
// Instantiates micro-programmed RISC-V processor and memory
///////////////////////////////////////////////////////////////

module top(
        input  logic        clk, reset, 
        output logic [31:0] WriteData, DataAdr, 
        output logic        MemWrite);

    logic [31:0] ReadData;

    riscvuprog rvuprog(clk, reset, ReadData, MemWrite, DataAdr, WriteData);

    mem memory(clk, MemWrite, DataAdr, WriteData, ReadData);

endmodule