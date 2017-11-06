LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_controle IS
	PORT (
		OPCode    : in STD_LOGIC_VECTOR(5 downto 0);
	
		--sinais de controle saida
		--ID
		Q_readHI : out STD_LOGIC;
		Q_readLO : out STD_LOGIC;
		--EX
		Q_RegDst  : out STD_LOGIC;
		Q_OpALU   : out STD_LOGIC_VECTOR(1 DOWNTO 0);
		Q_OrigALU : out STD_LOGIC;
		Q_OrigCont: out STD_LOGIC;
		Q_ContALU : out STD_LOGIC_VECTOR(3 DOWNTO 0);
		--Q_LOorHI  : out STD_LOGIC;
		Q_OrigOP1 : out STD_LOGIC;
		--MEM
		Q_Branch     : out STD_LOGIC;
		Q_Jump		 : out STD_LOGIC;
		Q_LeMem      : out STD_LOGIC;
		Q_EscreveMem : out STD_LOGIC;
		--WB
		Q_EscreveReg  : out STD_LOGIC;
		Q_MemparaReg  : out STD_LOGIC;
		Q_EscreveHILO : out STD_LOGIC
		--
	);
END comp_controle;

ARCHITECTURE behavior OF comp_controle IS
BEGIN
	process(OPCode)
	begin
		if    (OPCode = "010000") then --addi
			Q_ContALU <= "0010";
		elsif (OPCode = "010001") then --multi
			Q_ContALU <= "0011";
		elsif (OPCode = "010010") then --subi
			Q_ContALU <= "0110";
		elsif (OPCode = "010011") then --divi
			Q_ContALU <= "0100";
		elsif (OPCode = "010100") then --andi
			Q_ContALU <= "0000";
		elsif (OPCode = "010110") then --ori
			Q_ContALU <= "0001";		
		elsif (OPCode = "100000") then --rflo
			Q_ContALU <= "0010";
			Q_readLO <= '1';
			Q_readHI <= '0';
			--Q_LOorHI <= '0';
--		elsif (OPCode = "100001") then --rfhi
--			Q_ContALU <= "0010";
--			Q_readLO <= '0';
--			Q_readHI <= '1';
			--Q_LOorHI <= '1';
		end if;
	
		if (OPCode = "000000" or OPCode = "000001") then --R
			--EX
			Q_RegDst  <= '1';
			Q_OpALU   <= "10";
			Q_OrigALU <= '0'; --imediato ou registrador
			Q_OrigCont <= '0'; --do controle da ula ou do geral
			Q_OrigOP1    <= '0';
			--MEM
			Q_Branch     <= '0';
			Q_Jump       <= '0';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '0';
			--WB
			Q_MemparaReg  <= '0';
			
			Q_EscreveReg  <= not OPCode(0);
			Q_EscreveHILO <= OPCode(0);
		elsif (OPCode = "010000" or OPCode = "010001"
		 	 or OPCode = "010010" or OPCode = "010011"
			 or OPCode = "010100" or OPCode = "010110") then--I
			--EX
			Q_RegDst  <= '0';
			Q_OpALU   <= "10";
			Q_OrigALU  <= '1'; --imediato ou registrador
			Q_OrigCont <= '1'; --do controle da ula ou do geral
			Q_OrigOP1    <= '0';
			--MEM
			Q_Branch     <= '0';
			Q_Jump       <= '0';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '0';
			--WB
			Q_MemparaReg  <= '0';
			
			Q_EscreveReg  <= not OPCode(0);
			Q_EscreveHILO <= OPCode(0);
		elsif (OPCode = "100000") then --rflo
			--EX
			Q_RegDst  <= '0';
			Q_OpALU   <= "10";
			Q_OrigALU  <= '1'; --imediato ou registrador
			Q_OrigCont <= '1'; --do controle da ula ou do geral
			Q_origOP1    <= '1';
			--MEM
			Q_Branch     <= '0';
			Q_Jump       <= '0';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '0';
			--WB
			Q_EscreveReg <= '1';
			Q_MemparaReg <= '0';
			Q_EscreveHILO <= '0';
		elsif (OPCode = "100011") then --lw
			--EX
			Q_RegDst  <= '0';
			Q_OpALU   <= "00";
			Q_OrigALU <= '1';
			Q_OrigCont <= '0';
			Q_origOP1    <= '0';
			--MEM
			Q_Branch     <= '0';
			Q_Jump       <= '0';
			Q_LeMem      <= '1';
			Q_EscreveMem <= '0';
			--WB
			Q_EscreveReg  <= '1';
			Q_MemparaReg  <= '1';
			Q_EscreveHILO <= '0';
		elsif (OPCode = "101011") then --sw
			--EX
			Q_OpALU   <= "00";
			Q_OrigALU <= '1';
			Q_OrigCont <= '0';
			Q_origOP1    <= '0';
			--MEM
			Q_Branch     <= '0';
			Q_Jump       <= '0';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '1';
			--WB
			Q_EscreveReg  <= '0';
		elsif (OPCode = "000100") then --beq
			--MEX
			Q_OpALU   <= "01";
			Q_OrigALU <= '0';
			Q_OrigCont <= '0';
			Q_origOP1    <= '0';
			--MEM
			Q_Branch     <= '1';
			Q_Jump       <= '0';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '0';
			--WB
			Q_EscreveReg  <= '0';
		elsif (OPCode = "000010") then --jump
			--MEX
--			Q_OpALU   <= "01";
--			Q_OrigALU <= '0';
--			Q_OrigCont
			--MEM
			Q_Branch     <= '0';
			Q_Jump       <= '1';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '0';
--			Q_origOP1    <= '0';
			--WB
			Q_EscreveReg  <= '0';
		end if;
	end process;
END behavior;
