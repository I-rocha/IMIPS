module MD(
	// IN
	input [31:0] AM,  // Endereco
	input [31:0] DM_, // Dado de escrita
	input EW,         // Sinal para escrita
	
	// OUT
	output[31:0] DM,  // Dado de leitura
	
	// TIMER
	input clk         // clock
);
	// TODO: Aumentar a memória
	reg[31:0] mem_d[300:0];  // Memoria de fato
	
	initial begin
		//mem_d[5] = 32'b00000000000000000000000000001001; // 9
		//mem_d[25] = 32'b00000000000000000000000000001001; // 9
	end
	always @(negedge clk) begin
	
		case (EW)		
			1'b1 : mem_d[AM] <= DM_;  // Escrita habilitada
		endcase	
			
	end
	
	assign DM = mem_d[AM];  // saida

endmodule
