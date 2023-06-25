module mux3 #(parameter WIDTH = 4)(
				input logic [WIDTH-1:0] a0, a1, a2, a3,
				input logic [1:0] sel,
				output logic [WIDTH-1:0] result);
				
	assign result = (sel == 2'b00) ? a0 :
                    (sel == 2'b01) ? a1 :
                    (sel == 2'b10) ? a2 :
                    (sel == 2'b11) ? a3 : 0;
endmodule