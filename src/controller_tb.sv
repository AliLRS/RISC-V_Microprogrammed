typedef enum logic[6:0] {
                r_type_op=7'b0110011,
                i_type_alu_op=7'b0010011, 
                lw_op=7'b0000011, 
                sw_op=7'b0100011, 
                beq_op=7'b1100011, 
                jal_op=7'b1101111} 
                opcodetype;

module controller_tb();

    logic        clk;
    logic        reset;

    opcodetype  op;
    logic [2:0] funct3;
    logic       funct7b5;
    logic       Zero;
    logic [1:0] ImmSrc;
    logic [1:0] ALUSrcA, ALUSrcB;
    logic [1:0] ResultSrc;
    logic       AdrSrc;
    logic [2:0] ALUControl;
    logic       IRWrite, PCWrite;
    logic       RegWrite, MemWrite;

    logic [31:0] vectornum, errors;
    logic [39:0] testvectors[10000:0];

    logic        new_error;
    logic [15:0] expected;
    logic [6:0]  hash;


  // instantiate device to be tested
    controller dut(clk, reset, op, funct3, funct7b5, Zero,
                ImmSrc, ALUSrcA, ALUSrcB, ResultSrc, AdrSrc, ALUControl, IRWrite, PCWrite, RegWrite, MemWrite);

  // generate clock
    always 
        begin
            clk = 1; #5; clk = 0; #5;
        end

  // at start of test, load vectors and pulse reset
    initial begin
        $readmemb(".\\controller.tv", testvectors);
        vectornum = 0; errors = 0; hash = 0;
        reset = 1; #22; reset = 0;
    end
	
  // apply test vectors on rising edge of clk
    always @(posedge clk) begin
        #1; {op, funct3, funct7b5, Zero, expected} = testvectors[vectornum];
    end

  // check results on falling edge of clk
    always @(negedge clk)
        if (~reset) begin // skip cycles during reset
        new_error=0; 

        if ((ImmSrc!==expected[15:14])&&(expected[15:14]!==2'bxx))  begin
            $display("   ImmSrc = %b      Expected %b", ImmSrc,     expected[15:14]);
            new_error=1;
        end
        if ((ALUSrcA!==expected[13:12])&&(expected[13:12]!==2'bxx)) begin
            $display("   ALUSrcA = %b     Expected %b", ALUSrcA,    expected[13:12]);
            new_error=1;
        end
        if ((ALUSrcB!==expected[11:10])&&(expected[11:10]!==2'bxx)) begin
            $display("   ALUSrcB = %b     Expected %b", ALUSrcB,    expected[11:10]);
            new_error=1;
        end
        if ((ResultSrc!==expected[9:8])&&(expected[9:8]!==2'bxx))   begin
            $display("   ResultSrc = %b   Expected %b", ResultSrc,  expected[9:8]);
            new_error=1;
        end
        if ((AdrSrc!==expected[7])&&(expected[7]!==1'bx))           begin
            $display("   AdrSrc = %b       Expected %b", AdrSrc,     expected[7]);
            new_error=1;
        end
        if ((ALUControl!==expected[6:4])&&(expected[6:4]!==3'bxxx)) begin
            $display("   ALUControl = %b Expected %b", ALUControl, expected[6:4]);
            new_error=1;
        end
        if ((IRWrite!==expected[3])&&(expected[3]!==1'bx))          begin
            $display("   IRWrite = %b      Expected %b", IRWrite,    expected[3]);
            new_error=1;
        end
        if ((PCWrite!==expected[2])&&(expected[2]!==1'bx))          begin
            $display("   PCWrite = %b      Expected %b", PCWrite,    expected[2]);
            new_error=1;
        end
        if ((RegWrite!==expected[1])&&(expected[1]!==1'bx))         begin
            $display("   RegWrite = %b     Expected %b", RegWrite,   expected[1]);
            new_error=1;
        end
        if ((MemWrite!==expected[0])&&(expected[0]!==1'bx))         begin
            $display("   MemWrite = %b     Expected %b", MemWrite,   expected[0]);
            new_error=1;
        end

        if (new_error) begin
            $display("Error on vector %d: inputs: op = 0x%h funct3 = 0x%h funct7b5 = %h", vectornum, op, funct3, funct7b5);
            errors = errors + 1;
        end
        vectornum = vectornum + 1;
        hash = hash ^ {ImmSrc&{2{expected[15:14]!==2'bxx}}, ALUSrcA&{2{expected[13:12]!==2'bxx}}} ^ {ALUSrcB&{2{expected[11:10]!==2'bxx}}, ResultSrc&{2{expected[9:8]!==2'bxx}}} ^ {AdrSrc&{expected[7]!==1'bx}, ALUControl&{3{expected[6:4]!==3'bxxx}}} ^ {IRWrite&{expected[3]!==1'bx}, PCWrite&{expected[2]!==1'bx}, RegWrite&{expected[1]!==1'bx}, MemWrite&{expected[0]!==1'bx}};
        hash = {hash[5:0], hash[6] ^ hash[5]};
        if (testvectors[vectornum] === 40'bx) begin 
            $display("%d tests completed with %d errors", vectornum, errors);
            $display("hash = %h", hash);
            $stop;
        end
        end
endmodule