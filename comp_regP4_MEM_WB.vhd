library ieee;
use ieee.std_logic_1164.all;

entity comp_regP4_MEM_WB is
	port (
		clk1, clk2, clk3 : in  STD_LOGIC;
		
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		
		new_ula           : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dado_leitura  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEsc        : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		Q_ula          : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_dado_leitura : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEsc       : out STD_LOGIC_VECTOR(4 DOWNTO 0)--;
		
		--sinais de controle entrada			
--		--WB
--		new_EscreveReg : in STD_LOGIC;
--		new_MemparaReg : in STD_LOGIC;
--		--
--		
--		--sinais de controle saida		
--		--WB
--		Q_EscreveReg : out STD_LOGIC;
--		Q_MemparaReg : out STD_LOGIC
--		--
	);
end comp_regP4_MEM_WB;

architecture arc of comp_regP4_MEM_WB is
	signal reg_ula          : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_dado_leitura : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_regEsc : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	
	--registradores dos sinais de controle
	--WB
--	signal reg_EscreveReg : STD_LOGIC := '0';
--	signal reg_MemparaReg : STD_LOGIC := '0';
begin
	process(clk1)
	begin
		if (clk1 = '1' and clk1'event) then
			if (allow_read = '1') then
				Q_ula <= reg_ula;
			end if;
			
			if (allow_write = '1') then			
				reg_ula <= new_ula;
			end if;
		end if;
	end process;
	
	process(clk2)
	begin
		if (clk2 = '1' and clk2'event) then
			if (allow_read = '1') then
				Q_dado_leitura  <= reg_dado_leitura;
			end if;
			
			if (allow_write = '1') then
				reg_dado_leitura <= new_dado_leitura;
			end if;	
		end if;
	end process;

	process(clk3)
	begin
		if (clk3 = '1' and clk3'event) then
			if (allow_read = '1') then
				Q_regEsc <= reg_regEsc;
			end if;
			
			if (allow_write = '1') then	
				reg_regEsc <= new_regEsc;
			end if;	
		end if;
	end process;
	
--	process (clk)
--	begin
--		if (clk = '1' and clk'event) then
--			if (allow_read = '1') then
--				Q_ula           <= reg_ula;
--				Q_dado_leitura  <= reg_dado_leitura;
--				Q_regEsc <= reg_regEsc;
				
--				--WB
--				Q_EscreveReg <= reg_EscreveReg;
--				Q_MemparaReg <= reg_MemparaReg;
--			end if;
--			
--			if (allow_write = '1') then				
--				reg_ula          <= new_ula;
--				reg_dado_leitura <= new_dado_leitura;
--				reg_regEsc <= new_regEsc;
--				
				--WB
--				reg_EscreveReg <= new_EscreveReg;
--				reg_MemparaReg <= new_MemparaReg;
--			end if;
--		end if;
--	end process;
end arc;