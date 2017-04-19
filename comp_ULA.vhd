LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

ENTITY comp_ULA IS
	PORT (
		OP : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	
		in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		res  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		zero : OUT STD_LOGIC := '0'
	);
END comp_ULA;

ARCHITECTURE behavior OF comp_ULA IS
BEGIN
	PROCESS (OP, in1, in2)
	BEGIN
		if    (OP = "0000") then --and --livro
			res <= in1 and in2;
		elsif (OP = "0001") then --or --livro
			res <= in1 or in2;
		elsif (OP = "0010") then --sum --livro
			res <= in1 + in2;
		elsif (OP = "0011") then
		elsif (OP = "0100") then
		elsif (OP = "0101") then
		elsif (OP = "0110") then --sub --livro
			res <= in1 - in2;
		elsif (OP = "0111") then --slt --livro
			if (in1 < in2) then
				res <= "00000000000000000000000000000000";
			else
				res <= "00000000000000000000000000000001";
			end if;
		elsif (OP = "1000") then
		elsif (OP = "1001") then
		elsif (OP = "1010") then
		elsif (OP = "1011") then
		elsif (OP = "1100") then --nor --livro
			res <= in1 nor in2;
		elsif (OP = "1101") then
		elsif (OP = "1110") then
		elsif (OP = "1111") then
		end if;
	END PROCESS;
END behavior;