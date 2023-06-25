module address_select(
                input  logic [6:0] op,
                input              clk,
                input  logic [2:0] addrCtl,
                input  logic [3:0] currAddr,
                output logic [3:0] nextAddr);
        
    logic [3:0] w0, w1, w2, w3, w4;
    
    assign w0 = currAddr + 1;
    dispatch_ROM1 dispatchROM1(op, w1);
    dispatch_ROM2 dispatchROM2(op, w2);
    assign w3 = 4'b0000;
    assign w4 = 4'b0111;
    
    always_ff @(posedge clk) begin
        case(addrCtl)
            3'b000:  nextAddr = w0;
            3'b001:  nextAddr = w1;
            3'b010:  nextAddr = w2;
            3'b011:  nextAddr = w3;
            3'b100:  nextAddr = w4;
            default: nextAddr = 4'b0000;
        endcase
    end
endmodule

module dispatch_ROM1(
                input  logic [6:0] op,
                output logic [3:0] value);
    
    always_comb begin
        case(op)
            7'b0110011: value = 4'b0110;     // R-Type
            7'b0010011: value = 4'b1000;     // I-Type
            7'b1101111: value = 4'b1001;     // JAL
            7'b1100011: value = 4'b1010;     // Branch
            7'b0000011: value = 4'b0010;     // lw
            7'b0100011: value = 4'b0010;     // sw
            default:    value = 4'b0000;
        endcase
    end
endmodule

module dispatch_ROM2(
                input logic [6:0] op,
                output logic [3:0] value);

    always_comb begin
        case(op)
            7'b0000011: value = 4'b0011;     // lw
            7'b0100011: value = 4'b0101;     // sw
        endcase
    end
endmodule