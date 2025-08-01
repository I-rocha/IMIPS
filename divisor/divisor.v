module divisor(
	input CLK_50,
	input key,
	output divided
	);

// reg [23:0]count;
reg [24:0]count;
wire reset_n;

assign reset_n = key;

always@(posedge CLK_50 or negedge reset_n)
begin
	if (~reset_n)
      count = 0;
	// else if (count == 25'b0001000000000000000000001)
	//else if(count == 25'b0000000001000000000000000)
	else if(count == 25'b0000000000000000000000010)
	// else if(count == 25'b0100000000000000000000000)
		count = 0;
	else
		count = count + 1'b1;
  end
  
  // assign divided = count[21];
  // assign divided = count[15];
  assign divided = count[1];
  // assign divided = count[23];

endmodule
  