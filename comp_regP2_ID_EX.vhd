library ieee;
use ieee.std_logic_1164.all;

entity comp_regP2_ID_EX is
	port (
		clk        : in  STD_LOGIC;
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados1 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados2 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_ext    : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
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
end comp_regP2_ID_EX;

architecture arc of comp_regP2_ID_EX is
	signal reg_PC  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_ext : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";

	--registradores dos sinais de controle
	--EX
	signal reg_RegDst  : STD_LOGIC := '0';
	signal reg_OpALU   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	signal reg_OrigALU : STD_LOGIC := '0';
	--MEM
	signal reg_Branch     : STD_LOGIC := '0';
	signal reg_LeMem      : STD_LOGIC := '0';
	signal reg_EscreveMem : STD_LOGIC := '0';
	--WB
	signal reg_EscreveReg : STD_LOGIC := '0';
	signal reg_MemparaReg : STD_LOGIC := '0';
begin
	process (clk,
				reg_PC, reg_D1, reg_D2, reg_ext,
				new_PC, new_dados1, new_dados2, new_ext,
				new_RegDst, new_OpALU, new_OrigALU, new_Branch, new_LeMem,
				new_EscreveMem, new_EscreveReg, new_MemparaReg,
				reg_RegDst, reg_OpALU, reg_OrigALU, reg_Branch, reg_LeMem,
				reg_EscreveMem, reg_EscreveReg, reg_MemparaReg)
	begin
		if (clk = '1' and clk'event) then
			Q_PC  <= reg_PC;
			Q_D1  <= reg_D1;
			Q_D2  <= reg_D2;
			Q_EXT <= reg_ext;
			
			--EX
			Q_RegDst  <= reg_RegDst;
			Q_OpALU   <= reg_OpALU;
			Q_OrigALU <= reg_OrigALU;
			--MEM
			Q_Branch     <= reg_Branch;
			Q_LeMem      <= reg_LeMem;
			Q_EscreveMem <= reg_EscreveMem;
			--WB
			Q_EscreveReg <= reg_EscreveReg;
			Q_MemparaReg <= reg_MemparaReg;
			
			reg_PC  <= new_PC;
			reg_D1  <= new_dados1;
			reg_D2  <= new_dados2;
			reg_ext <= new_ext;
			
			--EX
			reg_RegDst  <= new_RegDst;
			reg_OpALU   <= new_OpALU;
			reg_OrigALU <= new_OrigALU;
			--MEM
			reg_Branch     <= new_Branch;
			reg_LeMem      <= new_LeMem;
			reg_EscreveMem <= new_EscreveMem;
			--WB
			reg_EscreveReg <= new_EscreveReg;
			reg_MemparaReg <= new_MemparaReg;			
		end if;
	end process;
end arc;