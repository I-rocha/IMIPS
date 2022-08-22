module divisor(
	input CLK_50,
	input key,
	output divided
	);

reg [23:0]count;
wire reset_n;

assign reset_n = key;

always@(posedge CLK_50 or negedge reset_n)
begin
	if (~reset_n)
      count = 0;
	else if (count == 24'b100000000000000000000001)
		count = 0;
	else
		count = count + 1;
  end
  
  assign divided = count[23];

endmodule
  