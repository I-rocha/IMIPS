module mux4b32(
	input[31:0] in0,
	input[31:0] in1,
	input[31:0]	in2,
	input[31:0] in3,
	input c0, c1,
	output[31:0] out
);
	// (00, in0), (01, in1), (10, in2), (11, in3)
	assign out = (!c1)? ((!c0)? in0 :in1) :  ((!c0)? in2 :in3);

endmodule
