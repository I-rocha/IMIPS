module BR(
	// IN
	input[31:0] DR1_,        // Dado para escrita
	input[31:0] DJ,          // Data Jump
	input[ 4:0] RA1, RA2,    // Enderecos reg 1 e 2
	input[ 1:0] EW,          // Sinal de escrita
	input DF,                // Data Flag
	
	// OUT	
	output[31:0] DR1, DR2,   // Dado reg 1 e 2
	output CFL,              // Dado armazenado em flag
	
	// TIMER
	input clk                // Clock
);

	// REGISTRADORES
	reg[31:0] register[31:0];  // 32x32 regs
	reg[31:0] RF;              // Register Flag	
	parameter AJ = 5'b11111;   // Endereco Reg RJ
	
	// ONLY FOR TEST           0    1    1    2    2    3
	initial begin      //      5    0    5    0    5    0
		//register[30] <= 32'b00000000000000000000000000000101;  // 5
		//register[31] <= 32'b00000000000000000000000000010100;  // 20
	end
	
	
	always @(negedge clk) begin
	
		case(EW)
		// 2'b00 : Nao escrever nada
			2'b01 : RF[0] <= DF;             // Escrever em Reg RF[0]
			2'b10 : register[AJ] <= DJ;      // Escrever em Reg RJ
			2'b11 : register[RA1] <= DR1_;   // Escrever em reg RA1
			default: ;
		endcase
		
	end
	
	// Repassa dados dos regs
	assign DR1 = register[RA1];
	assign DR2 = register[RA2];
	assign CFL = RF[0];

endmodule
