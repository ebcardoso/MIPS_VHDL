library ieee;
use ieee.std_logic_1164.all;

entity comp_regP4_MEM_WB is
	port (
		clk : in  STD_LOGIC;
		
		new_ula           : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dado_leitura  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		Q_ula          : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_dado_leitura : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end comp_regP4_MEM_WB;

architecture arc of comp_regP4_MEM_WB is
	signal reg_ula          : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_dado_leitura : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
begin
	process (clk, reg_ula, reg_dado_leitura, new_ula, new_dado_leitura)
	begin
		if (clk = '1' and clk'event) then
			Q_ula           <= reg_ula;
			Q_dado_leitura  <= reg_dado_leitura;
			
			reg_ula          <= new_ula;
			reg_dado_leitura <= new_dado_leitura;
		end if;
	end process;
end arc;