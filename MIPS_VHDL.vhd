LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mips_vhdl IS
	PORT (
		clk : IN STD_LOGIC;
		inst_out  : OUT STD_LOGIC_VECTOR(31 downto 0);
		pc_out    : OUT STD_LOGIC_VECTOR(31 downto 0);
--		inst_out2 : OUT STD_LOGIC_VECTOR(31 downto 0);
--		pc_out2   : OUT STD_LOGIC_VECTOR(31 downto 0);
		dados1    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados2    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados11   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados22   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		ulaRes    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		opUla     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		ulaCtrl   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		funcc     : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		--ulaResR3 : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
		r24 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		r18 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		r02 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		r14 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		state : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		writ_reg : OUT STD_LOGIC
	);
END mips_vhdl;

ARCHITECTURE behavior OF mips_vhdl IS

-- Estagio 1: Busca
component comp_mips_controle is
	port (
		clk      : in  STD_LOGIC;
		new_inst : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		allow_W_R1 : out  STD_LOGIC;
		allow_R_R1 : out  STD_LOGIC;
		allow_W_R2 : out  STD_LOGIC;
		allow_R_R2 : out  STD_LOGIC;		
		allow_W_R3 : out  STD_LOGIC;
		allow_R_R3 : out  STD_LOGIC;		
		allow_W_R4 : out  STD_LOGIC;
		allow_R_R4 : out  STD_LOGIC;
		
		allow_W_PC : out STD_LOGIC;
		
		--sinais de controle saida
		--EX
--		EX_RegDst  : out STD_LOGIC;
--		EX_OpALU   : out STD_LOGIC_VECTOR(1 DOWNTO 0);
--		EX_OrigALU : out STD_LOGIC;
		--MEM
--		MEM_Branch     : out STD_LOGIC;
--		MEM_LeMem      : out STD_LOGIC;
--		MEM_EscreveMem : out STD_LOGIC;
		--WB
--		WB_EscreveReg : out STD_LOGIC;
--		WB_MemparaReg : out STD_LOGIC;
		--
		
		next_state : out STD_LOGIC_VECTOR(3 DOWNTO 0)
		
--		in1 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
--		in2 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
--		in3 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
--		in4 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
--		in5 : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

COMPONENT comp_PC IS
	PORT (
		able_write : in STD_LOGIC;
		
		clk    : in  STD_LOGIC;
		new_PC : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q      : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_mem_instrucoes IS
	PORT (
		clk: IN STD_LOGIC;
		
		regLeitura1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

--COMPONENT comp_mem_instrucoes IS
--    GENERIC (
--        DATA_WIDTH : integer := 32;
--        ADDR_WIDTH : integer := 32 -- 2 ^ ADDR_WIDTH addresses
--    );
--    PORT (
--        a_clock  : in std_logic;
--        --a_wren   : in std_logic;
--        a_read   : in std_logic;
--        a_addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
--        --a_data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
--        a_data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
--    );
--END COMPONENT;

COMPONENT comp_somadorPC IS
	PORT (
		PC  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		res : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

--Estagio 2: Decodificacao da Instrucao
COMPONENT comp_regP1_IF_ID is
	PORT (
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
	
		clk        : in  STD_LOGIC;
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_instr  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		Q_PC   : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_I    : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_ext_sinal IS
	PORT (
		in0  :  IN STD_LOGIC_VECTOR(15 DOWNTO 0);		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_registradores IS
	PORT (
		clk: IN STD_LOGIC;
		
		escreveReg : IN STD_LOGIC;
		
		regLeitura1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		regLeitura2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		regEscrita  : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		dadosEscrita: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		dados1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		s1, s2, s3, s4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

-- Estagio 3: Execucao
COMPONENT comp_regP2_ID_EX is
	PORT (		
		clk1 : in  STD_LOGIC;
		
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados1 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados2 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_ext    : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEscRT : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		new_regEscRD : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		Q_PC  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D1  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D2  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_EXT : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEscRT : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		Q_regEscRD : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle -- entrada
		new_EX_RegDst  : in STD_LOGIC;
		new_EX_OpALU   : in STD_LOGIC_VECTOR(1 DOWNTO 0);
		new_EX_OrigALU : in STD_LOGIC;
		--MEM
		new_MEM_Branch     : in STD_LOGIC;
		new_MEM_LeMem      : in STD_LOGIC;
		new_MEM_EscreveMem : in STD_LOGIC;
		--WB
		new_WB_EscreveReg : in STD_LOGIC;
		new_WB_MemparaReg : in STD_LOGIC;
		
		--sinais de controle -- saida
		OUT_EX_RegDst  : out STD_LOGIC;
		OUT_EX_OpALU   : out STD_LOGIC_VECTOR(1 DOWNTO 0);
		OUT_EX_OrigALU : out STD_LOGIC;
		--MEM
		OUT_MEM_Branch     : out STD_LOGIC;
		OUT_MEM_LeMem      : out STD_LOGIC;
		OUT_MEM_EscreveMem : out STD_LOGIC;
		--WB
		OUT_WB_EscreveReg : out STD_LOGIC;
		OUT_WB_MemparaReg : out STD_LOGIC
	);
END COMPONENT;

COMPONENT comp_reg_funct is
	port (
		clk : in  std_logic;
		
		in0  : in  std_logic_vector(5 DOWNTO 0);
		out0 : out std_logic_vector(5 DOWNTO 0);
		f    : out std_logic_vector(5 DOWNTO 0)
	);
end COMPONENT;

COMPONENT comp_reg_dst is
	port (
		clk : in  std_logic;
		
		in0  : in  std_logic_vector(4 DOWNTO 0);
		out0 : out std_logic_vector(4 DOWNTO 0)
	);
end COMPONENT;

COMPONENT comp_controle IS
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
END COMPONENT;

COMPONENT comp_mux2_5bits IS
	PORT (
		in0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		in1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		op : IN STD_LOGIC;
		
		out0 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_mux2_32bits IS
	PORT (
		in0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		op : IN STD_LOGIC;
		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_ULA_Controle IS
	PORT (
		opALU : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		
		out0  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_desloc2esc IS
	PORT (
		in0  :  IN STD_LOGIC_VECTOR(31 DOWNTO 0);		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_somador32 is
	PORT (
		in1 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		in2 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		res : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_ULA IS
	PORT (
		OP : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	
		in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		res  : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
		zero : OUT STD_LOGIC := '0'
	);
END COMPONENT;

-- Estagio 4: Acesso a Memoria
COMPONENT comp_regP3_EX_MEM IS
	PORT (
		clk1 : in STD_LOGIC;
		
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		
		new_zero : in  STD_LOGIC;
		new_ula  : in  STD_LOGIC_VECTOR(63 DOWNTO 0);
		new_sum  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_D2   : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEsc : in STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		Q_zero : out STD_LOGIC;
		Q_ula  : out STD_LOGIC_VECTOR(63 DOWNTO 0);
		Q_sum  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D2   : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEsc : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle -- entrada
		--MEM
		new_MEM_Branch     : in STD_LOGIC;
		new_MEM_LeMem      : in STD_LOGIC;
		new_MEM_EscreveMem : in STD_LOGIC;
		--WB
		new_WB_EscreveReg : in STD_LOGIC;
		new_WB_MemparaReg : in STD_LOGIC;
		
		--sinais de controle -- saida
		--MEM
		OUT_MEM_Branch     : out STD_LOGIC;
		OUT_MEM_LeMem      : out STD_LOGIC;
		OUT_MEM_EscreveMem : out STD_LOGIC;
		--WB
		OUT_WB_EscreveReg : out STD_LOGIC;
		OUT_WB_MemparaReg : out STD_LOGIC
	);
END COMPONENT;

COMPONENT comp_AND_BRANCH IS
	PORT (
		in0  : in  STD_LOGIC;
		in1  : in  STD_LOGIC;
		out0 : out STD_LOGIC
	);
END COMPONENT;

--COMPONENT comp_mem_dados IS
--    generic (
--        DATA_WIDTH : integer := 32;
--        ADDR_WIDTH : integer := 32 -- 2 ^ ADDR_WIDTH addresses
--    );
--    port (
--        a_clock  : in std_logic;
--        a_wren   : in std_logic;
--        a_read   : in std_logic;
--        a_addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
--        a_data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
--        a_data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
--    );
--END COMPONENT;

COMPONENT comp_regP4_MEM_WB IS
	PORT (
		clk1 : in  STD_LOGIC;
		
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		
		new_ula          : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dado_leitura : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEsc       : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		Q_ula          : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_dado_leitura : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEsc       : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle -- entrada
		--WB
		new_WB_EscreveReg : in STD_LOGIC;
		new_WB_MemparaReg : in STD_LOGIC;
		
		--sinais de controle -- saida
		--WB
		OUT_WB_EscreveReg : out STD_LOGIC;
		OUT_WB_MemparaReg : out STD_LOGIC
	);
END COMPONENT;
	signal state_out : STD_LOGIC_VECTOR(3 DOWNTO 0);

	-- Estagio 1: Busca de Instruçao
	signal aux_PC_new : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal aux_PC_out : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	
	signal aux_MI_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_SumPC_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_allow_W_R1 : STD_LOGIC;
	signal aux_allow_R_R1 : STD_LOGIC;
	signal aux_allow_W_R2 : STD_LOGIC;
	signal aux_allow_R_R2 : STD_LOGIC;		
	signal aux_allow_W_R3 : STD_LOGIC;
	signal aux_allow_R_R3 : STD_LOGIC;		
	signal aux_allow_W_R4 : STD_LOGIC;
	signal aux_allow_R_R4 : STD_LOGIC;
		
	signal aux_allow_W_PC : STD_LOGIC;
	
	--sinais de controle saida
	--EX
--	signal aux_EX_RegDst  : STD_LOGIC;
--	signal aux_EX_OpALU   : STD_LOGIC_VECTOR(1 DOWNTO 0);
--	signal aux_EX_OrigALU : STD_LOGIC;
	--MEM
--	signal aux_MEM_Branch     : STD_LOGIC;
--	signal aux_MEM_LeMem      : STD_LOGIC;
--	signal aux_MEM_EscreveMem : STD_LOGIC;
	--WB
--	signal aux_WB_EscreveReg : STD_LOGIC; 
--	signal aux_WB_MemparaReg : STD_LOGIC;
	
	-- Estagio 2: Decodificacao da Instrucao
	signal aux_ctrl_EX_RegDst  : STD_LOGIC;
	signal aux_ctrl_EX_OpALU   : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal aux_ctrl_EX_OrigALU : STD_LOGIC;
	signal aux_ctrl_MEM_Branch     : STD_LOGIC;
	signal aux_ctrl_MEM_LeMem      : STD_LOGIC;
	signal aux_ctrl_MEM_EscreveMem : STD_LOGIC;
	signal aux_ctrl_WB_EscreveReg : STD_LOGIC;
	signal aux_ctrl_WB_MemparaReg : STD_LOGIC;
	
	signal aux_r1_PC   : STD_LOGIC_VECTOR(31 DOWNTO 0);	
	signal aux_r1_Inst : STD_LOGIC_VECTOR(31 DOWNTO 0);

	signal aux_reg_out1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_reg_out2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_extSin : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000"; --
	
	-- Estagio 3: Execucao
	signal aux_R2_EX_RegDst  : STD_LOGIC;
	signal aux_R2_EX_OpALU   : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal aux_R2_EX_OrigALU : STD_LOGIC;
	signal aux_R2_MEM_Branch     : STD_LOGIC;
	signal aux_R2_MEM_LeMem      : STD_LOGIC;
	signal aux_R2_MEM_EscreveMem : STD_LOGIC;
	signal aux_R2_WB_EscreveReg : STD_LOGIC;
	signal aux_R2_WB_MemparaReg : STD_LOGIC;
	
	signal aux_R2_PC  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal aux_R2_D1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal aux_R2_D2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal aux_R2_EXT : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal aux_R2_regEscRT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	signal aux_R2_regEscRD : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	
	signal aux_mux_ula_op2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_ctrlUla_out : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; --
	signal aux_shift2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_desvio : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_ula_zero : STD_LOGIC;
	signal aux_ula_out  : STD_LOGIC_VECTOR(63 DOWNTO 0) := "0000000000000000000000000000000000000000000000000000000000000000"; --
	
	signal aux_mux_regDest : STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	-- Estagio 4: Acesso a Memoria de Dados
	signal aux_R3_MEM_Branch     : STD_LOGIC;
	signal aux_R3_MEM_LeMem      : STD_LOGIC;
	signal aux_R3_MEM_EscreveMem : STD_LOGIC;
	signal aux_R3_WB_EscreveReg : STD_LOGIC;
	signal aux_R3_WB_MemparaReg : STD_LOGIC;
	
	signal aux_R3_zero : STD_LOGIC;
	signal aux_R3_ula  : STD_LOGIC_VECTOR(63 DOWNTO 0);
	signal aux_R3_sum  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R3_D2   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R3_regEsc : STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	signal aux_AND_BRANCH : STD_LOGIC := '0';
	signal aux_memDados_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	-- Estagio 5: Salvar Dados
	signal aux_R4_WB_EscreveReg : STD_LOGIC;
	signal aux_R4_WB_MemparaReg : STD_LOGIC;
	
	signal aux_R4_ula : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R4_dado_leitura : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R4_regEsc : STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	signal aux_mux_data_registrador : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--
	signal aux_funct : STD_LOGIC_VECTOR(5 DOWNTO 0);
	signal aux_dst : STD_LOGIC_VECTOR(4 DOWNTO 0);
	
BEGIN	
	-- Estagio 1: Busca de Instruçao
	com_mux_PC : comp_mux2_32bits		port map (aux_SumPC_out, aux_R3_sum, aux_AND_BRANCH, aux_PC_new);
	com_PC     : comp_PC             port map ('1', clk, aux_PC_new, aux_PC_out);
	pc_out 	<= aux_PC_out; --para teste
	
	--com_MI    : comp_mem_instrucoes port map (clk, '1', aux_PC_out, aux_MI_out);
	com_MI     : comp_mem_instrucoes port map (clk, aux_PC_out, aux_MI_out);
	inst_out <= aux_MI_out; --para teste
	
	com_SumPC  : comp_somadorPC      port map (aux_PC_out, aux_SumPC_out);
	com_FSM : comp_mips_controle port map (
		clk, aux_MI_out,
		
		aux_allow_W_R1, aux_allow_R_R1,
		aux_allow_W_R2, aux_allow_R_R2,
		aux_allow_W_R3, aux_allow_R_R3,
		aux_allow_W_R4, aux_allow_R_R4,
		aux_allow_W_PC, state
		
--		aux_EX_RegDst, aux_EX_OpALU, aux_EX_OrigALU,
--		aux_MEM_Branch, aux_MEM_LeMem, aux_MEM_EscreveMem,
--		aux_WB_EscreveReg, aux_WB_MemparaReg, state
	);
	
	-- Estagio 2: Decodificacao da Instrucao e Busca de Operandos
	com_R1 : comp_regP1_IF_ID port map ('1', '1', clk, aux_SumPC_out, aux_MI_out, aux_r1_PC, aux_r1_Inst);
	
	com_controle : comp_controle port map (
		aux_r1_Inst(31 DOWNTO 26),
		
		aux_ctrl_EX_RegDst, aux_ctrl_EX_OpALU, aux_ctrl_EX_OrigALU,
		aux_ctrl_MEM_Branch, aux_ctrl_MEM_LeMem, aux_ctrl_MEM_EscreveMem,
		aux_ctrl_WB_EscreveReg, aux_ctrl_WB_MemparaReg
	);
	
	--pc_out2 <= aux_r1_PC; --para teste
	--inst_out2 <= aux_r1_Inst; --para teste
	
	com_extSin : comp_ext_sinal port map (aux_r1_Inst(15 DOWNTO 0), aux_extSin);

	com_reg : comp_registradores port map (
		clk,
		aux_R4_WB_EscreveReg,--'0',
		aux_r1_Inst(25 DOWNTO 21), aux_r1_Inst(20 DOWNTO 16), aux_R4_regEsc,
		aux_mux_data_registrador, aux_reg_out1, aux_reg_out2, r24, r18, r02, r14
	); --ver o sinal de escrita
	
	dados1 <= aux_reg_out1; --para teste
	dados2 <= aux_reg_out2; --para teste
	
	-- Estagio 3: Execucao
	com_R2 : comp_regP2_ID_EX port map (
		clk,
		'1', '1',
		
		aux_r1_PC, aux_reg_out1, aux_reg_out2,
		aux_extSin, aux_r1_Inst(20 DOWNTO 16), aux_r1_Inst(15 DOWNTO 11),
		
		aux_R2_PC, aux_R2_D1, aux_R2_D2, aux_R2_EXT,
		aux_R2_regEscRT, aux_R2_regEscRD,
		
		aux_ctrl_EX_RegDst, aux_ctrl_EX_OpALU, aux_ctrl_EX_OrigALU,
		aux_ctrl_MEM_Branch, aux_ctrl_MEM_LeMem, aux_ctrl_MEM_EscreveMem,
		aux_ctrl_WB_EscreveReg, aux_ctrl_WB_MemparaReg,
		
		aux_R2_EX_RegDst, aux_R2_EX_OpALU, aux_R2_EX_OrigALU,
		aux_R2_MEM_Branch, aux_R2_MEM_LeMem, aux_R2_MEM_EscreveMem,
		aux_R2_WB_EscreveReg, aux_R2_WB_MemparaReg
	);
	
	dados11 <= aux_R2_D1; --para teste
	dados22 <= aux_R2_D2; --para teste
	opUla <= aux_R2_EX_OpALU; --para teste

	com_funct : comp_reg_funct port map (clk, aux_R2_EXT(5 DOWNTO 0), aux_funct, funcc);
	
	--funcc <= aux_R2_EXT(5 DOWNTO 0); --para teste func_actual;

	com_mux_op2_ula : comp_mux2_32bits port map (aux_R2_D2, aux_R2_EXT, aux_R2_EX_OrigALU, aux_mux_ula_op2);
	com_ula_ctrl : comp_ULA_Controle port map (aux_R2_EX_OpALU, aux_funct, aux_ctrlUla_out);
	com_ula : comp_ULA port map (aux_ctrlUla_out, aux_R2_D1, aux_mux_ula_op2, aux_ula_out, aux_ula_zero);

	com_mux_regDest : comp_mux2_5bits port map (aux_R2_regEscRT, aux_R2_regEscRD, aux_R2_EX_RegDst, aux_dst);

	com_dst : comp_reg_dst port map (clk, aux_dst, aux_mux_regDest);
	
	ulaCtrl <= aux_ctrlUla_out; --para teste
	ulaRes <= aux_ula_out(31 downto 0); --para teste
	
--	com_shift2 : comp_desloc2esc port map (aux_R2_EXT, aux_shift2);
--	com_soma_desvio : comp_somador32 port map(aux_R2_PC, aux_shift2, aux_desvio);
	
	-- Estagio 4: Acesso a Memoria de Dados
	com_R3 : comp_regP3_EX_MEM port map (
		clk,
		'1', '1', 
		aux_ula_zero, aux_ula_out,
		aux_desvio, aux_R2_D2, aux_mux_regDest,
		aux_R3_zero, aux_R3_ula, aux_R3_sum, aux_R3_D2, aux_R3_regEsc,
		
		aux_R2_MEM_Branch, aux_R2_MEM_LeMem, aux_R2_MEM_EscreveMem,
		aux_R2_WB_EscreveReg, aux_R2_WB_MemparaReg,
		
		aux_R3_MEM_Branch, aux_R3_MEM_LeMem, aux_R3_MEM_EscreveMem,
		aux_R3_WB_EscreveReg, aux_R3_WB_MemparaReg
	);
	
	--ulaResR3 <= aux_R3_ula;

	comp_AND : comp_AND_BRANCH port map (aux_R3_zero, aux_R3_MEM_Branch, aux_AND_BRANCH);

--	com_mem_dados : comp_mem_dados port map (
--		clk,
--		aux_R3_EscreveMem, aux_MEM_LeMem,
--		aux_R3_ula(31 DOWNTO 0), aux_R3_D2, aux_memDados_out
--	);
	
	-- Estagio 5: Salvar Dados
	com_R4 : comp_regP4_MEM_WB port map (
		clk,
		'1', '1', 
		aux_R3_ula(31 DOWNTO 0), aux_memDados_out, aux_R3_regEsc,
		aux_R4_ula, aux_R4_dado_leitura, aux_R4_regEsc,
		
		aux_R3_WB_EscreveReg, aux_R3_WB_MemparaReg,
		
		aux_R4_WB_EscreveReg, aux_R4_WB_MemparaReg
	);
	com_mux_R4 : comp_mux2_32bits port map (aux_R4_ula, aux_R4_dado_leitura, aux_R4_WB_MemparaReg, aux_mux_data_registrador);
	writ_reg <= aux_R4_WB_EscreveReg; --para teste
END behavior;