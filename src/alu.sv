module alu #(parameter WIDTH = 32) (
                input  logic [WIDTH-1:0]    A,
                input  logic [WIDTH-1:0]    B, 
                input  logic [2:0]          Control, 
                output logic [WIDTH-1:0]    ALUResult,
                output logic                Zero);

    always_comb begin
        case (Control)
            3'b000: ALUResult = A + B;      // ADD
            3'b001: ALUResult = A - B;      // SUB
            3'b010: ALUResult = A & B;      // AND
            3'b011: ALUResult = A | B;      // OR
            3'b100: ALUResult = A ^ B;      // XOR
            3'b101: ALUResult = A < B;      // SLT
            3'b110: ALUResult = A << B;     // SLL
            3'b111: ALUResult = A >> B;     // SRL
            default: ALUResult = 0;
        endcase
    end

    assign Zero = (ALUResult == 0);
endmodule