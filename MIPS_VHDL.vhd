LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mips_vhdl IS
	PORT (
		clk : IN STD_LOGIC;
		c : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END mips_vhdl;

ARCHITECTURE behavior OF mips_vhdl IS

-- Estagio 1: Busca da Instrucao
COMPONENT comp_PC IS
	PORT (
		clk    : in  STD_LOGIC;
		new_PC : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q      : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comp_mem_instrucoes IS
    GENERIC (
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 32 -- 2 ^ ADDR_WIDTH addresses
    );
    PORT (
        a_clock  : in std_logic;
        --a_wren   : in std_logic;
        a_read   : in std_logic;
        a_addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        --a_data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        a_data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
END COMPONENT;

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
		dados2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

-- Estagio 3: Execucao
COMPONENT comp_regP2_ID_EX is
	PORT (
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		
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

-- Estagio 3: Acesso a Memoria
COMPONENT comp_regP3_EX_MEM IS
	PORT (
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		
		new_zero : in  STD_LOGIC;
		new_ula  : in  STD_LOGIC_VECTOR(63 DOWNTO 0);
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
		Q_ula  : out STD_LOGIC_VECTOR(63 DOWNTO 0);
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
END COMPONENT;

COMPONENT comp_AND_BRANCH IS
	PORT (
		in0  : in  STD_LOGIC;
		in1  : in  STD_LOGIC;
		out0 : out STD_LOGIC
	);
END COMPONENT;

COMPONENT comp_mem_dados IS
    generic (
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 32 -- 2 ^ ADDR_WIDTH addresses
    );
    port (
        a_clock  : in std_logic;
        a_wren   : in std_logic;
        a_read   : in std_logic;
        a_addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        a_data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        a_data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
END COMPONENT;

	-- Estagio 1: Busca de Instruçao
	signal aux_PC_new : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal aux_PC_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_MI_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_SumPC_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	-- Estagio 2: Decodificacao da Instrucao
	signal aux_r1_PC   : STD_LOGIC_VECTOR(31 DOWNTO 0);	
	signal aux_r1_Inst : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_CTRL_EX_RegDst  : STD_LOGIC;
	signal aux_CTRL_EX_OpALU   : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal aux_CTRL_EX_OrigALU : STD_LOGIC;
	signal aux_CTRL_MEM_Branch     : STD_LOGIC;
	signal aux_CTRL_MEM_LeMem      : STD_LOGIC;
	signal aux_CTRL_MEM_EscreveMem : STD_LOGIC;
	signal aux_CTRL_WB_EscreveReg : STD_LOGIC;
	signal aux_CTRL_WB_MemparaReg : STD_LOGIC;

	signal aux_reg_out1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_reg_out2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_extSin : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	-- Estagio 3: Execucao
	signal aux_R2_EX_RegDst  : STD_LOGIC;
	signal aux_R2_EX_OpALU   : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal aux_R2_EX_OrigALU : STD_LOGIC;
	signal aux_R2_MEM_Branch     : STD_LOGIC;
	signal aux_R2_MEM_LeMem      : STD_LOGIC;
	signal aux_R2_MEM_EscreveMem : STD_LOGIC;
	signal aux_R2_WB_EscreveReg : STD_LOGIC;
	signal aux_R2_WB_MemparaReg : STD_LOGIC;
	
	signal aux_R2_PC  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R2_D1  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R2_D2  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R2_EXT : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R2_regEscRT : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal aux_R2_regEscRD : STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	signal aux_mux_ula_op2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_ctrlUla_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal aux_shift2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_desvio : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal aux_ula_zero : STD_LOGIC;
	signal aux_ula_out  : STD_LOGIC_VECTOR(63 DOWNTO 0);
	
	signal aux_mux_regDest : STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	-- Estagio 4: Acesso a Memoria de Dados
	signal aux_R3_zero : STD_LOGIC;
	signal aux_R3_ula  : STD_LOGIC_VECTOR(63 DOWNTO 0);
	signal aux_R3_sum  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R3_D2   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_R3_regEsc : STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	--MEM
	signal aux_R3_Branch     : STD_LOGIC;
	signal aux_R3_LeMem      : STD_LOGIC;
	signal aux_R3_EscreveMem : STD_LOGIC;
	--WB
	signal aux_R3_EscreveReg : STD_LOGIC;
	signal aux_R3_MemparaReg : STD_LOGIC;
	
	signal aux_AND_BRANCH : STD_LOGIC;
	signal aux_memDados_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	-- Estagio 5: Salvar Dados
	signal aux_r4_data : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal aux_r4_addr : STD_LOGIC_VECTOR(4 DOWNTO 0);
	
BEGIN
	-- Estagio 1: Busca de Instruçao
	com_PC    : comp_PC             port map (clk, aux_PC_new, aux_PC_out);
	com_MI    : comp_mem_instrucoes port map (clk, '1', aux_PC_out, aux_MI_out);
	com_SumPC : comp_somadorPC      port map (aux_PC_out, aux_SumPC_out);
	
	-- Estagio 2: Decodificacao da Instrucao
	com_R1 : comp_regP1_IF_ID    port map ('1', '1', clk, aux_PC_out, aux_MI_out, aux_r1_PC, aux_r1_Inst);
	com_controle : comp_controle port map (
		aux_r1_Inst(31 DOWNTO 26), 
		aux_CTRL_EX_RegDst, aux_CTRL_EX_OpALU, aux_CTRL_EX_OrigALU,
		aux_CTRL_MEM_Branch, aux_CTRL_MEM_LeMem, aux_CTRL_MEM_EscreveMem,
		aux_CTRL_WB_EscreveReg, aux_CTRL_WB_MemparaReg
	);
	com_extSin : comp_ext_sinal port map (aux_r1_Inst(15 DOWNTO 0), aux_extSin);
	
	com_reg : comp_registradores port map (
		clk, '0', aux_r1_Inst(25 DOWNTO 21),
		aux_r1_Inst(20 DOWNTO 16), aux_r4_addr, aux_r4_data,
		aux_reg_out1, aux_reg_out2
	); --ver o sinal de escrita
	
	-- Estagio 3: Execucao
	com_R2 : comp_regP2_ID_EX port map (
		'1', '1', clk, aux_r1_PC, aux_reg_out1, aux_reg_out2,
		aux_extSin, aux_r1_Inst(20 DOWNTO 16), aux_r1_Inst(15 DOWNTO 11),		
		aux_CTRL_EX_RegDst, aux_CTRL_EX_OpALU, aux_CTRL_EX_OrigALU,
		aux_CTRL_MEM_Branch, aux_CTRL_MEM_LeMem, aux_CTRL_MEM_EscreveMem,
		aux_CTRL_WB_EscreveReg, aux_CTRL_WB_MemparaReg,
		
		aux_R2_PC, aux_R2_D1, aux_R2_D2, aux_R2_EXT,
		aux_R2_regEscRT, aux_R2_regEscRD,
		
		aux_R2_EX_RegDst, aux_R2_EX_OpALU, aux_R2_EX_OrigALU,
		aux_R2_MEM_Branch, aux_R2_MEM_LeMem, aux_R2_MEM_EscreveMem,
		aux_R2_WB_EscreveReg, aux_R2_WB_MemparaReg
	);
	
	com_mux_op2_ula : comp_mux2_32bits port map (aux_R2_D2, aux_R2_EXT, aux_R2_EX_OrigALU, aux_mux_ula_op2);
	com_ula_ctrl : comp_ULA_Controle port map (aux_R2_EX_OpALU, aux_R2_EXT(5 DOWNTO 0), aux_ctrlUla_out);
	com_ula : comp_ULA port map (aux_ctrlUla_out, aux_R2_D1, aux_mux_ula_op2, aux_ula_out, aux_ula_zero);
	
	com_mux_regDest : comp_mux2_5bits port map (aux_R2_regEscRT, aux_R2_regEscRD, aux_R2_EX_RegDst, aux_mux_regDest);

	com_shift2 : comp_desloc2esc port map (aux_R2_EXT, aux_shift2);
	com_soma_desvio : comp_somador32 port map(aux_R2_PC, aux_shift2, aux_desvio);
	
	-- Estagio 4: Acesso a Memoria de Dados
	com_R3 : comp_regP3_EX_MEM port map (
		'0', '0', clk, aux_ula_zero, aux_ula_out,
		aux_desvio, aux_R2_D2, aux_mux_regDest,
		aux_R2_MEM_Branch, aux_R2_MEM_LeMem, aux_R2_MEM_EscreveMem,
		aux_R2_WB_EscreveReg, aux_R2_WB_MemparaReg,
		aux_R3_zero, aux_R3_ula, aux_R3_sum, aux_R3_D2, aux_R3_regEsc,
		aux_R3_Branch, aux_R3_LeMem, aux_R3_EscreveMem,
		aux_R3_EscreveReg, aux_R3_MemparaReg
	);

	comp_AND : comp_AND_BRANCH port map (aux_R3_zero, aux_R3_Branch, aux_AND_BRANCH);
	
	com_mem_dados : comp_mem_dados port map (
		clk,
		aux_R3_EscreveMem, aux_R3_LeMem,
		aux_R3_ula(31 DOWNTO 0), aux_R3_D2, aux_memDados_out
	);
	
	-- Estagio 5: Salvar Dados
END behavior;