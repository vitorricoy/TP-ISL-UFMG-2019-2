//constantes que determinam a quantidade de ciclos em
//cada estado possivel do semaforo A. Os valores podem
//ser ajustados para qualquer numero positivo menor ou
//igual a 255
`define VERDE 8'd1
`define AMARELO 8'd3
`define VERMELHO 8'd2

module testbench7();
	reg clk,bt,rst;//1 bit, sinais de entrada
	wire [2:0] As;//estado do semaforo A
	wire [2:0] Bs;//estado do semaforo B
	
	integer i;//para as iteracoes do for

	semaforo s(.clk(clk), .rst(rst), .bt(bt), .A(As), .B(Bs));

	//dumping para analisar via gtkwave
	initial begin
		//arquivo de dump para o gtkwave. Deve ser sempre
		//o nome do modulo de testbench seguido de .vcd
		$dumpfile("testbench7.vcd");
		$dumpvars;
	end

	//bloco utilizado para controlar o sinal de clock.
	//crie outras sequencias de forma a testar o seu codigo
	initial begin
		clk = 1'b0;
		for (i=0; i<20; i=i+1)begin
			#2  clk = clk ^ 1'b1; //clock fica 2 instantes no mesmo valor
		end
		#1 $finish;//finalizando a simulacao
	end
	
	//bloco utilizado para controlar o sinal do botao.
	//crie outras sequencias de forma a testar o seu codigo
	initial begin
		bt = 1'b0;//comece zerado

		//botao acionado no instante 4
		#4 bt = 1'b1;
		#1 bt = 1'b0;//solto no instante 5
		//botao acionado no instante 8
		#3 bt = 1'b1;
		#1 bt = 1'b0;//solto no instante 9
	end

	//bloco utilizado para controlar o sinal de reset.
	//crie outras sequencias de forma a testar o seu codigo
	initial begin
		rst = 1'b1;
		#1 rst = 1'b0;//reset apos o primeiro ciclo
	end
	
endmodule
