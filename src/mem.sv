///////////////////////////////////////////////////////////////
// mem
//
// Single-ported RAM with read and write ports
// Initialized with machine language program
///////////////////////////////////////////////////////////////

module mem(
        input  logic        clk, 
        input  logic        we,
        input  logic [31:0] a, wd,
        output logic [31:0] rd);

    logic [31:0] RAM[63:0];

    initial
        $readmemh("riscvtest.txt",RAM);

    assign rd = RAM[a[31:2]]; // word aligned

    always_ff @(posedge clk) begin
        if (we) 
            RAM[a[31:2]] <= wd;
    end

endmodule