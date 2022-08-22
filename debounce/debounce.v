module debounce(
	input bt,
	input clk,
	output out
);
	wire digit0, digit1, digit2;
	wire t0, t1, t2;
	
	//assign t0 = bt;
	assign t1 = digit0;
	assign t2 = digit0 & digit1;

	flipflopT f0(.T(bt), .nclear(bt), .clk(clk), .out(digit0));
	flipflopT f1(.T(t1), .nclear(bt), .clk(clk), .out(digit1));
	flipflopT f2(.T(t2), .nclear(bt), .clk(clk), .out(digit2));
	
	assign out = digit0 & digit1 & digit2;


endmodule
