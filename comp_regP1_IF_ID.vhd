library ieee;
use ieee.std_logic_1164.all;

entity comp_regP1_IF_ID is
	port (
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
	
		clk        : in  STD_LOGIC;
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_instr  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		Q_PC   : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_I    : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end comp_regP1_IF_ID;

architecture arc of comp_regP1_IF_ID is
	signal reg_PC    : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_instr : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
begin
	process (clk)
	begin
		if (clk = '1' and clk'event) then
			
			if (allow_write = '1') then
				reg_PC    <= new_PC;
				reg_instr <= new_instr;
			end if;
		end if;
		
		if (clk = '0' and clk'event) then
			if (allow_read = '1') then
				Q_PC <= reg_PC;
				Q_I  <= reg_instr;
			end if;
		end if;
	end process;
end arc;