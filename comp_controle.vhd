LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_controle IS
	PORT (
		OPCode    : in STD_LOGIC_VECTOR(5 downto 0);
	
		--sinais de controle saida
		--EX
		Q_RegDst  : out STD_LOGIC;
		Q_OpALU   : out STD_LOGIC_VECTOR(1 DOWNTO 0);
		Q_OrigALU : out STD_LOGIC;
		--MEM
		Q_Branch     : out STD_LOGIC;
		Q_LeMem      : out STD_LOGIC;
		Q_EscreveMem : out STD_LOGIC;
		--WB
		Q_EscreveReg : out STD_LOGIC;
		Q_MemparaReg : out STD_LOGIC
		--
	);
END comp_controle;

ARCHITECTURE behavior OF comp_controle IS
BEGIN
	process(OPCode)
	begin
		if    (OPCode = "000000")	then --R
			--EX
			Q_RegDst  <= '1';
			Q_OpALU   <= "10";
			Q_OrigALU <= '0';
			--MEM
			Q_Branch     <= '0';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '0';
			--WB
			Q_EscreveReg <= '1';
			Q_MemparaReg <= '0';
		elsif (OPCode = "100011") then --lw
			--EX
			Q_RegDst  <= '0';
			Q_OpALU   <= "00";
			Q_OrigALU <= '1';
			--MEM
			Q_Branch     <= '0';
			Q_LeMem      <= '1';
			Q_EscreveMem <= '0';
			--WB
			Q_EscreveReg <= '1';
			Q_MemparaReg <= '1';
		elsif (OPCode = "101011") then --sw
			--EX
			Q_OpALU   <= "00";
			Q_OrigALU <= '1';
			--MEM
			Q_Branch     <= '0';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '1';
			--WB
			Q_EscreveReg <= '0';
			Q_MemparaReg <= '0';
		elsif (OPCode = "000100") then --beq
			--MEX
			Q_OpALU   <= "01";
			Q_OrigALU <= '0';
			--MEM
			Q_Branch     <= '1';
			Q_LeMem      <= '0';
			Q_EscreveMem <= '0';
			--WB
			Q_EscreveReg <= '0';
			Q_MemparaReg <= '0';
		end if;
	end process;
END behavior;
