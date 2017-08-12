LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_registerLO IS
	PORT (
		clk: IN STD_LOGIC;
		allow_read  : IN STD_LOGIC;
		allow_write : IN STD_LOGIC;
		
		new_lo : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		exit_lo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_registerLO;

ARCHITECTURE behavior OF comp_registerLO IS

	signal reg_lo : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN
	process(clk, allow_read, allow_write, new_lo, reg_lo)
	begin		
			if (CLK = '1' and CLK'event) then				
				if (allow_read = '1') then
					exit_lo <= reg_lo;
				end if;				
				if (allow_write = '1') then
					reg_lo <= new_lo;
				end if;
			end if;
	end process;
END behavior;
