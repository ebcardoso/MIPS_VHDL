library ieee;
use ieee.std_logic_1164.all;

entity comp_regP4_MEM_WB is
	port (
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		
		new_ula           : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dado_leitura  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEsc        : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		Q_ula          : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_dado_leitura : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEsc       : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		--sinais de controle entrada			
		--WB
		new_EscreveReg : in STD_LOGIC;
		new_MemparaReg : in STD_LOGIC;
		--
		
		--sinais de controle saida		
		--WB
		Q_EscreveReg : out STD_LOGIC;
		Q_MemparaReg : out STD_LOGIC
		--
	);
end comp_regP4_MEM_WB;

architecture arc of comp_regP4_MEM_WB is
	signal reg_ula          : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_dado_leitura : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_regEsc : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	
	--registradores dos sinais de controle
	--WB
	signal reg_EscreveReg : STD_LOGIC := '0';
	signal reg_MemparaReg : STD_LOGIC := '0';
begin
	process (clk, allow_read, allow_write, reg_ula, reg_dado_leitura, new_ula, new_dado_leitura,
				new_EscreveReg, new_MemparaReg,
				reg_EscreveReg, reg_MemparaReg,
				reg_regEsc, new_regEsc)
	begin
		if (clk = '1' and clk'event) then
			if (allow_read = '1') then
				Q_ula           <= reg_ula;
				Q_dado_leitura  <= reg_dado_leitura;
				Q_regEsc <= reg_regEsc;
				
				--WB
				Q_EscreveReg <= reg_EscreveReg;
				Q_MemparaReg <= reg_MemparaReg;
			end if;
			
			if (allow_write = '1') then				
				reg_ula          <= new_ula;
				reg_dado_leitura <= new_dado_leitura;
				reg_regEsc <= new_regEsc;
				
				--WB
				reg_EscreveReg <= new_EscreveReg;
				reg_MemparaReg <= new_MemparaReg;
			end if;
		end if;
	end process;
end arc;