module propagate(
	input bt_pressed,
	output bt_high
);

reg out;

initial begin
	out = 1'b0;
end

always @(posedge bt_pressed) begin
	out <= ~out;
end

assign bt_high = out;

endmodule
