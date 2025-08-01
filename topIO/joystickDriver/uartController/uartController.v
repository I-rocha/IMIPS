module uartController(
	input clk50,
	input Rx,
	input nreset,
	output reg [7:0] data,
	output reg ready
);

wire tick;

tickGenerator tg(.clk50(clk50), .nreset(nreset), .tick(tick));

parameter IDLE = 2'b00, STARTBIT = 2'b01, READ = 2'b10, STOPBIT = 2'b11;
parameter NBits = 4'b1000;

reg [1:0] state;
reg [3:0] countTick;
reg [2:0] countBit;

initial begin
	state = IDLE;
	countTick = 4'b0000;
	countBit = 3'b000;
	data = 8'b0;
	ready = 0;
end

always @(posedge tick or negedge nreset) begin
	if (!nreset) begin
		state <= IDLE;
		countTick <= 0;
		countBit <= 0;
		data <= 0;
		ready <= 0;
	end else begin
		case (state)
			IDLE: begin
				ready <= 0;
				if (!Rx) begin  // start bit detectado
					state <= STARTBIT;
					countTick <= 1;
				end
			end

			STARTBIT: begin
				countTick <= countTick + 1'b1;
				if (countTick == 8) begin
					state <= READ;
					countTick <= 0;
					countBit <= 0;
				end
			end

			READ: begin
				countTick <= countTick + 1'b1;
				if (countTick == 15) begin
					data <= {Rx, data[7:1]};  // LSB primeiro
					countTick <= 0;
					if (countBit == NBits - 1) begin
						state <= STOPBIT;
					end else begin
						countBit <= countBit + 1'b1;
					end
				end
			end

			STOPBIT: begin
				countTick <= countTick + 1'b1;
				if (countTick == 15) begin
					state <= IDLE;
					countTick <= 0;
					countBit <= 0;
					ready <= 1;
				end
			end
		endcase
	end
end

endmodule
