LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

ENTITY comp_ULA IS
	PORT (
		OP : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	
		in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		in2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		res  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		zero : OUT STD_LOGIC := '0';
		
		hi : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		lo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		active_banco_reg : OUT STD_LOGIC := '0'
	);
END comp_ULA;

ARCHITECTURE behavior OF comp_ULA IS
	signal multi : STD_LOGIC_VECTOR(63 DOWNTO 0);
BEGIN
	PROCESS (OP, in1, in2)
	BEGIN
		if    (OP = "0000") then --and --livro
			res <= in1 and in2;
		elsif (OP = "0001") then --or --livro
			res <= in1 or in2;
		elsif (OP = "0010") then --sum --livro
			res <= in1 + in2;
		elsif (OP = "0011") then -- multi
			multi <= in1 * in2;
			hi <= multi(63 DOWNTO 32);
			lo <= multi(31 DOWNTO 0);
			active_banco_reg <= '1';
		elsif (OP = "0100") then --div
			--hi <= in1 / in2;
			--lo <= in1 mod in2;
			--active_banco_reg <= '1';
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
		elsif (OP = "1110") then --sll
			if    (in2 = "00000000000000000000000000000000") then
				res <= in1;
			elsif (in2 = "00000000000000000000000000000001") then
				res <= in1(30 DOWNTO 0) & "0";
			elsif (in2 = "00000000000000000000000000000010") then
				res <= in1(29 DOWNTO 0) & "00";
			elsif (in2 = "00000000000000000000000000000011") then
				res <= in1(28 DOWNTO 0) & "000";
			elsif (in2 = "00000000000000000000000000000100") then
				res <= in1(27 DOWNTO 0) & "0000";
			elsif (in2 = "00000000000000000000000000000101") then
				res <= in1(26 DOWNTO 0) & "00000";
			elsif (in2 = "00000000000000000000000000000110") then
				res <= in1(25 DOWNTO 0) & "000000";
			elsif (in2 = "00000000000000000000000000000111") then
				res <= in1(24 DOWNTO 0) & "0000000";
			elsif (in2 = "00000000000000000000000000001000") then
				res <= in1(23 DOWNTO 0) & "00000000";
			elsif (in2 = "00000000000000000000000000001001") then
				res <= in1(22 DOWNTO 0) & "000000000";
			elsif (in2 = "00000000000000000000000000001010") then
				res <= in1(21 DOWNTO 0) & "0000000000";
			elsif (in2 = "00000000000000000000000000001011") then
				res <= in1(20 DOWNTO 0) & "00000000000";
			elsif (in2 = "00000000000000000000000000001100") then
				res <= in1(19 DOWNTO 0) & "000000000000";
			elsif (in2 = "00000000000000000000000000001101") then
				res <= in1(18 DOWNTO 0) & "0000000000000";
			elsif (in2 = "00000000000000000000000000001110") then
				res <= in1(17 DOWNTO 0) & "00000000000000";
			elsif (in2 = "00000000000000000000000000001111") then
				res <= in1(16 DOWNTO 0) & "000000000000000";
			elsif (in2 = "00000000000000000000000000010000") then
				res <= in1(15 DOWNTO 0) & "0000000000000000";
			elsif (in2 = "00000000000000000000000000010001") then
				res <= in1(14 DOWNTO 0) & "00000000000000000";
			elsif (in2 = "00000000000000000000000000010010") then
				res <= in1(13 DOWNTO 0) & "000000000000000000";
			elsif (in2 = "00000000000000000000000000010011") then
				res <= in1(12 DOWNTO 0) & "0000000000000000000";
			elsif (in2 = "00000000000000000000000000010100") then
				res <= in1(11 DOWNTO 0) & "00000000000000000000";
			elsif (in2 = "00000000000000000000000000010101") then
				res <= in1(10 DOWNTO 0) & "000000000000000000000";
			elsif (in2 = "00000000000000000000000000010110") then
				res <= in1( 9 DOWNTO 0) & "0000000000000000000000";
			elsif (in2 = "00000000000000000000000000010111") then
				res <= in1( 8 DOWNTO 0) & "00000000000000000000000";
			elsif (in2 = "00000000000000000000000000011000") then
				res <= in1( 7 DOWNTO 0) & "000000000000000000000000";
			elsif (in2 = "00000000000000000000000000011001") then
				res <= in1( 6 DOWNTO 0) & "0000000000000000000000000";
			elsif (in2 = "00000000000000000000000000011010") then
				res <= in1( 5 DOWNTO 0) & "00000000000000000000000000";
			elsif (in2 = "00000000000000000000000000011011") then
				res <= in1( 4 DOWNTO 0) & "000000000000000000000000000";
			elsif (in2 = "00000000000000000000000000011100") then
				res <= in1( 3 DOWNTO 0) & "0000000000000000000000000000";
			elsif (in2 = "00000000000000000000000000011101") then
				res <= in1( 2 DOWNTO 0) & "00000000000000000000000000000";
			elsif (in2 = "00000000000000000000000000011110") then
				res <= in1( 1 DOWNTO 0) & "000000000000000000000000000000";
			elsif (in2 = "00000000000000000000000000011111") then	
				res <= in1(0) &           "0000000000000000000000000000000";
			end if;
		elsif (OP = "1111") then --srl
			if    (in2 = "00000000000000000000000000000000") then
				res <= in1;
			elsif (in2 = "00000000000000000000000000000001") then
				res <= "0" & in1(31 DOWNTO 1);
			elsif (in2 = "00000000000000000000000000000010") then
				res <= "00" & in1(31 DOWNTO 2);
			elsif (in2 = "00000000000000000000000000000011") then
				res <= "000" & in1(31 DOWNTO 3);
			elsif (in2 = "00000000000000000000000000000100") then
				res <= "0000" & in1(31 DOWNTO 4);
			elsif (in2 = "00000000000000000000000000000101") then
				res <= "00000" & in1(31 DOWNTO 5);
			elsif (in2 = "00000000000000000000000000000110") then
				res <= "000000" & in1(31 DOWNTO 6);
			elsif (in2 = "00000000000000000000000000000111") then
				res <= "0000000" & in1(31 DOWNTO 7);
			elsif (in2 = "00000000000000000000000000001000") then
				res <= "00000000" & in1(31 DOWNTO 8);
			elsif (in2 = "00000000000000000000000000001001") then
				res <= "000000000" & in1(31 DOWNTO 9);
			elsif (in2 = "00000000000000000000000000001010") then
				res <= "0000000000" & in1(31 DOWNTO 10);
			elsif (in2 = "00000000000000000000000000001011") then
				res <= "00000000000" & in1(31 DOWNTO 11);
			elsif (in2 = "00000000000000000000000000001100") then
				res <= "000000000000" & in1(31 DOWNTO 12);
			elsif (in2 = "00000000000000000000000000001101") then
				res <= "0000000000000" & in1(31 DOWNTO 13);
			elsif (in2 = "00000000000000000000000000001110") then
				res <= "00000000000000" & in1(31 DOWNTO 14);
			elsif (in2 = "00000000000000000000000000001111") then
				res <= "000000000000000" & in1(31 DOWNTO 15);
			elsif (in2 = "00000000000000000000000000010000") then
				res <= "0000000000000000" & in1(31 DOWNTO 16);
			elsif (in2 = "00000000000000000000000000010001") then
				res <= "00000000000000000" & in1(31 DOWNTO 17);
			elsif (in2 = "00000000000000000000000000010010") then
				res <= "000000000000000000" & in1(31 DOWNTO 18);
			elsif (in2 = "00000000000000000000000000010011") then
				res <= "0000000000000000000" & in1(31 DOWNTO 19);
			elsif (in2 = "00000000000000000000000000010100") then
				res <= "00000000000000000000" & in1(31 DOWNTO 20);
			elsif (in2 = "00000000000000000000000000010101") then
				res <= "000000000000000000000" & in1(31 DOWNTO 21);
			elsif (in2 = "00000000000000000000000000010110") then
				res <= "0000000000000000000000" & in1(31 DOWNTO 22);
			elsif (in2 = "00000000000000000000000000010111") then
				res <= "00000000000000000000000" & in1(31 DOWNTO 23);
			elsif (in2 = "00000000000000000000000000011000") then
				res <= "000000000000000000000000" & in1(31 DOWNTO 24);
			elsif (in2 = "00000000000000000000000000011001") then
				res <= "0000000000000000000000000" & in1(31 DOWNTO 25);
			elsif (in2 = "00000000000000000000000000011010") then
				res <= "00000000000000000000000000" & in1(31 DOWNTO 26);
			elsif (in2 = "00000000000000000000000000011011") then
				res <= "000000000000000000000000000" & in1(31 DOWNTO 27);
			elsif (in2 = "00000000000000000000000000011100") then
				res <= "0000000000000000000000000000" & in1(31 DOWNTO 28);
			elsif (in2 = "00000000000000000000000000011101") then
				res <= "00000000000000000000000000000" & in1(31 DOWNTO 29);
			elsif (in2 = "00000000000000000000000000011110") then
				res <= "000000000000000000000000000000" & in1(31 DOWNTO 30);
			elsif (in2 = "00000000000000000000000000011111") then	
				res <= "0000000000000000000000000000000" & in1(0);
			end if;
		end if;
	END PROCESS;
END behavior;
