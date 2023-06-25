module aludec(
		input logic op_5,
		input logic [2:0] funct3,
		input logic funct7b_5,
		input logic [1:0] ALUOp,
		output logic [2:0] ALUControl);
	
	logic RtypeSub;
	assign RtypeSub = funct7b_5 & op_5; // TRUE for Rtype subtract

	always_comb begin
		case(ALUOp)
			2'b00: ALUControl = 3'b000; 				// addition
			2'b01: ALUControl = 3'b001; 				// subtraction
			default: 
					case(funct3) 						// Rtype or Itype ALU
						3'b000: if (RtypeSub)
									ALUControl = 3'b001; // sub
								else
									ALUControl = 3'b000; // add, addi
						3'b010: ALUControl = 3'b101; 	 // slt, slti
						3'b110: ALUControl = 3'b011;	 // or, ori
						3'b111: ALUControl = 3'b010; 	 // and, andi
						default: ALUControl = 3'bxxx; 	 // undefined
					endcase
		endcase
	end
endmodule
