module adder #(parameter WIDTH = 4)(
                input [WIDTH-1:0] a, b,
                output [WIDTH-1:0] y);
                
    assign y = a + b;
endmodule