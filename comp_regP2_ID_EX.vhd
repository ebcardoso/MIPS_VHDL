library ieee;
use ieee.std_logic_1164.all;

entity comp_regP2_ID_EX is
	port (		
		clk1 : in  STD_LOGIC;
		
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		
		new_PC     : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados1 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados2 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_ext    : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEscRT : in STD_LOGIC_VECTOR(4 DOWNTO 0);
		new_regEscRD : in STD_LOGIC_VECTOR(4 DOWNTO 0);
		
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
end comp_regP2_ID_EX;

architecture arc of comp_regP2_ID_EX is
	signal reg_PC  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_ext : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_regEscRT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	signal reg_regEscRD : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";

	--registradores dos sinais de controle
	--EX
	signal reg_EX_RegDst  : STD_LOGIC := '0';
	signal reg_EX_OpALU   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	signal reg_EX_OrigALU : STD_LOGIC := '0';
	--MEM
	signal reg_MEM_Branch     : STD_LOGIC := '0';
	signal reg_MEM_LeMem      : STD_LOGIC := '0';
	signal reg_MEM_EscreveMem : STD_LOGIC := '0';
	--WB
	signal reg_WB_EscreveReg : STD_LOGIC := '0';
	signal reg_WB_MemparaReg : STD_LOGIC := '0';
begin
	process (clk1)
	begin
		if (clk1 = '1' and clk1'event) then		
			if (allow_write = '1') then
				reg_PC  <= new_PC;
				reg_D1  <= new_dados1;
				reg_D2  <= new_dados2;
				reg_ext <= new_ext;
				reg_regEscRT <= new_regEscRT;
				reg_regEscRD <= new_regEscRD;
				
				--EX
				reg_EX_RegDst  <= new_EX_RegDst;
				reg_EX_OpALU   <= new_EX_OpALU;
				reg_EX_OrigALU <= new_EX_OrigALU;
				--MEM
				reg_MEM_Branch     <= new_MEM_Branch;
				reg_MEM_LeMem      <= new_MEM_LeMem;
				reg_MEM_EscreveMem <= new_MEM_EscreveMem;
				--WB
				reg_WB_EscreveReg <= new_WB_EscreveReg;
				reg_WB_MemparaReg <= new_WB_MemparaReg;	
			end if;
		end if;
	
		if (clk1 = '0' and clk1'event) then
			if (allow_read = '1') then
				Q_PC  <= reg_PC;
				Q_D1  <= reg_D1;
				Q_D2  <= reg_D2;
				Q_EXT <= reg_ext;
				Q_regEscRT <= reg_regEscRT;
				Q_regEscRD <= reg_regEscRD;
				
				--EX
				OUT_EX_RegDst  <= reg_EX_RegDst;
				OUT_EX_OpALU   <= reg_EX_OpALU;
				OUT_EX_OrigALU <= reg_EX_OrigALU;
				--MEM
				OUT_MEM_Branch     <= reg_MEM_Branch;
				OUT_MEM_LeMem      <= reg_MEM_LeMem;
				OUT_MEM_EscreveMem <= reg_MEM_EscreveMem;
				--WB
				OUT_WB_EscreveReg <= reg_WB_EscreveReg;
				OUT_WB_MemparaReg <= reg_WB_MemparaReg;
			end if;
		end if;
	end process;
end arc;