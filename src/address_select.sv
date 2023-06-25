module address_select(
                input  logic [6:0] op,
                output logic [3:0] addr);
        


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