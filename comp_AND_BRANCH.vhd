library ieee;
use ieee.std_logic_1164.all;

entity comp_AND_BRANCH is
	port (
		in0  : in  STD_LOGIC;
		in1  : in  STD_LOGIC;
		out0 : out STD_LOGIC
	);
end comp_AND_BRANCH;

architecture arch of comp_AND_BRANCH is
begin
	out0 <= in0 AND in1;
end arch;
