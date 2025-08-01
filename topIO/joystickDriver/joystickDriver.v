module joystickDriver (
	input clk50,
	input Rx,
	input nreset, 
	
	output [10:0] xA,
	output [10:0] yA,
	output zBt
);


parameter SYNC = 2'b00, XREAD = 2'b01, YREAD = 2'b10, ZREAD = 2'b11;
parameter SYNCPATTERN = 8'b10101010;

initial begin
	state = SYNC;
	seq = 1'b0;
end

reg [10:0]bufferX;
reg [10:0]bufferY;
reg bufferZ;
reg [1:0]state;
wire [7:0]byteD;
reg [10:0]dataX;
reg [10:0]dataY;

reg seq;
reg readyD;

wire ready;
wire readyRise;

uartController uc(.clk50(clk50), .Rx(Rx), .nreset(nreset), .data(byteD), .ready(ready));


always @(posedge clk50 or negedge nreset) begin
	if(!nreset) begin
		seq <= 1'b0;
		state <= SYNC;
		readyD <= ready;
	end
	
	else begin	
		readyD <= ready;
		if(readyRise) begin
			case (state)
				SYNC: begin
					if(seq == 1'b0) begin
						if(byteD == SYNCPATTERN) begin
							seq <= 1'b1;
						end
						else begin
							seq <= 1'b0;
							state <= SYNC;
						end
					end
					else begin
						if(byteD == SYNCPATTERN) begin
							seq <= 1'b0;
							state <= XREAD;
						end
						else begin
							seq <= 1'b0;
							state <= SYNC;
						end
					end
				end
				XREAD: begin
					if(seq == 1'b0) begin
						dataX[7:0] <= byteD;
						seq <= 1'b1;
					end
					else begin
						dataX[10:8] <= byteD[2:0];
						seq <= 1'b0;
						state <= YREAD;
						end
				end
				YREAD: begin
					if(seq == 1'b0) begin
						seq <= 1'b1;
						dataY[7:0] <= byteD;
					end
					else begin
						seq <= 1'b0;
						dataY[10:8] <= byteD[2:0];
						state <= ZREAD;
						end
				end
				ZREAD: begin
					seq <= 1'b0;
					bufferX <= dataX;
					bufferY <= dataY;
					bufferZ <= byteD[0];
					state <= SYNC;
				end
			endcase

		end
	end
end

	assign readyRise = ready & ~readyD;
	assign xA = bufferX;
	assign yA = bufferY;
	assign zBt = bufferZ;

endmodule
