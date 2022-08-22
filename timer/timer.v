module timer(
	input in_clk,
	input update,
	output out_clk
);
	
	flipflopT storage_clk(.T(update), .nclear(1'b1), .out(out_clk), .clk(in_clk));	// Update clock if not sleep
endmodule
