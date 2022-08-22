module signExtend(
	input [15:0] in,
	output[31:0] out
	);
	
	// Preenche os primeiros bits de sinal
	assign out[31:15] = (in[15] == 1'b1)? 17'b11111111111111111 : 17'b00000000000000000;  
	
	// Copia os bits restantes
	assign out[14:0] = in[14:0];
	
endmodule
