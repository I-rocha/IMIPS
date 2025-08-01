module deadline(
	input cpu_clk,
	input interrupt,
	input start_time,
	input toCount,
	
	output timeout
);

	reg countOp;
	reg [7:0]count;
	
	
	//parameter threshold = 6'b110010;
	parameter threshold = 6'b111111;		// 63 instructions
	// parameter threshold = 8'b11111110;
	
	initial begin
		count = 6'b000000;
		// count = 8'b11111111;
	end

	always @(posedge cpu_clk) begin
		// Start
		if(start_time) begin
			countOp <= 1'b1;
			count <= 6'b000000;
		end
		
		// Stop
		else if(interrupt) begin
			count <= 6'b000000;
			countOp <= 1'b0;
		end
		
		// Count
		else if (countOp && toCount) begin
			count <= count + 1;
			countOp <= countOp;
		end
		
		else begin
			count <= count;
			countOp <= countOp;
		end
	end

	assign timeout = (count == threshold);
	
endmodule
