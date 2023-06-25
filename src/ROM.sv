module ROM(
        input [3:0] addr,
        output [16:0] out);
        
    logic [15:0] ROM[10:0];

    assign ROM[0]  = 17'b0_1_0_0_1_0_10_00_10_00_000;      // Fetch    - S0
    assign ROM[1]  = 17'b0_0_0_0_0_0_00_01_01_00_001;      // Decode   - S1
    assign ROM[2]  = 17'b0_0_0_0_0_0_00_10_01_00_010;      // MemAdr   - S2
    assign ROM[3]  = 17'b0_0_0_0_0_1_00_00_00_00_000;      // MemRead  - S3
    assign ROM[4]  = 17'b0_0_1_0_0_0_01_00_00_00_011;      // MemWB    - S4
    assign ROM[5]  = 17'b0_0_0_1_0_1_00_00_00_00_011;      // MemWrite - S5
    assign ROM[6]  = 17'b0_0_0_0_0_0_00_10_00_10_100;      // ExecuteR - S6
    assign ROM[7]  = 17'b0_0_1_0_0_0_00_00_00_00_011;      // ALUWB    - S7
    assign ROM[8]  = 17'b0_0_0_0_0_0_00_10_01_10_100;      // ExecuteI - S8
    assign ROM[9]  = 17'b0_1_0_0_0_0_00_01_10_00_100;      // JAL      - S9
    assign ROM[10] = 17'b1_0_0_0_0_0_00_10_00_01_011;      // BEQ      - S10

    assign out = ROM[addr];

endmodule