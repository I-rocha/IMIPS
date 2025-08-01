module divisor240 (
    input clk50,         // Clock de 50 MHz
    input nreset,        // Reset assíncrono (ativo em 0)
    output reg clk240      // Pulso de 1 ciclo a 240 Hz
);

    //parameter DIVISOR = 208_333;  // Valor do divisor
    //reg [17:0] counter;           // 18 bits são suficientes para contar até 208_333
	 
	 parameter DIVISOR = 516_666;  // Valor do divisor
    reg [18:0] counter;           // 18 bits são suficientes para contar até 208_333

    always @(posedge clk50 or negedge nreset) begin
        if (!nreset) begin
            counter <= 0;
            clk240 <= 0;
        end else if (counter == DIVISOR - 1) begin
            counter <= 0;
            clk240 <= 1;            // Pulso de 1 ciclo
        end else begin
            counter <= counter + 18'd1;
            clk240 <= 0;
        end
    end

endmodule