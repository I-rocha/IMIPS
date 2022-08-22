module UC(
	
	// IN
	input[5:0] opcode,
	input[4:0] funct,
	
	// OUT
	output[1:0] regw,
	output immop,
	output dataop,
	output datast,
	output[4:0] aluop,
	output memw,
	output cond,
	output jump,
	output branch,
	output sleep,
	output inop,
	output outop
);
	
	reg[16:0] out;

	always @* begin
		case (opcode)
		// Aritmetico
		6'b000001 : 
		begin 
			case (funct)
			5'b00001 : begin out = 17'b11x11000010000000; end // add
			5'b00010 : begin out = 17'b11x11000100000000; end // sub
			5'b00011 : begin out = 17'b11101000010000000; end // addi
			5'b00100 : begin out = 17'b11101000100000000; end // subi
			default : begin out = 17'b00000000000000000; end  // NOP
			endcase
		end
		// Bitwise
		6'b000010 : begin 
			case (funct)
			5'b00001 : begin out = 17'b11x11000110000000; end // AND
			5'b00010 : begin out = 17'b11x11001000000000; end // OR
			5'b00011 : begin out = 17'b11xx1001010000000; end // NOT
			5'b00100 : begin out = 17'b11x11001100000000; end // XOR
			5'b00101 : begin out = 17'b11101000110000000; end // ANDi
			5'b00110 : begin out = 17'b11101001000000000; end // ORi
			5'b00111 : begin out = 17'b11101001010000000; end // NOTi
			5'b01000 : begin out = 17'b11101001100000000; end // XORi
			5'b01001 : begin out = 17'b11xx1001110000000; end // shiftl
			5'b01010 : begin out = 17'b11xx1010000000000; end // shiftr
			default : begin out = 17'b00000000000000000; end	// NOP
			endcase
		end
		// Comparacao
		6'b000011 : begin 
			case (funct)
			5'b00001 : begin out = 17'b01x1x010010000000; end // less
			5'b00010 : begin out = 17'b01x1x010100000000; end // grand
			5'b00011 : begin out = 17'b01x1x010110000000; end // eq
			5'b00100 : begin out = 17'b01x1x011000000000; end // neq
			5'b00101 : begin out = 17'b01x1x011010000000; end // leq
			5'b00110 : begin out = 17'b01x1x011100000000; end // geq
			5'b00111 : begin out = 17'b0110x010010000000; end // lessi
			5'b01000 : begin out = 17'b0110x010100000000; end // grandi
			5'b01001 : begin out = 17'b0110x010110000000; end // eqi
			5'b01010 : begin out = 17'b0110x011000000000; end // neqi
			5'b01011 : begin out = 17'b0110x011010000000; end // leqi
			5'b01100 : begin out = 17'b0110x011100000000; end // geqi
			default : begin out = 17'b00000000000000000; end   // NOP
			endcase
		end
		// Movimentacao
		6'b000100 : begin out = 17'b11x11000000000000; end // mv
		6'b000101 : begin out = 17'b11101000000000000; end	// mvi
		6'b000110 : begin out = 17'b0000x000011000000; end // sw
		6'b000111 : begin out = 17'b11000000010000000; end // lw
		6'b001000 : begin out = 17'b11101011110000000; end // lup
		6'b001001 : begin out = 17'b11101000000000000; end // ldown
		
		// Desvio
		6'b001010 : begin out = 17'b00xxxxxxxx0010000; end // jump
		6'b001011 : begin out = 17'b10xxxxxxxx0010000; end // jal
		6'b001100 : begin out = 17'b00xxxxxxxx0110000; end // jc
		6'b001101 : begin out = 17'b000xxxxxxx0001000; end // branch
		6'b001110 : begin out = 17'b100xxxxxxx0001000; end // bal
		6'b001111 : begin out = 17'b000xxxxxxx0101000; end // bc
		6'b010000 : begin out = 17'b0000x000011000010; end	// Get/IN
		6'b010001 : begin out = 17'b0000x000010000001; end	// Print/OUT
		6'b111111 : begin out = 17'b00000000000000100; end // STOP	
		default : begin out = 17'b00000000000000000; end   // NOP
		
		
		endcase
	end
	
	assign regw[1] = out[16];
	assign regw[0] = out[15];
	assign immop = out[14];
	assign dataop = out[13];
	assign datast = out[12];
	assign aluop[4] = out[11];
	assign aluop[3] = out[10];
	assign aluop[2] = out[9];
	assign aluop[1] = out[8];
	assign aluop[0] = out[7];
	assign memw = out[6];
	assign cond = out[5];
	assign jump = out[4];
	assign branch = out[3];
	assign sleep = out[2];
	assign inop = out[1];
	assign outop = out[0];

endmodule
