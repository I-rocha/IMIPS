module tickGenerator (
    input clk50,
    input nreset,
    output tick
);

    reg [8:0] counter;

    parameter MULTIPLIER = 325;  // 50_000_000 / 153600 ≈ 325.5 → 325

    always @(posedge clk50 or negedge nreset) begin
        if (!nreset)
            counter <= 0;
        else if (counter == MULTIPLIER)
            counter <= 0;
        else
            counter <= counter + 1'b1;
    end

    assign tick = (counter == MULTIPLIER);

endmodule
