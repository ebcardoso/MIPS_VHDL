library ieee;
use ieee.std_logic_1164.all;

entity comp_aux3 is
	port (
		clk : in  std_logic;
	
		in_op2  : in std_logic;
		out_op2 : out std_logic;

		in_d2 : in std_logic_vector(31 DOWNTO 0);
		out_d2 : out std_logic_vector(31 DOWNTO 0);

		in_funct : in std_logic_vector(31 DOWNTO 0);
		out_funct : out std_logic_vector(31 DOWNTO 0);

		in_opALU : in std_logic_vector(1 DOWNTO 0);
		out_opALU : out std_logic_vector(1 DOWNTO 0);

		in_wd  : in std_logic;
		out_wd : out std_logic;

		in_rd  : in std_logic;
		out_rd : out std_logic
	);
end comp_aux3;

architecture arc of comp_aux3 is
	signal reg_op2 : std_logic;
	signal reg_d2 : std_logic_vector(31 DOWNTO 0);
	signal reg_funct : std_logic_vector(31 DOWNTO 0);
	signal reg_opALU : std_logic_vector(1 DOWNTO 0);
	signal reg_wd : std_logic;
	signal reg_rd : std_logic;
begin
	process (clk)
	begin
		if (clk = '1' and clk'event) then
			reg_op2 <= in_op2;
			reg_d2 <= in_d2;
			reg_funct <= in_funct;
			reg_opALU <= in_opALU;
			reg_wd <= in_wd;
			reg_rd <= in_rd;
		end if;
		if (clk = '0' and clk'event) then
			out_op2 <= reg_op2;
			out_d2 <= reg_d2;
			out_funct <= reg_funct;
			out_opALU <= reg_opALU;
			out_wd <= reg_wd;
			out_rd <= reg_rd;
		end if;
	end process;
end arc;
