 LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_mem_instrucoes IS
	PORT (
		clk: IN STD_LOGIC;
		
		regLeitura1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_mem_instrucoes;

ARCHITECTURE behavior OF comp_mem_instrucoes IS

	signal r0  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "01001" & "00000" & "00000" & "010000";
	signal r1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "01010" & "00000" & "00000" & "100000";
	signal r2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "01011" & "00000" & "00001" & "000000";
	signal r3  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "01100" & "00000" & "00010" & "000000";
	signal r4  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "00001" & "00000" & "00000" & "010000";
	signal r5  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "00010" & "00000" & "00000" & "100000";
	signal r6  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "00011" & "00000" & "00001" & "000000";
	signal r7  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "00100" & "00000" & "00010" & "000000";
	signal r8  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r9  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r10 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r11 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r12 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r13 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r14 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r15 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r16 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r17 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r18 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r19 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r20 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r21 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r22 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r23 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r24 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r25 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r26 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r27 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r28 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r29 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r30 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r31 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r32 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r33 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";

BEGIN
	process(clk)
		begin
			if (CLK = '0' and CLK'event) then
				if(regLeitura1 = "00000000000000000000000000000000") then
					dados1 <= r0;
				elsif(regLeitura1 = "00000000000000000000000000000001") then
					dados1 <= r1;
				elsif(regLeitura1 = "00000000000000000000000000000010") then
					dados1 <= r2;
				elsif(regLeitura1 = "00000000000000000000000000000011") then
					dados1 <= r3;
				elsif(regLeitura1 = "00000000000000000000000000000100") then
					dados1 <= r4;
				elsif(regLeitura1 = "00000000000000000000000000000101") then
					dados1 <= r5;
				elsif(regLeitura1 = "00000000000000000000000000000110") then
					dados1 <= r6;
				elsif(regLeitura1 = "00000000000000000000000000000111") then
					dados1 <= r7;
				elsif(regLeitura1 = "00000000000000000000000000001000") then
					dados1 <= r8;
				elsif(regLeitura1 = "00000000000000000000000000001001") then
					dados1 <= r9;
				elsif(regLeitura1 = "00000000000000000000000000001010") then
					dados1 <= r10;
				elsif(regLeitura1 = "00000000000000000000000000001011") then
					dados1 <= r11;
				elsif(regLeitura1 = "00000000000000000000000000001100") then
					dados1 <= r12;
				elsif(regLeitura1 = "00000000000000000000000000001101") then
					dados1 <= r13;
				elsif(regLeitura1 = "00000000000000000000000000001110") then
					dados1 <= r14;
				elsif(regLeitura1 = "00000000000000000000000000001111") then
					dados1 <= r15;
				elsif(regLeitura1 = "00000000000000000000000000010000") then
					dados1 <= r16;
				elsif(regLeitura1 = "00000000000000000000000000010001") then
					dados1 <= r17;
				elsif(regLeitura1 = "00000000000000000000000000010010") then
					dados1 <= r18;
				elsif(regLeitura1 = "00000000000000000000000000010011") then
					dados1 <= r19;
				elsif(regLeitura1 = "00000000000000000000000000010100") then
					dados1 <= r20;
				elsif(regLeitura1 = "00000000000000000000000000010101") then
					dados1 <= r21;
				elsif(regLeitura1 = "00000000000000000000000000010110") then
					dados1 <= r22;
				elsif(regLeitura1 = "00000000000000000000000000010111") then
					dados1 <= r23;
				elsif(regLeitura1 = "00000000000000000000000000011000") then
					dados1 <= r24;
				elsif(regLeitura1 = "00000000000000000000000000011001") then
					dados1 <= r25;
				elsif(regLeitura1 = "00000000000000000000000000011010") then
					dados1 <= r26;
				elsif(regLeitura1 = "00000000000000000000000000011011") then
					dados1 <= r27;
				elsif(regLeitura1 = "00000000000000000000000000011100") then
					dados1 <= r28;
				elsif(regLeitura1 = "00000000000000000000000000011101") then
					dados1 <= r29;
				elsif(regLeitura1 = "00000000000000000000000000011110") then
					dados1 <= r30;
				elsif(regLeitura1 = "00000000000000000000000000011111") then
					dados1 <= r31;
				elsif(regLeitura1 = "00000000000000000000000000100000") then
					dados1 <= r32;
				elsif(regLeitura1 = "00000000000000000000000000100001") then
					dados1 <= r33;
				end if;		
			end if;			
		end process;
END behavior;
