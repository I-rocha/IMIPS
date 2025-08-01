module debounce(
	input bt,
	input clk,
	output out
);

	parameter[7:0] threshold = 8'b11111111;	// for fast clock
	// parameter[7:0] threshold = 8'b00000111; // for slow clock
	reg [7:0]count;
	reg high;
	
	initial begin
		high = 1'b0;
	end

	always @(posedge clk) begin
		if(bt == 1) begin
			if(count == threshold) begin
				count <= count;
				high <= 1'b1;
			end
			else begin
				count <= count + 1;	
				high <= 1'b0;
			end
		end
		
		
		
		else begin
			count <= 8'b00000000;
			high <= 1'b0;
		end

	end
	
	assign out = high;

endmodule
