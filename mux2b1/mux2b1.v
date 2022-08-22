module mux2b1(
	input  in0,
	input  in1,
	input  c0,
	output out
	);
	
	assign out = (!c0)? in0 : in1;

endmodule
