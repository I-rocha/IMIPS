// Quartus Prime Verilog Template
// Single Port ROM
// 16bits x 2^14 adrr = 32Kb


module bin2display
#(parameter DATA_WIDTH=28, parameter ADDR_WIDTH=14)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] data
);

	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file single_port_om_init.txt.  Without this file,
	// ths design will not compile.

	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file, or see the "Using $readmemb and $readmemh"
	// template later in this section.

	initial
	begin
		$readmemb("bin2display.txt", rom);
	end

	always @ (posedge clk)
	begin
		data <= rom[addr];
	end

endmodule
