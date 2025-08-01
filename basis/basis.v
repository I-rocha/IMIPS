module basis(
	input cpu_clk,
	input basew,
	input [31:0]dual,
	
	output [31:0]dm
	);
	
	reg [31:0]basis;
	
	initial begin
		basis = 32'b00000000000000000000000000000000;
	end
	
	always @(negedge cpu_clk) begin
		if(basew) begin
			basis <= dual;
		end
		
	end
	
	assign dm = (dual + basis);
	
endmodule
