module topIO(
	input clk50,
	input Rx,
	input nreset,
	input resetPos,
	input [1:0]outAlt,
	
	input Mc,
	// Operação Escrita
	input EWfb,
	input [8:0] dt,
	input [9:0] frameX,
	input [9:0] frameY,
	// Operação Leitura
	output [9:0] mX,
	output [9:0] mY,
	output zBt,
	
	
	
	output hSync,
	output vSync,
	output clk25,
	output [7:0] red,
	output [7:0] green, 
	output [7:0] blue,
	output [10:0]outGeneral,
	output video_on
);
	
	localparam [9:0] X_MAX = 159;
	localparam [9:0] Y_MAX = 119;
	
	reg [7:0] mouseColor = 8'b11100000; // Vermelho por padrão

	wire [10:0]xA;
	wire [10:0]yA;
	wire [9:0]hPos;
	wire [9:0]vPos;
	wire [8:0]pixelRGB;
	wire bt;
	wire clk240;

	joystickDriver jd(.clk50(clk50), .Rx(Rx), .nreset(nreset), .xA(xA), .yA(yA), .zBt(bt));
	divisor240 d240(.clk50(clk50), .nreset(1'b1), .clk240(clk240));
	displayController dc(.clk50(clk50), .mouseX(mouseX), .mouseY(mouseY), .pixelRGB(pixelRGB), .mouseColor(mouseColor), .hPos(hPos), .vPos(vPos), .hSync(hSync), .vSync(vSync), .clk25(clk25), .red(red), .green(green), .blue(blue), .video_on(video_on));
	framebuffer fb(.clk50(clk50), .dt(dt), .Ax(hPos), .Ay(vPos), .WAx(frameX), .WAy(frameY), .SW(EWfb), .pixelRGB(pixelRGB));
	
	always @(posedge clk50) begin
		if(Mc) mouseColor <= frameY;
	end
	
	//640/4 x 480/4 = 160 x 120
	reg [9:0]mouseX = 79;
	reg [9:0]mouseY = 59;
	
	// Smooth movement
	localparam MAX_POSSIBLE_VALUE = 511;	// Magnitude de valor do joystick
	localparam REDUCTION_SCALE = 4;			// Escala de redução em potência de 2
	localparam [6:0] MAX_VALUE = MAX_POSSIBLE_VALUE >> REDUCTION_SCALE;	// Valor normalizado | Cuidado ao alterar para não causar overflow em operações
	
	reg [6:0]countH = 0;
	reg [6:0]countV = 0;
	reg hLastOrientation = 0;
	reg vLastOrientation = 0;
	wire hOrientation;
	wire vOrientation;
	wire [9:0]hAbs;
	wire [9:0]vAbs;
	wire [6:0] hStep = (hAbs >> 4);
	wire [6:0] vStep = (vAbs >> 4);
	
	wire signed [10:0] hAux;
	wire signed [10:0] vAux;
	
	assign hAux = $signed(xA) - 11'sd512;
	assign vAux = $signed(yA) - 11'sd512;
	
	assign hOrientation = (hAux < 0)? 0 : 1;	// 0-> Esquerda ou negativo | 1 -> Direita ou positivo
	assign vOrientation = (vAux < 0)? 0 : 1;	// 0-> Baixo ou negativo | 1 -> Cima ou positivo
	
	assign hAbs = (hOrientation) ? hAux : -hAux;
	assign vAbs = (vOrientation) ? vAux : -vAux;
	// deadzone
	wire joystickIdle = (hAbs < 10'd16) && (vAbs < 10'd16);
	
	
	always @(posedge clk240) begin
		hLastOrientation <= hOrientation;
		vLastOrientation <= vOrientation;
		
	
		if(resetPos) begin
			mouseX <= 79;
			mouseY <= 59;
		end
		else begin
			if(!joystickIdle) begin
				// Update walk horizontal
				if(hLastOrientation == hOrientation) begin 
					
					if(countH >= MAX_VALUE) begin
						countH <= 7'd0;
						if(hOrientation) mouseX <= (mouseX < X_MAX) ? mouseX + 1 : mouseX;	
						else mouseX <= (mouseX > 10'd0) ? mouseX - 1 : mouseX;	
					end
					else begin
						countH <= ((countH + hStep) > MAX_VALUE) ? MAX_VALUE : countH + hStep; // Reduz em 16x o step, vai para fundo de escala de 31 mais ou menos
					end
					
				end
				else countH <= 7'd0;
				
				// Update walk vertical
				if(vLastOrientation == vOrientation) begin 
					
					if(countV >= MAX_VALUE) begin
						countV <= 7'd0;
						if(!vOrientation) mouseY <= (mouseY < Y_MAX) ? mouseY + 1 : mouseY;	
						else mouseY <= (mouseY > 10'd0) ? mouseY - 1 : mouseY;	
					end
					else begin
						countV <= ((countV + vStep) > MAX_VALUE) ? MAX_VALUE : countV + vStep; // Reduz em 16x o step, vai para fundo de escala de 31 mais ou menos
					end
					
				end
				else countV <= 7'd0;
			end
		/*
		if(xA > 11'd575 && mouseX < 10'd159) mouseX <= mouseX + 10'd1;
		else if (xA < 11'd400 && mouseX > 10'd0) mouseX <= mouseX - 10'd1;
		else mouseX <= mouseX;
		
		if(yA > 11'd575 && mouseY > 10'd0) mouseY <= mouseY - 10'd1;
		else if (yA < 11'd400 && mouseY < 10'd119) mouseY <= mouseY + 10'd1;
		else mouseY <= mouseY;
		*/
		
		end
	end
	assign outGeneral = (outAlt == 2'b00)? xA : ((outAlt == 2'b01)? yA : ((outAlt == 2'b10)? bt : 11'd0)); //00:xA | 01: yA | 10: zBt | 11: 0
	
	assign mX = mouseX;
	assign mY = mouseY;
	assign zBt = bt;
	
endmodule