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

	signal r0  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00001" & "0000000000000100"; --SW A
	signal r1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00101" & "0000000000001000"; --SW E
	signal r2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00010" & "0000000000010000"; --SW B
	signal r3  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00111" & "0000000000010100"; --SW G
	signal r4  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00110" & "0000000000001100"; --SW F
	signal r5  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "01000" & "0000000000011000"; --SW H
	signal r6  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00011" & "0000000000011100"; --SW C
	signal r7  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "00100" & "0000000000100000"; --SW D
	signal r8  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "01011" & "0000000000000100"; --LW A
	signal r9  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "01111" & "0000000000001000"; --LW E
	signal r10 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "01100" & "0000000000010000"; --LW B
	signal r11 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "10001" & "0000000000010100"; --LW G
	signal r12 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "10000" & "0000000000001100"; --LW F
	signal r13 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01011" & "01111" & "0000000000100001"; --MULT A*E
	signal r14 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "10010" & "0000000000011000"; --LW H
	signal r15 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01100" & "10001" & "0000000000100001"; --MULT B*G
	signal r16 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00001" & "0000000000000000"; --MFLO r1 (A*E)
	signal r17 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01011" & "10000" & "0000000000100001"; --MULT A*F
	signal r18 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00010" & "0000000000000000"; --MFLO r2 (B*G)
	signal r19 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "01101" & "0000000000011100"; --LW C
	signal r20 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00011" & "0000000000000000"; --MFLO r3 (A*F)
	signal r21 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01100" & "10010" & "0000000000100001"; --MULT B*H
	signal r22 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100011" & "00000" & "01110" & "0000000000100000"; -- LW D
	signal r23 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00001" & "00010" & "10101" & "00000" & "100000"; --A*E + B*G
	signal r24 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00100" & "0000000000000000"; --MFLO r4 (B*H)
	signal r25 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01101" & "01111" & "0000000000100001"; --MULT C*E
	signal r26 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01110" & "10001" & "0000000000100001"; --MULT D*G
	signal r27 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01101" & "10000" & "0000000000100001"; --MULT C*F
	signal r28 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00101" & "0000000000000000"; --MFLO r5 C*E
	signal r29 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00110" & "0000000000000000"; --MFLO r6 D*G
	signal r30 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000001" & "01110" & "10010" & "0000000000100001"; --MULT D*H
	signal r31 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "00111" & "0000000000000000"; --MFLO r7 C*F
	signal r32 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00011" & "00100" & "10110" & "00000" & "100000"; --A*F + B*H
	signal r33 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "100000" & "00000" & "01000" & "0000000000000000"; --MFLO r8 D*H
	signal r34 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00101" & "00110" & "10111" & "00000" & "100000"; --C*E + D*G
	signal r35 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "10101" & "0000000001101000"; --SW a11
	signal r36 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "10110" & "0000000001101100"; --SW a12
	signal r37 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "000000" & "00111" & "01000" & "11000" & "00000" & "100000"; --C*F + D*H
	signal r38 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "10111" & "0000000001110000"; --SW a21
	signal r39 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal r40 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "101011" & "00000" & "11000" & "0000000001110100"; --SW a22;
	signal r41 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal r42 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal r43 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	signal r44 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";

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
				elsif(regLeitura1 = "00000000000000000000000010001000") then
					dados1 <= r34;
				elsif(regLeitura1 = "00000000000000000000000010001100") then
					dados1 <= r35;
				elsif(regLeitura1 = "00000000000000000000000010010000") then
					dados1 <= r36;
				elsif(regLeitura1 = "00000000000000000000000010010100") then
					dados1 <= r37;
				elsif(regLeitura1 = "00000000000000000000000010011000") then
					dados1 <= r38;
				elsif(regLeitura1 = "00000000000000000000000010011100") then
					dados1 <= r39;
				elsif(regLeitura1 = "00000000000000000000000010100000") then
					dados1 <= r40;
				elsif(regLeitura1 = "00000000000000000000000010100100") then
					dados1 <= r41;
				elsif(regLeitura1 = "00000000000000000000000010101000") then
					dados1 <= r42;
				elsif(regLeitura1 = "00000000000000000000000010101100") then
					dados1 <= r43;
				elsif(regLeitura1 = "00000000000000000000000010110000") then
					dados1 <= r44;
				end if;		
			end if;			
		end process;
END behavior;