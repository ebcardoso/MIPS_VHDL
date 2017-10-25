library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp_mem_dados is
    generic (
        DATA_WIDTH : integer := 8;
        ADDR_WIDTH : integer := 32 -- 2 ^ ADDR_WIDTH addresses
    );
    port (
        a_clock  : in std_logic;
		  
        a_wren   : in std_logic;
        a_read   : in std_logic;
		  
        a_addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        --a_data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        --a_data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
        a_data_i : in  std_logic_vector(31 downto 0);
        a_data_o : out std_logic_vector(31 downto 0);
		  
		  addr16 : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
		  addr24 : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
		  d16 : out std_logic_vector(ADDR_WIDTH - 1 downto 0);
		  d24 : out std_logic_vector(ADDR_WIDTH - 1 downto 0)
    );
end comp_mem_dados;

architecture behavior of comp_mem_dados is
	constant NW : integer := 2 ** ADDR_WIDTH - 1; -- number of words
	type bram_t is array (NW downto 0) of std_logic_vector(DATA_WIDTH - 1 downto 0);

	shared variable bram : bram_t;
begin
   -- Port A
	process (a_clock)
	begin
		if (a_clock = '0' and a_clock'event) then
			if (a_read = '1') then
				a_data_o <= bram(3+to_integer(unsigned(a_addr)))
							 & bram(2+to_integer(unsigned(a_addr)))
							 & bram(1+to_integer(unsigned(a_addr)))
							 & bram(  to_integer(unsigned(a_addr)));
			end if;
		end if;
		  
		if (a_clock = '1' and a_clock'event) then
			if (a_wren = '1') then
				bram(3+to_integer(unsigned(a_addr))) := a_data_i(31 DOWNTO 24);
				bram(2+to_integer(unsigned(a_addr))) := a_data_i(23 DOWNTO 16);
				bram(1+to_integer(unsigned(a_addr))) := a_data_i(15 DOWNTO 8);
				bram(  to_integer(unsigned(a_addr))) := a_data_i( 7 DOWNTO 0);
			end if;
		end if;
		
		d16 <= bram(3+to_integer(unsigned(addr16)))
			  & bram(2+to_integer(unsigned(addr16)))
			  & bram(1+to_integer(unsigned(addr16)))
			  & bram(  to_integer(unsigned(addr16)));
			  
		d24 <= bram(3+to_integer(unsigned(addr24)))
			  & bram(2+to_integer(unsigned(addr24)))
			  & bram(1+to_integer(unsigned(addr24)))
			  & bram(  to_integer(unsigned(addr24)));
	end process;     
end behavior;