library ieee;
use ieee.std_logic_1164.all;

entity comp_PC is
	port (
		clk    : in  STD_LOGIC;
		new_PC : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q      : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end comp_PC;

architecture arc of comp_PC is
	signal reg_PC  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
begin
	process (clk, reg_PC, new_PC)
	begin
		if (clk = '1' and clk'event) then
			Q <= reg_PC;
			reg_PC <= new_PC;
		end if;
	end process;
end arc;