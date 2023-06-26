module flopenr #(parameter WIDTH = 32)(
					input  logic 			 clk, 
					input  logic			 rst,
					input  logic			 en,
					input  logic [WIDTH-1:0] d,
					output logic [WIDTH-1:0] q);
				
	always_ff@(posedge clk, posedge rst)
		if(rst) 
			q<=0;
		else if(en)    
			q<=d;
		
endmodule