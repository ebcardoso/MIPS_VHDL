library ieee;
use ieee.std_logic_1164.all;

entity comp_regP3_EX_MEM is
	port (
		clk1 : in STD_LOGIC;
		
		allow_read  : in STD_LOGIC;
		allow_write : in STD_LOGIC;
		
		new_zero   : in STD_LOGIC;
		new_ula    : in STD_LOGIC_VECTOR(63 DOWNTO 0);
		new_sum    : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_Jump    : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_D2     : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEsc : in STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		Q_zero   : out STD_LOGIC;
		Q_ula    : out STD_LOGIC_VECTOR(63 DOWNTO 0);
		Q_sum    : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_Jump    : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D2     : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEsc : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle -- entrada
		--MEM
		new_MEM_Branch     : in STD_LOGIC;
		new_MEM_Jump       : in STD_LOGIC;
		new_MEM_LeMem      : in STD_LOGIC;
		new_MEM_EscreveMem : in STD_LOGIC;
		--WB
		new_WB_EscreveReg : in STD_LOGIC;
		new_WB_MemparaReg : in STD_LOGIC;
		
		--sinais de controle -- saida
		--MEM
		OUT_MEM_Branch     : out STD_LOGIC;
		OUT_MEM_Jump       : out STD_LOGIC;
		OUT_MEM_LeMem      : out STD_LOGIC;
		OUT_MEM_EscreveMem : out STD_LOGIC;
		--WB
		OUT_WB_EscreveReg : out STD_LOGIC;
		OUT_WB_MemparaReg : out STD_LOGIC
	);
end comp_regP3_EX_MEM;

architecture arc of comp_regP3_EX_MEM is
	signal reg_zero   : STD_LOGIC := '0';
	signal reg_ulah   : STD_LOGIC_VECTOR(63 DOWNTO 0) := "0000000000000000000000000000000000000000000000000000000000000000";
	signal reg_sum    : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_Jump   : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D2     : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_regEsc : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	
	--registradores dos sinais de controle
	--MEM
	signal reg_MEM_Branch     : STD_LOGIC := '0';
	signal reg_MEM_Jump       : STD_LOGIC := '0';
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
				reg_zero <= new_zero;
				reg_ulah <= new_ula;
				reg_sum <= new_sum;
				reg_Jump <= new_Jump;
				reg_D2 <= new_D2;
				reg_regEsc <= new_regEsc;
				
				--MEM
				reg_MEM_Branch     <= new_MEM_Branch;
				reg_MEM_Jump       <= new_MEM_Jump;
				reg_MEM_LeMem      <= new_MEM_LeMem;
				reg_MEM_EscreveMem <= new_MEM_EscreveMem;
				--WB
				reg_WB_EscreveReg <= new_WB_EscreveReg;
				reg_WB_MemparaReg <= new_WB_MemparaReg;	
			end if;
		end if;
		
		if (clk1 = '0' and clk1'event) then
			if (allow_read = '1') then
				Q_zero <= reg_zero;
				Q_ula <= reg_ulah;
				Q_sum <= reg_sum;
				Q_Jump <= reg_Jump;
				Q_D2 <= reg_D2;
				Q_regEsc <= reg_regEsc;
				
				--MEM
				OUT_MEM_Branch     <= reg_MEM_Branch;
				OUT_MEM_Jump       <= reg_MEM_Jump;
				OUT_MEM_LeMem      <= reg_MEM_LeMem;
				OUT_MEM_EscreveMem <= reg_MEM_EscreveMem;
				--WB
				OUT_WB_EscreveReg <= reg_WB_EscreveReg;
				OUT_WB_MemparaReg <= reg_WB_MemparaReg;
			end if;
		end if;
	end process;
end arc;
