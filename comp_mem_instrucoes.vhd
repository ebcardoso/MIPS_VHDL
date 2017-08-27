library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp_mem_instrucoes is
    generic (
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 32 -- 2 ^ ADDR_WIDTH addresses
    );
    port (
        a_clock  : in std_logic;
        --a_wren   : in std_logic;
        a_read   : in std_logic;
        a_addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        --a_data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        a_data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end comp_mem_instrucoes;

architecture behavior of comp_mem_instrucoes is
    constant NW : integer := 2 ** ADDR_WIDTH - 1; -- number of words
    type bram_t is array (NW downto 0) of std_logic_vector(DATA_WIDTH - 1 downto 0);

    shared variable bram : bram_t;
begin
    -- Port A
    process (a_clock)
    begin
        if a_clock'event and a_clock = '1' then
            --if (a_wren = '1') then
                --bram(to_integer(unsigned(a_addr))) := a_data_i;
            --end if;

            if (a_read = '1') then
					a_data_o <= bram(to_integer(unsigned(a_addr)));
            end if;
        end if;
    end process;

end behavior;
