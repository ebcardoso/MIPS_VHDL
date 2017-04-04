library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_somadorPC is
	port (
		PC  : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		res : out STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
end comp_somadorPC;

architecture arc of comp_somadorPC is
begin
	res <= PC + "00001";
end arc;