LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mips_vhdl IS
	PORT (
		entrada :  IN STD_LOGIC_VECTOR(31 DOWNTO 0);		
		saida   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END mips_vhdl;

ARCHITECTURE behavior OF mips_vhdl IS

component comp_desloc2esc
  PORT (
		in0  :  IN STD_LOGIC_VECTOR(31 DOWNTO 0);		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

BEGIN
	PM1: comp_desloc2esc port map (entrada, saida);
END behavior;