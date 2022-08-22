module PC(
	// IN
	input[31:0] PC_,
	
	// OUT
	output[31:0] PC,
	
	// TIMER
	input clk
	);
	
	reg[31:0] regPC;	// Registrador PC
	
	always @(posedge clk) begin
		regPC <= PC_; // Awake
	end
	
	assign PC = regPC;
	
endmodule
