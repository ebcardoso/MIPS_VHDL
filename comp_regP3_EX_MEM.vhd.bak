library ieee;
use ieee.std_logic_1164.all;

entity comp_regP3_EX_MEM is
	port (
		clk : in  STD_LOGIC;
		
		new_zero : in  STD_LOGIC;
		new_ula  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_sum  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_D2   : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		Q_zero : out STD_LOGIC;
		Q_ula  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_sum  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D2   : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end comp_regP3_EX_MEM;

architecture arc of comp_regP3_EX_MEM is
	signal reg_zero : STD_LOGIC := '0';
	signal reg_ula  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_sum  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D2   : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
begin
	process (clk,
				reg_zero, reg_ula, reg_sum, reg_D2,
				new_zero, new_ula, new_sum, new_D2)
	begin
		if (clk = '1' and clk'event) then
			Q_zero <= reg_zero;
			Q_ula  <= reg_ula;
			Q_sum  <= reg_sum;
			Q_D2   <= reg_D2;
			
			reg_zero <= new_zero;
			reg_ula  <= new_ula;
			reg_sum  <= new_sum;
			reg_D2   <= new_D2;
		end if;
	end process;
end arc;