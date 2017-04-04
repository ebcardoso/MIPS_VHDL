library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_somador32 is
	port (
		in1 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		in2 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		res : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end comp_somador32;

architecture arc of comp_somador32 is
begin
	res <= in1 + in2;
end arc;