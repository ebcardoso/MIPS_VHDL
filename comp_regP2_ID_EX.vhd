library ieee;
use ieee.std_logic_1164.all;

entity comp_regP2_ID_EX is
	port (		
		clk1, clk2, clk3, clk4, clk5, clk6 : in  STD_LOGIC;
		
		allow_read  : in  STD_LOGIC;
		allow_write : in  STD_LOGIC;
		
		new_PC     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados1 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_dados2 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_ext    : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		new_regEscRT : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		new_regEscRD : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
		
		Q_PC  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D1  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_D2  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_EXT : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		Q_regEscRT : out STD_LOGIC_VECTOR(4 DOWNTO 0);
		Q_regEscRD : out STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
end comp_regP2_ID_EX;

architecture arc of comp_regP2_ID_EX is
	signal reg_PC  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_D2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_ext : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal reg_regEscRT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	signal reg_regEscRD : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";

	--registradores dos sinais de controle
	--EX
	--signal reg_RegDst  : STD_LOGIC := '0';
	--signal reg_OpALU   : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	--signal reg_OrigALU : STD_LOGIC := '0';
	--MEM
	--signal reg_Branch     : STD_LOGIC := '0';
	--signal reg_LeMem      : STD_LOGIC := '0';
	--signal reg_EscreveMem : STD_LOGIC := '0';
	--WB
	----signal reg_EscreveReg : STD_LOGIC := '0';
	signal reg_MemparaReg : STD_LOGIC := '0';
begin
	process (clk1)
	begin
		if (clk1 = '1' and clk1'event) then
			if (allow_read = '1') then
				Q_PC  <= reg_PC;
			end if;
			
			if (allow_write = '1') then
				reg_PC  <= new_PC;
			end if;
		end if;
	end process;
	
	process (clk2)
	begin
		if (clk2 = '1' and clk2'event) then
			if (allow_read = '1') then
				Q_D1  <= reg_D1;
			end if;
			
			if (allow_write = '1') then
				reg_D1  <= new_dados1;
			end if;
		end if;
	end process;
	
	process (clk3)
	begin
		if (clk3 = '1' and clk3'event) then
			if (allow_read = '1') then
				Q_D2  <= reg_D2;
			end if;
			
			if (allow_write = '1') then
				reg_D2  <= new_dados2;
			end if;
		end if;
	end process;
	
	process (clk4)
	begin
		if (clk4 = '1' and clk4'event) then
			if (allow_read = '1') then
				Q_EXT <= reg_ext;
			end if;
			
			if (allow_write = '1') then
				reg_ext <= new_ext;
			end if;
		end if;
	end process;
	
	process (clk5)
	begin
		if (clk5 = '1' and clk5'event) then
			if (allow_read = '1') then
				Q_regEscRT <= reg_regEscRT;
			end if;
			
			if (allow_write = '1') then
				reg_regEscRT <= new_regEscRT;
			end if;
		end if;
	end process;
	
	
	process (clk6)
	begin
		if (clk6 = '1' and clk6'event) then
			if (allow_read = '1') then
				Q_regEscRD <= reg_regEscRD;
			end if;
			
			if (allow_write = '1') then
				reg_regEscRD <= new_regEscRD;
			end if;
		end if;
	end process;

--	process (clk)
--	begin
--		if (clk = '1' and clk'event) then
--			if (allow_read = '1') then
--				Q_PC  <= reg_PC;
--				Q_D1  <= reg_D1;
--				Q_D2  <= reg_D2;
--				Q_EXT <= reg_ext;
--				Q_regEscRT <= reg_regEscRT;
--				Q_regEscRD <= reg_regEscRD;
				
				--EX
				--Q_RegDst  <= reg_RegDst;
				--Q_OpALU   <= reg_OpALU;
				--Q_OrigALU <= reg_OrigALU;
				--MEM
				--Q_Branch     <= reg_Branch;
				--Q_LeMem      <= reg_LeMem;
				--Q_EscreveMem <= reg_EscreveMem;
				--WB
				--Q_EscreveReg <= reg_EscreveReg;
				--Q_MemparaReg <= reg_MemparaReg;
--			end if;
--			
--			if (allow_write = '1') then
--				reg_PC  <= new_PC;
--				reg_D1  <= new_dados1;
--				reg_D2  <= new_dados2;
--				reg_ext <= new_ext;
--				reg_regEscRT <= new_regEscRT;
--				reg_regEscRD <= new_regEscRD;
				
				--EX
				--reg_RegDst  <= new_RegDst;
				--reg_OpALU   <= new_OpALU;
				--reg_OrigALU <= new_OrigALU;
				--MEM
				--reg_Branch     <= new_Branch;
				--reg_LeMem      <= new_LeMem;
				--reg_EscreveMem <= new_EscreveMem;
				--WB
				--reg_EscreveReg <= new_EscreveReg;
				--reg_MemparaReg <= new_MemparaReg;	
--			end if;		
--		end if;
--	end process;
end arc;