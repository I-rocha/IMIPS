module MI(
	// IN
	input[31:0] I,  // Endereco da instrucao
	
	// OUT
	output[31:0] ID // Instrucao
	
	);
	// TODO: Alterar o tamanho da memória de instrução
	
	// reg[31:0] mem_i[400:0];  // Memoria de fato
	
	reg[31:0] mem_i[511:0];
	
	initial begin
		$readmemb("bin.txt", mem_i);
	end
	
	assign ID = mem_i[I];   // Repassa dado do endereco I
	
endmodule
