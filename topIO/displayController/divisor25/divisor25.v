module divisor25(
	input clk50,
	output reg clk25
);

	always @(posedge clk50)begin
		clk25 <= ~clk25;
	end

endmodule
