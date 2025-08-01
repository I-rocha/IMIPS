module interruption(
	input cpu_clk,
	input interrupt_,
	
	output interrupt
);

	reg regInterrupt;
	
	always @(posedge cpu_clk) begin
	
		if(regInterrupt) begin
			regInterrupt = 1'b0;
		end
		
		else begin
			regInterrupt = interrupt_;
		end
	end
	
	assign interrupt = regInterrupt;
	
endmodule