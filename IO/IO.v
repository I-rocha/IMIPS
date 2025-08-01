module IO(
	// IN
	input inop,
	input outop,
	input bt,
	
	input[13:0] in,      // TODO: Checar tamanho dos dados de entrada correto	
	input[31:0] dm,
	
	
	// OUt
	output[31:0] du,	// Data from user
	output[27:0] display,
	output reg await,
	
	// TIMER
	input clk,
	input clk_state
	
);

	// Button
	wire bt_high;
	wire bt_pressed;
	reg allow_state;
	reg[31:0] inbuff;
	reg[31:0] outbuff;
	
	// Button pressed
	debounce db(.bt(bt), .out(bt_pressed), .clk(clk));
	propagate ppg(.bt_pressed(bt_pressed), .bt_high(bt_high));
	
	initial begin
		inbuff = 32'b00000000000000000000000000000000;
		outbuff = 32'b00000000000000000000000000000000;
		allow_state = 1'b1;
	end
	
	always @(negedge clk) begin
		
		// Input
		if (inop) begin
			
			// Button pressed
			if (bt_high == allow_state) begin
				inbuff = in[13:0];
				outbuff = outbuff;
				await = 1'b0;
				allow_state <= ~allow_state;
			end
			
			// Button not pressed
			else begin
				
				// Se clock está em nível alto
				if (clk_state) begin
					await = 1'b1;
					inbuff = inbuff;
					outbuff = outbuff;
				end
				
				// Se clock está em nível baixo
				else begin
					await = await;
					inbuff = inbuff;
					outbuff = outbuff;
				end
			end
		end
		
		// Output
		else if (outop) begin
			inbuff = inbuff;
			outbuff = dm;
			await = 1'b0;
		end
		
		// Nothing
		else begin
			inbuff = inbuff;
			outbuff = outbuff;
			await = 1'b0;
		end
		
	end
	
	// Display
	bin2display b2d(.addr(outbuff[13:0]), .clk(clk), .data(display));
	
	assign du = inbuff;
	
endmodule
