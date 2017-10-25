LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_registradores IS
	PORT (
		clk : IN STD_LOGIC;
		escreveReg : IN STD_LOGIC;
		
		regLeitura1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		regLeitura2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		regEscrita  : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		dadosEscrita: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		dados1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		dados2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		s1, s2, s3, s4, s5, s6, s7 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_registradores;

ARCHITECTURE behavior OF comp_registradores IS
																									
	signal r0  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000001001101";
	signal r2  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r3  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r4  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000011001";
	signal r5  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000001000";
	signal r6  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000001010";
	signal r7  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r8  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r9  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000001100";
	signal r10 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r11 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000001100";
	signal r12 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r13 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r14 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r15 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r16 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000001110001111111";
	signal r17 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000001111110001111";
	signal r18 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r19 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r20 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000001001";
	signal r21 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r22 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r23 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000010000";
	signal r24 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r25 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r26 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r27 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000010011";
	signal r28 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000110010";
	signal r29 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000101011";
	signal r30 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000101000";
	signal r31 : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000001110111";

BEGIN
		process(clk)
		begin		
			if (clk = '0' and clk'event) then
				   if(regLeitura1 = "00000") then
					dados1 <= r0;
				elsif(regLeitura1 = "00001") then
					dados1 <= r1;
				elsif(regLeitura1 = "00010") then
					dados1 <= r2;
				elsif(regLeitura1 = "00011") then
					dados1 <= r3;
				elsif(regLeitura1 = "00100") then
					dados1 <= r4;
				elsif(regLeitura1 = "00101") then
					dados1 <= r5;
				elsif(regLeitura1 = "00110") then
					dados1 <= r6;
				elsif(regLeitura1 = "00111") then
					dados1 <= r7;
				elsif(regLeitura1 = "01000") then
					dados1 <= r8;
				elsif(regLeitura1 = "01001") then
					dados1 <= r9;
				elsif(regLeitura1 = "01010") then
					dados1 <= r10;
				elsif(regLeitura1 = "01011") then
					dados1 <= r11;
				elsif(regLeitura1 = "01100") then
					dados1 <= r12;
				elsif(regLeitura1 = "01101") then
					dados1 <= r13;
				elsif(regLeitura1 = "01110") then
					dados1 <= r14;
				elsif(regLeitura1 = "01111") then
					dados1 <= r15;
				elsif(regLeitura1 = "10000") then
					dados1 <= r16;
				elsif(regLeitura1 = "10001") then
					dados1 <= r17;
				elsif(regLeitura1 = "10010") then
					dados1 <= r18;
				elsif(regLeitura1 = "10011") then
					dados1 <= r19;
				elsif(regLeitura1 = "10100") then
					dados1 <= r20;
				elsif(regLeitura1 = "10101") then
					dados1 <= r21;
				elsif(regLeitura1 = "10110") then
					dados1 <= r22;
				elsif(regLeitura1 = "10111") then
					dados1 <= r23;
				elsif(regLeitura1 = "11000") then
					dados1 <= r24;
				elsif(regLeitura1 = "11001") then
					dados1 <= r25;
				elsif(regLeitura1 = "11010") then
					dados1 <= r26;
				elsif(regLeitura1 = "11011") then
					dados1 <= r27;
				elsif(regLeitura1 = "11100") then
					dados1 <= r28;
				elsif(regLeitura1 = "11101") then
					dados1 <= r29;
				elsif(regLeitura1 = "11110") then
					dados1 <= r30;
				elsif(regLeitura1 = "11111") then
					dados1 <= r31;
				end if;
				
				   if(regLeitura2 = "00000") then
					dados2 <= r0;
				elsif(regLeitura2 = "00001") then
					dados2 <= r1;
				elsif(regLeitura2 = "00010") then
					dados2 <= r2;
				elsif(regLeitura2 = "00011") then
					dados2 <= r3;
				elsif(regLeitura2 = "00100") then
					dados2 <= r4;
				elsif(regLeitura2 = "00101") then
					dados2 <= r5;
				elsif(regLeitura2 = "00110") then
					dados2 <= r6;
				elsif(regLeitura2 = "00111") then
					dados2 <= r7;
				elsif(regLeitura2 = "01000") then
					dados2 <= r8;
				elsif(regLeitura2 = "01001") then
					dados2 <= r9;
				elsif(regLeitura2 = "01010") then
					dados2 <= r10;
				elsif(regLeitura2 = "01011") then
					dados2 <= r11;
				elsif(regLeitura2 = "01100") then
					dados2 <= r12;
				elsif(regLeitura2 = "01101") then
					dados2 <= r13;
				elsif(regLeitura2 = "01110") then
					dados2 <= r14;
				elsif(regLeitura2 = "01111") then
					dados2 <= r15;
				elsif(regLeitura2 = "10000") then
					dados2 <= r16;
				elsif(regLeitura2 = "10001") then
					dados2 <= r17;
				elsif(regLeitura2 = "10010") then
					dados2 <= r18;
				elsif(regLeitura2 = "10011") then
					dados2 <= r19;
				elsif(regLeitura2 = "10100") then
					dados2 <= r20;
				elsif(regLeitura2 = "10101") then
					dados2 <= r21;
				elsif(regLeitura2 = "10110") then
					dados2 <= r22;
				elsif(regLeitura2 = "10111") then
					dados2 <= r23;
				elsif(regLeitura2 = "11000") then
					dados2 <= r24;
				elsif(regLeitura2 = "11001") then
					dados2 <= r25;
				elsif(regLeitura2 = "11010") then
					dados2 <= r26;
				elsif(regLeitura2 = "11011") then
					dados2 <= r27;
				elsif(regLeitura2 = "11100") then
					dados2 <= r28;
				elsif(regLeitura2 = "11101") then
					dados2 <= r29;
				elsif(regLeitura2 = "11110") then
					dados2 <= r30;
				elsif(regLeitura2 = "11111") then
					dados2 <= r31;
				end if;
			end if;
			
			if (clk = '1' and clk'event) then
				if (escreveReg = '1') then
					if(regEscrita = "00000") then
						r0 <= dadosEscrita;
					elsif(regEscrita = "00001") then
						r1 <= dadosEscrita;
					elsif(regEscrita = "00010") then
						r2 <= dadosEscrita;
					elsif(regEscrita = "00011") then
						r3 <= dadosEscrita;
					elsif(regEscrita = "00100") then
						r4 <= dadosEscrita;
					elsif(regEscrita = "00101") then
						r5 <= dadosEscrita;
					elsif(regEscrita = "00110") then
						r6 <= dadosEscrita;
					elsif(regEscrita = "00111") then
						r7 <= dadosEscrita;
					elsif(regEscrita = "01000") then
						r8 <= dadosEscrita;
					elsif(regEscrita = "01001") then
						r9 <= dadosEscrita;
					elsif(regEscrita = "01010") then
						r10 <= dadosEscrita;
					elsif(regEscrita = "01011") then
						r11 <= dadosEscrita;
					elsif(regEscrita = "01100") then
						r12 <= dadosEscrita;
					elsif(regEscrita = "01101") then
						r13 <= dadosEscrita;
					elsif(regEscrita = "01110") then
						r14 <= dadosEscrita;
					elsif(regEscrita = "01111") then
						r15 <= dadosEscrita;
					elsif(regEscrita = "10000") then
						r16 <= dadosEscrita;
					elsif(regEscrita = "10001") then
						r17 <= dadosEscrita;
					elsif(regEscrita = "10010") then
						r18 <= dadosEscrita;
					elsif(regEscrita = "10011") then
						r19 <= dadosEscrita;
					elsif(regEscrita = "10100") then
						r20 <= dadosEscrita;
					elsif(regEscrita = "10101") then
						r21 <= dadosEscrita;
					elsif(regEscrita = "10110") then
						r22 <= dadosEscrita;
					elsif(regEscrita = "10111") then
						r23 <= dadosEscrita;
					elsif(regEscrita = "11000") then
						r24 <= dadosEscrita;
					elsif(regEscrita = "11001") then
						r25 <= dadosEscrita;
					elsif(regEscrita = "11010") then
						r26 <= dadosEscrita;
					elsif(regEscrita = "11011") then
						r27 <= dadosEscrita;
					elsif(regEscrita = "11100") then
						r28 <= dadosEscrita;
					elsif(regEscrita = "11101") then
						r29 <= dadosEscrita;
					elsif(regEscrita = "11110") then
						r30 <= dadosEscrita;
					elsif(regEscrita = "11111") then
						r31 <= dadosEscrita;
					end if;
				end if;
			end if;
			
			s1 <= r24;
			s2 <= r18;
			s3 <= r2;
			s4 <= r14;
			s5 <= r1;
			s6 <= r0;
			s7 <= r19;
		end process;
END behavior;
