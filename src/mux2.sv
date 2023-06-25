module mux2 #(parameter WIDTH = 32)(
				input  logic [WIDTH-1:0] a0, a1,
				input  logic sel,
				output logic [WIDTH-1:0] result);
				
	assign result = (sel == 1'b0) ? a0 : a1;
endmodule