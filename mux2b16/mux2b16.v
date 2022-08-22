module mux2b16(
	input[15:0] in0,
	input[15:0] in1,
	input c,
	output[15:0] out
	);
	
	assign out = (!c)?in0 : in1;
	
endmodule
