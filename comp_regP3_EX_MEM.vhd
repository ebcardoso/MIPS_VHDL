library ieee;
use ieee.std_logic_1164.all;

entity comp_regP3_EX_MEM is
	port (
		clk1, clk2, clk3, clk4, clk5 : in STD_LOGIC;
		
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
		Q_regEsc : out STD_LOGIC_VECTOR(4 DOWNTO 0)--;
		
		--sinais de controle entrada		
		--MEM
--		new_Branch     : in STD_LOGIC;
--		new_LeMem      : in STD_LOGIC;
--		new_EscreveMem : in STD_LOGIC;
--		
--		--WB
--		new_EscreveReg : in STD_LOGIC;
--		new_MemparaReg : in STD_LOGIC;
		--
		
		--sinais de controle saida		
		--MEM
--		Q_Branch     : out STD_LOGIC;
--		Q_LeMem      : out STD_LOGIC;
--		Q_EscreveMem : out STD_LOGIC;
		
		--WB
--		Q_EscreveReg : out STD_LOGIC;
--		Q_MemparaReg : out STD_LOGIC
		--
	);
end comp_regP3_EX_MEM;

architecture arc of comp_regP3_EX_MEM is
	signal reg_zero : STD_LOGIC := '0';
	signal reg_ula  : STD_LOGIC_VECTOR(63 DOWNTO 0) := "0000000000000000000000000000000000000000000000000000000000000000";
	signal reg_sum  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D2   : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_regEsc : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
begin	
	process (clk1)
	begin
		if (clk1 = '1' and clk1'event) then
			if (allow_read = '1') then
				Q_zero <= reg_zero;
			end if;
			
			if (allow_write = '1') then
				reg_zero <= new_zero;
			end if;
		end if;
	end process;
	
	process (clk2)
	begin
		if (clk2 = '1' and clk2'event) then
			if (allow_read = '1') then
				Q_ula <= reg_ula;
			end if;
			
			if (allow_write = '1') then
				reg_ula <= new_ula;
			end if;
		end if;
	end process;
	
	process (clk3)
	begin
		if (clk3 = '1' and clk3'event) then
			if (allow_read = '1') then
				Q_sum <= reg_sum;
			end if;
			
			if (allow_write = '1') then
				reg_sum <= new_sum;
			end if;
		end if;
	end process;
	
	process (clk4)
	begin
		if (clk4 = '1' and clk4'event) then
			if (allow_read = '1') then
				Q_D2 <= reg_D2;
			end if;
			
			if (allow_write = '1') then
				reg_D2 <= new_D2;
			end if;
		end if;
	end process;
	
	process (clk5)
	begin
		if (clk5 = '1' and clk5'event) then
			if (allow_read = '1') then
				Q_regEsc <= reg_regEsc;
			end if;
			
			if (allow_write = '1') then
				reg_regEsc <= new_regEsc;
			end if;
		end if;
	end process;

--	process (clk)
--	begin
--		if (clk = '1' and clk'event) then
--			if (allow_read = '1') then
--				Q_zero <= reg_zero;
--				Q_ula  <= reg_ula;
--				Q_sum  <= reg_sum;
--				Q_D2   <= reg_D2;
--				Q_regEsc <= reg_regEsc;
				
--				--MEM
--				Q_Branch     <= reg_Branch;
--				Q_LeMem      <= reg_LeMem;
--				Q_EscreveMem <= reg_EscreveMem;
--				--WB
--				Q_EscreveReg <= reg_EscreveReg;
----				Q_MemparaReg <= reg_MemparaReg;
--			end if;
--			
--			if (allow_write = '1') then
--				reg_zero <= new_zero;
--				reg_ula  <= new_ula;
--				reg_sum  <= new_sum;
--				reg_D2   <= new_D2;
--				reg_regEsc <= new_regEsc;
				
--				--MEM
--				reg_Branch     <= new_Branch;
--				reg_LeMem      <= new_LeMem;
--				reg_EscreveMem <= new_EscreveMem;	
--				--WB
--				reg_EscreveReg <= new_EscreveReg;
--				reg_MemparaReg <= new_MemparaReg;	
--			end if;
--		end if;
--	end process;
end arc;
