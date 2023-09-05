module ULAS(
	// IN
	input[31:0] op1, op2,   // Operandos
	input[4:0] smt,         // Shift amount
	input[4:0] aluop,       // Controle 
	
	// OUT
	output reg [31:0] r1,   // Resultado
	output reg UF           // Flag
	);
	
	reg of;
	
	always @* begin
		
		case(aluop)
			// ARITMETICO
			5'b00001 : begin
				r1 = op1 + op2;
				of = ((~op1[31] & ~op2[31] & r1[31]) | (op1[31] & op2[31] & ~r1[31]));  // OverFlow
				UF = of; 
			end   // Add
			
			
			5'b00010 : begin
				r1 = op1 - op2;
				of = ((~op1[31] & ~op2[31] & r1[31]) | (op1[31] & op2[31] & ~r1[31]));  // OverFlow
				UF = of; 
			end   // Sub
			
			5'b10000 : begin
				r1 = op1 * op2;
				UF = 0;
				of = 0;
			end	// Mult
			
			5'b10001 : begin
				r1 = op1 / op2;
				UF = 0;
				of = 0;
			end	// Div
			
			// LOGICO
			5'b00011 : begin r1 = op1 & op2;    UF = 1'b0; of = 0; end   // AND
			5'b00100 : begin r1 = op1 | op2;    UF = 1'b0; of = 0; end   // OR
			5'b00101 : begin r1 = ~op1;         UF = 1'b0; of = 0; end   // NOT
			5'b00110 : begin r1 = op1 ^ op2;    UF = 1'b0; of = 0; end   // XOR
			5'b00111 : begin r1 = op1 << smt;   UF = 1'b0; of = 0; end   // shiftL
			5'b01000 : begin r1 = op1 >> smt;   UF = 1'b0; of = 0; end   // shiftR
			
			// COMPARACAO
			5'b01001 : begin UF = (op1 < op2);  r1 = 32'b0; of = 0; end  // Less
			5'b01010 : begin UF = (op1 > op2);  r1 = 32'b0; of = 0; end  // Grand 
			5'b01011 : begin UF = (op1 == op2); r1 = 32'b0; of = 0; end  // Equal
			5'b01100 : begin UF = (op1 != op2); r1 = 32'b0; of = 0; end  // Not Equal
			5'b01101 : begin UF = (op1 <= op2); r1 = 32'b0; of = 0; end  // Less Equal
			5'b01110 : begin UF = (op1 >= op2); r1 = 32'b0; of = 0; end  // Grand Equal			
			
			// LoadUp
			5'b01111 : begin
				UF = 0; 
				of = 0;
				r1 = op2 << 16;
			end
			
			default  : begin
				r1 = op2;
				UF = 0;
				of = 0; 
				end
		endcase
	end
	
endmodule
