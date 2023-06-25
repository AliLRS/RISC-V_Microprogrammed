module instrdec(
			input  logic [6:0] op,
			output logic [1:0] ImmSrc);

always_comb begin
	case (op)
		'b0000011: ImmSrc = 2'b00;		// lw
		'b0100011: ImmSrc = 2'b01;		// sw
		'b0110011: ImmSrc = 2'bxx;		// R-Type
		'b1100011: ImmSrc = 2'b10;		// B-Type
		'b0010011: ImmSrc = 2'b00;		// I-Type
		'b1101111: ImmSrc = 2'b11;		// J-Type
		default: ImmSrc = 2'bxx;		// Unknown
	endcase
end

endmodule
