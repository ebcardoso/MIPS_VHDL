library ieee;
use ieee.std_logic_1164.all;

entity comp_reg_funct is
	port (
		clk : in  std_logic;
		
		in0  : in  std_logic_vector(5 DOWNTO 0);
		out0 : out std_logic_vector(5 DOWNTO 0);
		f : out std_logic_vector(5 DOWNTO 0)
	);
end comp_reg_funct;

architecture arc of comp_reg_funct is
	signal reg_f : std_logic_vector(5 DOWNTO 0);
begin
	process (clk)
	begin
		if (clk = '1' and clk'event) then
			reg_f <= in0;
		end if;
		if (clk = '0' and clk'event) then
			out0 <= reg_f;
			f    <= reg_f;
		end if;
	end process;
end arc;
