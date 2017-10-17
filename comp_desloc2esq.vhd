LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_desloc2esc IS
	PORT (
		in0  :  IN STD_LOGIC_VECTOR(31 DOWNTO 0);		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_desloc2esc;

ARCHITECTURE behavior OF comp_desloc2esc IS
BEGIN
	out0 <= in0(29 DOWNTO 0) & "00";
END behavior;