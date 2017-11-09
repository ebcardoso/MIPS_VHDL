LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mips_vhdl IS
	PORT (
		clk : IN STD_LOGIC;
		
		oC1_pc_out : out STD_LOGIC_VECTOR(31 downto 0);
		oC1_inst_out : out STD_LOGIC_VECTOR(31 downto 0);
		oC1_r1 : out STD_LOGIC_VECTOR(31 downto 0);
		oC1_r2 : out STD_LOGIC_VECTOR(31 downto 0);
		oC1_r18 : out STD_LOGIC_VECTOR(31 downto 0);
		oC1_r24 : out STD_LOGIC_VECTOR(31 downto 0);
		oC1_WriteMEM : out STD_LOGIC;
		oC1_DataAddr : out STD_LOGIC_VECTOR(7 downto 0);
		oC1_MemDataIN  : out STD_LOGIC_VECTOR(31 downto 0);

		oC2_pc_out : out STD_LOGIC_VECTOR(31 downto 0);
		oC2_inst_out : out STD_LOGIC_VECTOR(31 downto 0);
		oC2_r1 : out STD_LOGIC_VECTOR(31 downto 0);
		oC2_r2 : out STD_LOGIC_VECTOR(31 downto 0);
		oC2_r18 : out STD_LOGIC_VECTOR(31 downto 0);
		oC2_r24 : out STD_LOGIC_VECTOR(31 downto 0);
		oC2_ReadMEM : out STD_LOGIC;
		oC2_DataAddr : out STD_LOGIC_VECTOR(7 downto 0);
		oC2_MemDataOUT  : out STD_LOGIC_VECTOR(31 downto 0)
	);
END mips_vhdl;

ARCHITECTURE behavior OF mips_vhdl IS

component CORE IS
	PORT (
		clk : IN STD_LOGIC;
--		inst_out  : OUT STD_LOGIC_VECTOR(31 downto 0);
		pc_out    : OUT STD_LOGIC_VECTOR(31 downto 0);
		dados11   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados22   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		ulaRes    : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		writ_reg : OUT STD_LOGIC;
		r1  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		r2  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		r18 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		r24 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		R3_DataMem        : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		R3_MEM_LeMem      : OUT STD_LOGIC;
		R3_MEM_EscreveMem : OUT STD_LOGIC;
		R3_MEM_ULA        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		R3_MEM_D2         : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		aux_MI_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END component;

component comp_mem_instrucoes1 IS
	PORT (
		clk: IN STD_LOGIC;
		
		regLeitura1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END component;

component comp_mem_instrucoes2 IS
	PORT (
		clk: IN STD_LOGIC;
		
		regLeitura1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END component;

COMPONENT comp_mem_dados IS
    generic (
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 8 -- 2 ^ ADDR_WIDTH addresses
    );
    port (
        a_clock  : in std_logic;
        a_wren   : in std_logic;
        a_read   : in std_logic;
        a_addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        a_data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        a_data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0);

        b_clock  : in std_logic;
        b_wren   : in std_logic;
        b_read   : in std_logic;
        b_addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        b_data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        b_data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
END COMPONENT;	

	--core1
	signal C1_pc_out : STD_LOGIC_VECTOR(31 downto 0);
	signal C1_inst : STD_LOGIC_VECTOR(31 downto 0);
	signal C1_ULA1 : STD_LOGIC_VECTOR(31 downto 0);
	signal C1_ULA2 : STD_LOGIC_VECTOR(31 downto 0);
	signal C1_ulaRes : STD_LOGIC_VECTOR(31 downto 0);
	signal C1_wr : STD_LOGIC;
	
	signal C1_R3_MEM_LeMem      : STD_LOGIC := '0';
	signal C1_R3_MEM_EscreveMem : STD_LOGIC := '0';
	signal C1_R3_MEM_ULA        : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal C1_R3_MEM_D2         : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal C1_R3_DadosOut       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--core2
	signal C2_pc_out : STD_LOGIC_VECTOR(31 downto 0);
	signal C2_inst : STD_LOGIC_VECTOR(31 downto 0);
	signal C2_ULA1 : STD_LOGIC_VECTOR(31 downto 0);
	signal C2_ULA2 : STD_LOGIC_VECTOR(31 downto 0);
	signal C2_ulaRes : STD_LOGIC_VECTOR(31 downto 0);
	signal C2_wr : STD_LOGIC;
	
	signal C2_R3_MEM_LeMem      : STD_LOGIC := '0';
	signal C2_R3_MEM_EscreveMem : STD_LOGIC := '0';
	signal C2_R3_MEM_ULA        : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal C2_R3_MEM_D2         : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal C2_R3_DadosOut       : STD_LOGIC_VECTOR(31 DOWNTO 0);
		
begin
	core1 : CORE port map (
		clk,
		C1_pc_out, C1_ULA1, C1_ULA2, C1_ulaRes, C1_wr, oC1_r1, oC1_r2, oC1_r18, oC1_r24,
		C1_R3_DadosOut,
		C1_R3_MEM_LeMem, C1_R3_MEM_EscreveMem, C1_R3_MEM_ULA, C1_R3_MEM_D2,
		C1_inst
	);--
		
	core2 : CORE port map (
		clk, 
		C2_pc_out, C2_ULA1, C2_ULA2, C2_ulaRes, C2_wr, oC2_r1, oC2_r2, oC2_r18, oC2_r24,
		C2_R3_DadosOut,
		C2_R3_MEM_LeMem, C2_R3_MEM_EscreveMem, C2_R3_MEM_ULA, C2_R3_MEM_D2,
		C2_inst
	);
	
	com_MI1 : comp_mem_instrucoes1 port map (clk, C1_pc_out, C1_inst);
	com_MI2 : comp_mem_instrucoes2 port map (clk, C2_pc_out, C2_inst);
	
	oC1_inst_out <= C1_inst;
	oC2_inst_out <= C2_inst;
	
	oC1_WriteMEM <= C1_R3_MEM_EscreveMem;
	oC2_ReadMEM  <= C2_R3_MEM_LeMem;

	com_mem_dados : comp_mem_dados port map (
		clk,
		C1_R3_MEM_EscreveMem, C1_R3_MEM_LeMem,
		C1_R3_MEM_ULA, C1_R3_MEM_D2, C1_R3_DadosOut,

		clk,
		C2_R3_MEM_EscreveMem, C2_R3_MEM_LeMem,
		C2_R3_MEM_ULA, C2_R3_MEM_D2, C2_R3_DadosOut
	);

	oC1_DataAddr <= C1_R3_MEM_ULA;
	oC2_DataAddr <= C2_R3_MEM_ULA;
	
	oC1_MemDataIN  <= C1_R3_MEM_D2;
	oC2_MemDataOUT <= C2_R3_DadosOut;
end behavior;