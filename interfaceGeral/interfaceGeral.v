module interfaceGeral(
	
	//input start,   // Controle de inicio de variavel
	//input io_clk,              // TIMER
	input clk_50,			// TODO: Remove this fake initial clock
	//input bt_clk,			// TODO: Remove this fake button clock
	input bt_reset,
	input bt,
	input [13:0] in,
	output[27:0] display,
	
	//input[31:0] instr_addr, // Instrução
	//input immop,            // Sinal de escolha Imediato
	//input[ 4:0] aluop,      // Sinal da ULA
	//input memw,             // Escrita na memoria
	//input[ 1:0] regw,        // Escrita no banco
	//input cdataop,          // Controle de mux DataOp
	//input cdatast,	         // Controle mux DataStore
	
	//output[31:0] id,        // Instrução de fato
	output[4:0] outd1,     // Dado em reg1
	output[4:0] outd2,	   		 // Dado em reg2
	//output[31:0] outr1,    		 // Resultado ULA
	//output[31:0] outimm, 			 // Imediato da instrução
	//output[31:0] pcout,
	//output[1:0] outregw,
	output[4:0] outdm,      		// Memoria de dados out
	//output[31:0] outterbuffer,		// TODO: Removeeee
	//output outsleep,
	//output outcfl,
	//output ooutop,
	output outawait,
	output outupdate,
	//output outio_clk,
	output [20:0]pc_disp,
	output outclk
);
	// Clock da CPU
	wire cpu_clk;
	wire clk_divided;
	//wire io_clk;

	// MI - Sign Extend out
	wire [31:0] id;
	wire[15:0] imm16;
	wire[31:0] imm32;
	
	// BR IN
	//reg[31:0] dr1_;
	//reg[31:0] dj;
	//reg[ 4:0] ra1, ra2;
	//reg[ 1:0] ew;
	//reg df;
	wire[31:0] dr1_;
	
	// BR OUT
	wire[31:0] dr1, dr2;
	wire cfl;
	
	// ULAS IN
	wire[31:0] op2;
	reg[ 4:0] smt;
	//reg[ 4:0] aluop;

	// ULAS OUT
	wire[31:0] r1;
	wire uf;
	
	// MEM OUT
	wire[31:0] dm;
	
	// MUX inop
	wire[31:0] du;
	
	// MUX OUT
	wire detour;
	
	// UC
	wire[1:0] regw;
	wire immop;
	wire dataop;
	wire datast;
	wire[4:0] aluop;
	wire memw;
	wire cond;
	wire jump;
	wire branch;
	wire jturn;
	wire bturn;
	wire[31:0] pcbranch;
	wire sleep;
	
	//PC
	wire[31:0] pc_;
	wire[31:0] pc;
	wire[31:0] pcone;	
	
	// Timer
	wire update;
	
	// IO
	wire inop;
	wire outop;
	wire await;
	wire[31:0] datauser;
	
	wire[31:0] dm_;
	
	
	//	Timer
	divisor dv(.CLK_50(clk_50), .key(bt_reset), .divided(clk_divided));
	//debounce debounce_clock(.bt(~bt_clk), .out(io_clk), .clk(clk_divided));
	timer tclk(.in_clk(clk_divided), .update(update), .out_clk(cpu_clk));
	
	// IO
	IO io(.inop(inop), .outop(outop), .bt(~bt), .in(in), .dm(dm), .du(du), .display(display), .await(await), .clk(clk_divided), .clk_state(cpu_clk));
	assign update = ~(sleep | await);
	
	mux2b32 mxinop(.in0(dr2), .in1(du), .c0(inop), .out(dm_));
	
	// Mux JBTurn
	mux4b32 mxjbturn(.in3(32'd0), .in2(pcbranch), .in1(dr1), .in0(pcone), .c1(bturn), .c0(jturn), .out(pc_));
	
	// PC
	PC pc0(
		.PC_(pc_),
		.PC(pc),
		.clk(cpu_clk)
	);
	
	// Adder pc
	adder pcadder(
		.in1(1),
		.in2(pc),
		.out(pcone)
	);
	
	// Memoria de Instrução
	MI mi(
		.I(pc), 
		.ID(id)
	);
	
	// Unidade de Controle
	UC uc0(
		.opcode(id[31:26]),	
		.funct(id[4:0]), 
		.regw(regw), 
		.immop(immop), 
		.dataop(dataop), 
		.datast(datast), 
		.aluop(aluop), 
		.memw(memw), 
		.cond(cond), 
		.jump(jump), 
		.branch(branch),
		.sleep(sleep),
		.inop(inop),
		.outop(outop)
	);
	
	// Mux condicional
	mux2b1 mxcon(.in0(1'b1), .in1(cfl), .c0(cond), .out(detour));
	
	// AND Condicional - JUPM
	assign jturn = detour & jump;
	
	// AND Condicional - BRANCH
	assign bturn = detour & branch;
	
	
	// Banco de Registradores
	BR br0(
		.DR1_(dr1_),
		.DJ(pcone), 
		.RA1(id[25:21]), 
		.RA2(id[20:16]), 
		.EW(regw), 
		.DF(uf),
		.DR1(dr1), 
		.DR2(dr2), 
		.CFL(cfl), 
		.clk(cpu_clk)
	);
	
	// Mux escolha do imediato dado o formato de instrução
	mux2b16 mximmop(.in0(id[15:0]), .in1(id[20:5]), .c(immop), .out(imm16));
	
	// Extensor 16->32
	signExtend signextend0(.in(imm16), .out(imm32));
	
	// Adder branch
	adder addbranch(.in1(pcone), .in2(imm32), .out(pcbranch));
	
	// Mux operando 2 da ULA
	mux2b32 mxdataop(.in0(imm32), .in1(dr2), .c0(dataop),.out(op2));
	
	// ULA
	ULAS ulas0( 
		.op1(dr1), 
		.op2(op2), 
		.smt(smt), 
		.aluop(aluop), 
		.r1(r1), 
		.UF(uf)
	);
	
	// Memória de Dados
	MD md0(
		.AM(r1),
		.DM_(dm_), 
		.EW(memw), 
		.DM(dm), 
		.clk(cpu_clk)
	);
	
	// Mux de escrita nos regs
	mux2b32 mxdatast(.in0(dm), .in1(r1), .c0(datast), .out(dr1_));

	// PC display
	bin2display b2dPC(.addr(pc[13:0]), .clk(cpu_clk), .data(pc_disp));

	
	assign outd1 = dr1[4:0];
	assign outd2 = dr2[4:0];
	//assign outr1 = r1;
	//assign outimm = imm32;
	assign outdm = dm[4:0];
	//assign outregw = regw;
	//assign pcout = pc;
	//assign outclk = cpu_clk;
	//assign outcfl = cfl;
	//assign outsleep = sleep;
	//assign ooutop = outop;
	//assign outio_clk = io_clk;
	assign outclk = cpu_clk;
	assign outupdate = update;
	assign outawait = await;
endmodule
