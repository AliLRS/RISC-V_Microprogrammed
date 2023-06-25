module mux3 #(parameter WIDTH = 32)(
				input  logic [WIDTH-1:0] a0, a1, a2,
				input  logic [1:0] sel,
				output logic [WIDTH-1:0] result);
				
	assign result = (sel == 2'b00) ? a0 :
					(sel == 2'b01) ? a1 :
					(sel == 2'b10) ? a2 : 0;
endmodule