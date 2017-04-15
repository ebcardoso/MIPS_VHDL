LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mips_vhdl IS
	PORT (
		clk : IN STD_LOGIC
		--entrada :  IN STD_LOGIC_VECTOR(31 DOWNTO 0);		
		--saida   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END mips_vhdl;

ARCHITECTURE behavior OF mips_vhdl IS

component comp_desloc2esc
  PORT (
		in0  :  IN STD_LOGIC_VECTOR(31 DOWNTO 0);		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_controle
	PORT (
		OPCode    : in STD_LOGIC_VECTOR(5 downto 0);
	
		--sinais de controle saida
		--EX
		Q_RegDst  : out STD_LOGIC;
		Q_OpALU   : out STD_LOGIC_VECTOR(1 DOWNTO 0);
		Q_OrigALU : out STD_LOGIC;
		--MEM
		Q_Branch     : out STD_LOGIC;
		Q_LeMem      : out STD_LOGIC;
		Q_EscreveMem : out STD_LOGIC;
		--WB
		Q_EscreveReg : out STD_LOGIC;
		Q_MemparaReg : out STD_LOGIC
		--
	);
end component;

component comp_ext_sinal
	PORT (
		in0  :  IN STD_LOGIC_VECTOR(15 DOWNTO 0);		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_mem_dados
	PORT (
		clk : IN STD_LOGIC;
		
		leMem      : IN STD_LOGIC;
		escreveMem : IN STD_LOGIC;
		
		endereco     : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dadosEscrita : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		dadosLeitura : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_mem_instrucoes
	PORT (
		clk: IN STD_LOGIC;
		
		endereco : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		dados : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_mux2
	PORT (
		in0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		op : IN STD_LOGIC;
		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_PC
	PORT (
		clk    : in  STD_LOGIC;
		new_PC : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q      : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_registradores
	PORT (
		clk: IN STD_LOGIC;
		escreveReg : IN STD_LOGIC;
		
		regLeitura1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		regLeitura2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		regEscrita  : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		dadosEscrita: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		dados1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_regP1_IF_ID
	port (
		clk        : in  STD_LOGIC;
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_instr  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		Q_PC   : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_I    : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_regP2_ID_EX
	port (
		clk        : in  STD_LOGIC;
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados1 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados2 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_ext    : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEscRT : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		new_regEscRD : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle entrada
		--EX
		new_RegDst  : in STD_LOGIC;
		new_OpALU   : in STD_LOGIC_VECTOR(1 DOWNTO 0);
		new_OrigALU : in STD_LOGIC;
		--MEM
		new_Branch     : in STD_LOGIC;
		new_LeMem      : in STD_LOGIC;
		new_EscreveMem : in STD_LOGIC;
		--WB
		new_EscreveReg : in STD_LOGIC;
		new_MemparaReg : in STD_LOGIC;
		--
		
		Q_PC  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D1  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D2  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_EXT : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEscRT : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		Q_regEscRD : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle saida
		--EX
		Q_RegDst  : out STD_LOGIC;
		Q_OpALU   : out STD_LOGIC_VECTOR(1 DOWNTO 0);
		Q_OrigALU : out STD_LOGIC;
		--MEM
		Q_Branch     : out STD_LOGIC;
		Q_LeMem      : out STD_LOGIC;
		Q_EscreveMem : out STD_LOGIC;
		--WB
		Q_EscreveReg : out STD_LOGIC;
		Q_MemparaReg : out STD_LOGIC
		--
	);
end component;

component comp_regP3_EX_MEM
	port (
		clk : in  STD_LOGIC;
		
		new_zero : in  STD_LOGIC;
		new_ula  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_sum  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_D2   : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEsc : in STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle entrada		
		--MEM
		new_Branch     : in STD_LOGIC;
		new_LeMem      : in STD_LOGIC;
		new_EscreveMem : in STD_LOGIC;
		
		--WB
		new_EscreveReg : in STD_LOGIC;
		new_MemparaReg : in STD_LOGIC;
		--
		
		Q_zero : out STD_LOGIC;
		Q_ula  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_sum  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D2   : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEsc : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle saida		
		--MEM
		Q_Branch     : out STD_LOGIC;
		Q_LeMem      : out STD_LOGIC;
		Q_EscreveMem : out STD_LOGIC;
		
		--WB
		Q_EscreveReg : out STD_LOGIC;
		Q_MemparaReg : out STD_LOGIC
		--
	);
end component;


component comp_regP4_MEM_WB
	port (
		clk : in  STD_LOGIC;
		
		new_ula           : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dado_leitura  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEsc        : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		Q_ula          : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_dado_leitura : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEsc       : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle entrada			
		--WB
		new_EscreveReg : in STD_LOGIC;
		new_MemparaReg : in STD_LOGIC;
		--
		
		--sinais de controle saida		
		--WB
		Q_EscreveReg : out STD_LOGIC;
		Q_MemparaReg : out STD_LOGIC
		--
	);
end component;

component comp_somador32
	port (
		in1 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		in2 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		res : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component comp_somadorPC
	port (
		PC  : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		res : out STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
end component;

	------Sinais auxiliares
		-- do registrador do quarto estagio
		signal Carry4_ula          : STD_LOGIC_VECTOR(31 DOWNTO 0);
		signal Carry4_dado_leitura : STD_LOGIC_VECTOR(31 DOWNTO 0);
		signal Carry4_regEsc       : STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		signal Carry4_EscreveReg : STD_LOGIC;
		signal Carry4_MemparaReg : STD_LOGIC;
		
		-- do quinto estagio
		signal Carry5_muxMemParaReg : STD_LOGIC_VECTOR(31 DOWNTO 0);
	------
		signal inutil1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
		signal inutil2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN
	process (clk,
				Carry4_ula, Carry4_dado_leitura, Carry4_regEsc, Carry4_EscreveReg, Carry4_MemparaReg,
				Carry5_muxMemParaReg)
	BEGIN
		if (clk = '1' and clk'event) then
			--M1  : comp_mux2 port map (Carry4_dado_leitura, Carry4_ula, Carry4_MemparaReg, Carry5_muxMemParaReg);
			--PM2 : comp_registradores port map (clk, Carry4_EscreveReg, inutil1, inutil1, Carry4_regEsc, Carry5_muxMemParaReg, inutil2, inutil2);
		end if;
	end process;
END behavior;