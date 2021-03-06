LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_mux4 IS
	PORT (
		in0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		op : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		
		out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_mux4;

ARCHITECTURE behavior OF comp_mux4 IS
BEGIN
	process(op, in0, in1, in2, in3)
		begin		
			if (op = "00") then
				out0 <= in0;			
			elsif (op = "01") then
				out0 <= in1;	
			elsif (op = "10") then
				out0 <= in2;	
			elsif (op = "11") then
				out0 <= in3;
			end if;						
	end process;
END behavior;