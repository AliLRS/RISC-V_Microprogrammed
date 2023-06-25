module controller(
            input  logic       clk,
            input  logic       reset,  
            input  logic [6:0] op,
            input  logic [2:0] funct3,
            input  logic       funct7_5,
            input  logic       Zero,
            output logic [1:0] ImmSrc,
            output logic [1:0] ALUSrcA, ALUSrcB,
            output logic [1:0] ResultSrc, 
            output logic       AdrSrc,
            output logic [2:0] ALUControl,
            output logic       IRWrite, PCWrite, 
            output logic       RegWrite, MemWrite);

    logic Branch, PCUpdate;
    logic [1:0]  ALUOp;
    logic [3:0]  currAddr, nextAddr;
    logic [2:0]  addrCtl;
    logic [16:0] ROMout;

    assign PCWrite = (Zero & Branch) | PCUpdate;

    address_select addr (op, addrCtl, currAddr, nextAddr);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            currAddr <= 4'b0000;
        end
        else begin
            currAddr <= nextAddr;
        end
    end

    ROM rom (currAddr, ROMout);
    
    assign {Branch, PCUpdate, RegWrite, MemWrite, IRWrite, AdrSrc,
            ResultSrc, ALUSrcA, ALUSrcB, ALUOp, addrCtl} = ROMout;


    instrdec idec (op, ImmSrc);

    aludec adec (op[5], funct3, funct7_5, ALUOp, ALUControl);

endmodule
