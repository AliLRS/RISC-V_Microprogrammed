module regfile( 
            input logic clk,
            input logic we3,
            input logic [4:0] a1, a2, a3,
            input logic [31:0] wd3,
            output logic [31:0] rd1, rd2);

    logic [31:0] rf[31:0];

    always_ff @(posedge clk) begin
        if (we3) 
            rf[a3] <= wd3;
    end

    assign rd1 = (a1 != 0) ? rf[a1] : 0;    // register 0 hardwired to 0
    assign rd2 = (a2 != 0) ? rf[a2] : 0;    // register 0 hardwired to 0

endmodule