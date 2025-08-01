module flipflopT(
	input T,
	input nclear,
	
	output reg out,
	
	input clk
);
	
	always @(posedge clk or negedge nclear) begin
		
		if (!nclear) begin out <= 1'b0 ;end
		
		else begin		
		
			if (T == 1'b1) begin out <= ~out; end
			else begin out <= out; end
			
		end
		
	end

endmodule