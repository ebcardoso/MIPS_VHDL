LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_mux2_32bits IS
	PORT (
		in0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		op : IN STD_LOGIC;
		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_mux2_32bits;

ARCHITECTURE behavior OF comp_mux2_32bits IS
BEGIN
	process(in0, in1, op)
		begin		
			if (op = '0') then
				out0 <= in0;			
			else
				out0 <= in1;
			end if;						
	end process;
END behavior;
