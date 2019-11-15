//constantes que determinam a quantidade de ciclos em
//cada estado possivel do semaforo A. Os valores podem
//ser ajustados para qualquer numero positivo menor ou
//igual a 255
`define VERDE 8'd1
`define AMARELO 8'd3
`define VERMELHO 8'd2

//definicao do modulo de testbench. Mantenha o mesmo
//nome desse arquivo (sem a extensao .v)
module testbench14();
	reg clk,bt,rst; //1 bit, sinais de entrada
	wire [2:0] As; //estado do semaforo A
	wire [2:0] Bs; //estado do semaforo B
    integer i; //para o loop

	semaforo s(.clk(clk), .rst(rst), .bt(bt), .A(As), .B(Bs));
	//dumping para analisar via gtkwave
	initial begin
		//arquivo de dump para o gtkwave. Deve ser sempre
		//o nome do modulo de testbench seguido de .vcd
		$dumpfile("testbench14.vcd");
		$dumpvars;
	end

	initial begin
		clk = 1'b0;
		for (i = 0; i < 11; i = i + 1)begin
			#3  clk = clk ^ 1'b1; //clock fica por 3 instantes no mesmo valor.
		end
		#1 $finish; //finalizando
	end

	initial begin
		bt = 1'b0; // botao comeca solto

		#2 bt = 1'b1; // botao acionado no instante 2
		#1 bt = 1'b0; // botao solto no instante 3
	end

	initial begin
		rst = 1'b1;
		#1 rst = 1'b0; //reset depois do primeiro ciclo
	end

endmodule