module address_select(
                input  logic [6:0] op,
                input  logic [2:0] addrCtl,
                input  logic [3:0] currAddr,
                output logic [3:0] nextAddr);
        
    logic [3:0] w0, w1, w2, w3, w4;
    
    assign w0 = currAddr + 1;
    dispatch_ROM1 dispatchROM1(op, w1);
    dispatch_ROM2 dispatchROM2(op, w2);
    assign w3 = 4'b0000;
    assign w4 = 4'b0111;
    
    mux5 mux5_1(w0, w1, w2, w3, w4, addrCtl, nextAddr);

endmodule

module dispatch_ROM1(
                input  logic [6:0] op,
                output logic [3:0] value);
    
    always_comb begin
        case(op)
            7'b0110011: value = 4'b0110;     // R-Type
            7'b0010011: value = 4'b1000;     // I-Type
            7'b1101111: value = 4'b1001;     // J-Type
            7'b1100011: value = 4'b1010;     // B-Type
            7'b0000011: value = 4'b0010;     // lw
            7'b0100011: value = 4'b0010;     // sw
            default:    value = 4'bxxxx;
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
            default:    value = 4'bxxxx;
        endcase
    end
endmodule