library ieee;
use ieee.std_logic_1164.all;

entity comp_regP2_ID_EX is
	port (
		clk        : in  STD_LOGIC;
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados1 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados2 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_ext    : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		Q_PC  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D1  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D2  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_EXT : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end comp_regP2_ID_EX;

architecture arc of comp_regP2_ID_EX is
	signal reg_PC  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_ext : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
begin
	process (clk,
				reg_PC, reg_D1, reg_D2, reg_ext,
				new_PC, new_dados1, new_dados2, new_ext)
	begin
		if (clk = '1' and clk'event) then
			Q_PC  <= reg_PC;
			Q_D1  <= reg_D1;
			Q_D2  <= reg_D2;
			Q_EXT <= reg_ext;
			
			reg_PC  <= new_PC;
			reg_D1  <= new_dados1;
			reg_D2  <= new_dados2;
			reg_ext <= new_ext;
		end if;
	end process;
end arc;