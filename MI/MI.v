module MI(
	// IN
	input[31:0] I,  // Endereco da instrucao
	
	// OUT
	output[31:0] ID // Instrucao
	
	);
	// TODO: Alterar o tamanho da memória de instrução
	
	reg[31:0] mem_i[31:0];  // Memoria de fato
	
	initial begin
	
		// Fibonacci
		mem_i[0 ] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;	// START
		mem_i[1 ] = 32'b00010100000000000000000000000000;
		mem_i[2 ] = 32'b01000000000000000000000000000000;
		mem_i[3 ] = 32'b00011100000000000000000000000000;
		mem_i[4 ] = 32'b00111000000000000000000000000101;	//bal
		mem_i[5 ] = 32'b00010000001011010000000000000000;
		mem_i[6 ] = 32'b00010100000000000000000000000000;
		mem_i[7 ] = 32'b00011000000000010000000000000000;
		mem_i[8 ] = 32'b01000100000000000000000000000000;
		mem_i[9 ] = 32'b11111100000000000000000000000000;	// STOP
		mem_i[10] = 32'b00010001010000000000000000000000;
		mem_i[11] = 32'b00010101011000000000000000000000;
		mem_i[12] = 32'b00010101100000000000000000100000;
		mem_i[13] = 32'b00010101101000000000000000100000;
		mem_i[14] = 32'b00001101010000000000000001001011;
		mem_i[15] = 32'b00110011111000000000000000000000;
		mem_i[16] = 32'b00000000000000000000000000000000;	// NOP
		mem_i[17] = 32'b00000101010000000000000001000100;
		mem_i[18] = 32'b00001101011010100000000000000110;
		mem_i[19] = 32'b00111100000000000000000000000101;	// branch afterfor
		mem_i[20] = 32'b00010001110011010000000000000000;	// mv r14, r13
		mem_i[21] = 32'b00000101101011000000000000000001;
		mem_i[22] = 32'b00010001100011100000000000000000;
		mem_i[23] = 32'b00000101011000000000000000100011;	// addi
		mem_i[24] = 32'b00110100000000001111111111111001;	// branch for
		mem_i[25] = 32'b00110011111000000000000000000000;	// jc 
		//mem_i[26] = 32'b;											// END
		
		/*
		mem_i[0 ] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;	// START
		mem_i[1 ] = 32'b000101000010000000000000011xxxxx;	// mvi
		mem_i[2 ] = 32'b000101000100000000000000100xxxxx;	// mvi
		mem_i[3 ] = 32'b0001000001100001xxxxxxxxxxxxxxxx;	// mv
		mem_i[4 ] = 32'b0000010001100010xxxxxxxxxxx00001;	// add
		mem_i[5 ] = 32'b00001100011000000000000100001011;	// leqi
		mem_i[6 ] = 32'b001111xxxxxxxxxx0000000000000011;	// bc
		mem_i[7 ] = 32'b000101000010000000000010100xxxxx;	// mvi
		mem_i[8 ] = 32'b001101xxxxxxxxxx0000000000000011;	// branch
		mem_i[9 ] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;	// ELSE
		mem_i[10] = 32'b000101000010000000000000001xxxxx;	// mvi
		mem_i[11] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;	// END
		*/
		/*
		mem_i[0 ] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;	// START
		mem_i[1 ] = 32'b01000011110000000000000000000000;	// get
		mem_i[2 ] = 32'b01000111110000000000000000000000;	// print
		*/
		
		/*
		mem_i[0 ] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;	// START
		mem_i[1 ] = 32'b0000011111011111xxxxxxxxxxx00001;	// add
		mem_i[2 ] = 32'b01000111110xxxxx0000000000000000;  // print
		*/
		/*
		mem_i[0 ] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;	// START
		
		mem_i[1 ] = 32'b000101000010000000011111101xxxxx;	// mvi
		mem_i[2 ] = 32'b000101000100000000000001010xxxxx;	// mvi
		mem_i[3 ] = 32'b00011000010000010000000000000000;  // sw
		mem_i[4 ] = 32'b01000100010xxxxx0000000000000000;  // print
		*/
		/**/
		
	end
	
	assign ID = mem_i[I];   // Repassa dado do endereco I
	
endmodule
