module SD(
	// IN
	input [31:0] AM,  // Endereco
	input [2:0] BYTE, // Byte
	
	// OUT
	output[7:0] DM  // Dado de leitura
	
	// TIMER
	// input clk         // clock
);
	// TODO: Aumentar a memória
	
	// Memmory with 8 Byte-len
	reg[7:0] mem_d[1:0];  // Memoria de fato

	
	initial begin
		//$readmemb("init.txt", mem_d);
	end
	
		/*
		mem_d[0] <= 8'b01001000;
		mem_d[1] <= 8'b01100101;
		mem_d[2] <= 8'b01101100;
		mem_d[3] <= 8'b01101100;
		mem_d[4] <= 8'b01101111;
		mem_d[5] <= 8'b00100000;
		mem_d[6] <= 8'b01010111;
		mem_d[7] <= 8'b01101111;
		mem_d[8] <= 8'b01110010;
		mem_d[9] <= 8'b01101100;
		mem_d[10] <= 8'b01100100;	
		*/

	/*
	always @(negedge clk) begin
	
		case (EW)		
			1'b1 : mem_d[AM] <= DM_;  // Escrita habilitada
		endcase	
			
	end
	*/
	 assign DM = mem_d[AM];  // saida

endmodule
