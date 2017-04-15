LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_ext_sinal IS
	PORT (
		in0  :  IN STD_LOGIC_VECTOR(15 DOWNTO 0);		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_ext_sinal;

ARCHITECTURE behavior OF comp_ext_sinal IS
BEGIN
	out0 <= "0000000000000000" & in0;
END behavior;