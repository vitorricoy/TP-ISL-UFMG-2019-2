module semaforoA(input clk, input rst, output reg [2:0] A, output integer tempo);
	always @(negedge rst) 
	begin
		A = 3'b100;
		tempo = 0;
	end
	always @(posedge clk)
	begin
		//Conta o período que a luz atual está acesa
		tempo++;
		//Muda o estado do semáforo A de acordo com o tempo passado
		if(A == 3'b100 && tempo == `VERDE) begin
			A = 3'b010;
			tempo = 0;
		end else begin
			if(A == 3'b010 && tempo == `AMARELO) begin
				A = 3'b001;
				tempo = 0;
			end else begin
				if(A == 3'b001 && tempo == `VERMELHO) begin
					A = 3'b100;
					tempo = 0;
				end
			end
		end
	end
endmodule

module semaforoB(input clk, input rst, output reg [2:0] B, input bt, input wire [2:0] A, input wire signed [31:0] tempo);
	reg esperaProximoVerde;
	reg acompanhandoA;
	always @(negedge rst) 
	begin
		B = 3'b100;
		esperaProximoVerde = 1'b0;
		acompanhandoA = 1'b0;
	end

	always @(posedge bt)
	begin
		esperaProximoVerde = 1'b1;
		//Se o botão foi pressionado quando A está verde
		if(A == 3'b100) begin
			acompanhandoA = 1'b1;
			esperaProximoVerde = 1'b0;
		end
	end

	always @(A)
	begin
		//Determina que B deve acompanhar o estado de A
		if(acompanhandoA) begin
			B = A;
			//Quando B está acompanhando A e fica verde, para de acompanhar A
			if(B == 3'b100)
				acompanhandoA = 1'b0;
		end
		//Verifica se A ficou verde nesse instante, e se o botão foi pressionado anteriormente
		if(A == B && esperaProximoVerde) begin
			acompanhandoA = 1'b1;
			esperaProximoVerde = 1'b0;
		end
	end
endmodule

module semaforo(input clk, input rst, input bt,
	output reg [2:0] A, output reg [2:0] B);

	wire [2:0] As;
	wire [2:0] Bs;

	wire signed [31:0] tempo;

	semaforoA semA(clk, rst, As, tempo);
	semaforoB semB(clk, rst, Bs, bt, As, tempo);

	always @(As)
	begin
		A = As;
	end
	always @(Bs)
	begin
		B = Bs;
	end
endmodule
