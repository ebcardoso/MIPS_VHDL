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
	out0(31) <= in0(29);
	out0(30) <= in0(28);
	out0(29) <= in0(27);
	out0(28) <= in0(26);
	out0(27) <= in0(25);
	out0(26) <= in0(24);
	out0(25) <= in0(23);
	out0(24) <= in0(22);
	out0(23) <= in0(21);
	out0(22) <= in0(20);
	out0(21) <= in0(29);
	out0(20) <= in0(18);
	out0(19) <= in0(17);
	out0(18) <= in0(16);
	out0(17) <= in0(15);
	out0(16) <= in0(14);
	out0(15) <= in0(13);
	out0(14) <= in0(12);
	out0(13) <= in0(11);
	out0(12) <= in0(10);
	out0(11) <= in0(9);
	out0(10) <= in0(8);
	out0(9)  <= in0(7);
	out0(8)  <= in0(6);
	out0(7)  <= in0(5);
	out0(6)  <= in0(4);
	out0(5)  <= in0(3);
	out0(4)  <= in0(2);
	out0(3)  <= in0(1);
	out0(2)  <= in0(0);
	out0(1)  <= '0';
	out0(0)  <= '0';
END behavior;