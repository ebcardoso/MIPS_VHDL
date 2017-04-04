library ieee;
use ieee.std_logic_1164.all;

entity comp_regP1_IF_ID is
	port (
		clk        : in  STD_LOGIC;
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_instr  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		Q_PC   : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_I    : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end comp_regP1_IF_ID;

architecture arc of comp_regP1_IF_ID is
	signal reg_PC    : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_instr : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
begin
	process (clk, new_PC, reg_PC, reg_instr, new_instr)
	begin
		if (clk = '1' and clk'event) then
			Q_PC <= reg_PC;
			Q_I  <= reg_instr;
			
			reg_PC    <= new_PC;
			reg_instr <= new_instr;
		end if;
	end process;
end arc;