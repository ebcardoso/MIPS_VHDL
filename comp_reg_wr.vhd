library ieee;
use ieee.std_logic_1164.all;

entity comp_reg_wr is
	port (
		clk : in  std_logic;
		
		in0  : in  std_logic;
		out0 : out std_logic
	);
end comp_reg_wr;

architecture arc of comp_reg_wr is
	signal reg_f : std_logic;
begin
	process (clk)
	begin
		if (clk = '1' and clk'event) then
			reg_f <= in0;
		end if;
		if (clk = '0' and clk'event) then
			out0 <= reg_f;
		end if;
	end process;
end arc;
