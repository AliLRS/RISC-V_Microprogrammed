module mux5 #(parameter WIDTH = 4)(
				input logic [WIDTH-1:0] a0, a1, a2, a3, a4,
				input logic [2:0] sel,
				output logic [WIDTH-1:0] result);
				
	assign result = (sel == 3'b000) ? a0 :
					(sel == 3'b001) ? a1 :
					(sel == 3'b010) ? a2 :
					(sel == 3'b011) ? a3 :
					(sel == 3'b100) ? a4 : 0;
endmodule