 LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_mem_instrucoes1 IS
	PORT (
		clk: IN STD_LOGIC;
		
		regLeitura1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_mem_instrucoes1;

ARCHITECTURE behavior OF comp_mem_instrucoes1 IS

	signal r0  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00001" & "00000" & "00000" & "000100"; -- SW A
	signal r1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00101" & "00000" & "00000" & "001000"; -- SW E
	signal r2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00010" & "00000" & "00000" & "010000"; -- SW B
	signal r3  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00111" & "00000" & "00000" & "010100"; -- SW G
	signal r4  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "01011" & "00000" & "00000" & "000100"; -- LW A
	signal r5  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "01111" & "00000" & "00000" & "001000"; -- LW E
	signal r6  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "01100" & "00000" & "00000" & "010000"; -- LW B
	signal r7  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "10001" & "00000" & "00000" & "010100"; -- LW G
	signal r8  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "10000" & "00000" & "00000" & "001100"; -- LW F
	signal r9  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01011" & "01111" & "00000" & "00000" & "100001"; -- mult A*E
	signal r10 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "10010" & "00000" & "00000" & "011000"; -- LW H
	signal r11 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01100" & "10001" & "00000" & "00000" & "100001"; -- mult B*G
	signal r12 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01011" & "10000" & "00000" & "00000" & "100001"; -- mult A*F
	signal r13 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00001" & "00000" & "00000" & "000000"; -- rflo r1
	signal r14 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01100" & "10010" & "00000" & "00000" & "100001"; -- mult B*H
	signal r15 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00010" & "00000" & "00000" & "000000"; -- rflo r2
	signal r16 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00011" & "00000" & "00000" & "000000"; -- rflo r3
	signal r17 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r18 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00100" & "00000" & "00000" & "000000"; -- rflo r4
	signal r19 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00001" & "00010" & "10101" & "00000" & "100000"; -- add r21, r1, r2
	signal r20 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r21 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r22 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00011" & "00100" & "10110" & "00000" & "100000"; -- add r22, r3, r4
	signal r23 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "10101" & "00000" & "00001101000"; -- sw r21, 104(r0)
	signal r24 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r25 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r26 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "10101" & "00000" & "00001101100"; -- sw r22, 108(r0)
	signal r27 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r28 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
	signal r29 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00000" & "00000" & "00000" & "00000" & "000000";
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
				elsif(regLeitura1 = "00000000000000000000000000000100") then
					dados1 <= r1;
				elsif(regLeitura1 = "00000000000000000000000000001000") then
					dados1 <= r2;
				elsif(regLeitura1 = "00000000000000000000000000001100") then
					dados1 <= r3;
				elsif(regLeitura1 = "00000000000000000000000000010000") then
					dados1 <= r4;
				elsif(regLeitura1 = "00000000000000000000000000010100") then
					dados1 <= r5;
				elsif(regLeitura1 = "00000000000000000000000000011000") then
					dados1 <= r6;
				elsif(regLeitura1 = "00000000000000000000000000011100") then
					dados1 <= r7;
				elsif(regLeitura1 = "00000000000000000000000000100000") then
					dados1 <= r8;
				elsif(regLeitura1 = "00000000000000000000000000100100") then
					dados1 <= r9;
				elsif(regLeitura1 = "00000000000000000000000000101000") then
					dados1 <= r10;
				elsif(regLeitura1 = "00000000000000000000000000101100") then
					dados1 <= r11;
				elsif(regLeitura1 = "00000000000000000000000000110000") then
					dados1 <= r12;
				elsif(regLeitura1 = "00000000000000000000000000110100") then
					dados1 <= r13;
				elsif(regLeitura1 = "00000000000000000000000000111000") then
					dados1 <= r14;
				elsif(regLeitura1 = "00000000000000000000000000111100") then
					dados1 <= r15;
				elsif(regLeitura1 = "00000000000000000000000001000000") then
					dados1 <= r16;
				elsif(regLeitura1 = "00000000000000000000000001000100") then
					dados1 <= r17;
				elsif(regLeitura1 = "00000000000000000000000001001000") then
					dados1 <= r18;
				elsif(regLeitura1 = "00000000000000000000000001001100") then
					dados1 <= r19;
				elsif(regLeitura1 = "00000000000000000000000001010000") then
					dados1 <= r20;
				elsif(regLeitura1 = "00000000000000000000000001010100") then
					dados1 <= r21;
				elsif(regLeitura1 = "00000000000000000000000001011000") then
					dados1 <= r22;
				elsif(regLeitura1 = "00000000000000000000000001011100") then
					dados1 <= r23;
				elsif(regLeitura1 = "00000000000000000000000001100000") then
					dados1 <= r24;
				elsif(regLeitura1 = "00000000000000000000000001100100") then
					dados1 <= r25;
				elsif(regLeitura1 = "00000000000000000000000001101000") then
					dados1 <= r26;
				elsif(regLeitura1 = "00000000000000000000000001101100") then
					dados1 <= r27;
				elsif(regLeitura1 = "00000000000000000000000001110000") then
					dados1 <= r28;
				elsif(regLeitura1 = "00000000000000000000000001110100") then
					dados1 <= r29;
				elsif(regLeitura1 = "00000000000000000000000001111000") then
					dados1 <= r30;
				elsif(regLeitura1 = "00000000000000000000000001111100") then
					dados1 <= r31;
				elsif(regLeitura1 = "00000000000000000000000010000000") then
					dados1 <= r32;
				elsif(regLeitura1 = "00000000000000000000000010000100") then
					dados1 <= r33;
				end if;			
			end if;	
		end process;
END behavior;
