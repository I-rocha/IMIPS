module mux2b32(
	input[31:0] in0,
	input[31:0] in1,
	input c0,
	output[31:0] out
);
	assign out = (!c0)?in0 : in1;

endmodule
