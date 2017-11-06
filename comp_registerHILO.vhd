LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_registerHILO IS
	PORT (
		clk: IN STD_LOGIC;
		allow_read  : IN STD_LOGIC;
		allow_write : IN STD_LOGIC;
		
		new_value  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		exit_value : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_registerHILO;

ARCHITECTURE behavior OF comp_registerHILO IS
	signal reg_value : STD_LOGIC_VECTOR(31 DOWNTO 0);	
BEGIN
	process(clk)
	begin		
		if (CLK = '0' and CLK'event) then
			if (allow_read = '1') then
				exit_value <= reg_value;
			end if;
		end if;
		
		if (CLK = '1' and CLK'event) then
			if (allow_write = '1') then
				reg_value <= new_value;
			end if;
		end if;
	end process;
END behavior;
