LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_registerHI IS
	PORT (
		clk: IN STD_LOGIC;
		allow_read  : IN STD_LOGIC;
		allow_write : IN STD_LOGIC;
		
		new_hi : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		exit_hi : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_registerHI;

ARCHITECTURE behavior OF comp_registerHI IS

	signal reg_hi : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN
	process(clk, allow_read, allow_write, new_hi, reg_hi)
	begin		
			if (CLK = '1' and CLK'event) then
				if (allow_read = '1') then
					exit_hi <= reg_hi;
				end if;
				if (allow_write = '1') then
					reg_hi <= new_hi ;
				end if;
			end if;
	end process;
END behavior;
