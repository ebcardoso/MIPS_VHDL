LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_mem_dados IS
	PORT (
		clk : IN STD_LOGIC;
		
		leMem      : IN STD_LOGIC;
		escreveMem : IN STD_LOGIC;
		
		endereco     : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dadosEscrita : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		dadosLeitura : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_mem_dados;

ARCHITECTURE behavior OF comp_mem_dados IS

	signal r0  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r1  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r2  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r3  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r4  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r5  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r6  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r7  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r8  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r9  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r10 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r11 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r12 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r13 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r14 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r15 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r16 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r17 : STD_LOGIC_VECTOR(31 DOWNTO 0);
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
	signal r30 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal r31 : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	process(clk, leMem, escreveMem, endereco, dadosEscrita, dadosLeitura,
	        r0,  r1,  r2,  r3,  r4,  r5,  r6,  r7,  r8,  r9,
			  r10, r11, r12, r13, r14, r15, r16, r17, r18, r19,
			  r20, r21, r22, r23, r24, r25, r26, r27, r28, r29,
			  r30, r31)
		begin
		
			if (CLK = '1' and CLK'event) then
				if (leMem = '1') then
					if(endereco    = "00000000000000000000000000000000") then
						dadosLeitura <= r0;
					elsif(endereco = "00000000000000000000000000000001") then
						dadosLeitura <= r1;
					elsif(endereco = "00000000000000000000000000000010") then
						dadosLeitura <= r2;
					elsif(endereco = "00000000000000000000000000000011") then
						dadosLeitura <= r3;
					elsif(endereco = "00000000000000000000000000000100") then
						dadosLeitura <= r4;
					elsif(endereco = "00000000000000000000000000000101") then
						dadosLeitura <= r5;
					elsif(endereco = "00000000000000000000000000000110") then
						dadosLeitura <= r6;
					elsif(endereco = "00000000000000000000000000000111") then
						dadosLeitura <= r7;
					elsif(endereco = "00000000000000000000000000001000") then
						dadosLeitura <= r8;
					elsif(endereco = "00000000000000000000000000001001") then
						dadosLeitura <= r9;
					elsif(endereco = "00000000000000000000000000001010") then
						dadosLeitura <= r10;
					elsif(endereco = "00000000000000000000000000001011") then
						dadosLeitura <= r11;
					elsif(endereco = "00000000000000000000000000001100") then
						dadosLeitura <= r12;
					elsif(endereco = "00000000000000000000000000001101") then
						dadosLeitura <= r13;
					elsif(endereco = "00000000000000000000000000001110") then
						dadosLeitura <= r14;
					elsif(endereco = "00000000000000000000000000001111") then
						dadosLeitura <= r15;
					elsif(endereco = "00000000000000000000000000010000") then
						dadosLeitura <= r16;
					elsif(endereco = "00000000000000000000000000010001") then
						dadosLeitura <= r17;
					elsif(endereco = "00000000000000000000000000010010") then
						dadosLeitura <= r18;
					elsif(endereco = "00000000000000000000000000010011") then
						dadosLeitura <= r19;
					elsif(endereco = "00000000000000000000000000010100") then
						dadosLeitura <= r20;
					elsif(endereco = "00000000000000000000000000010101") then
						dadosLeitura <= r21;
					elsif(endereco = "00000000000000000000000000010110") then
						dadosLeitura <= r22;
					elsif(endereco = "00000000000000000000000000010111") then
						dadosLeitura <= r23;
					elsif(endereco = "00000000000000000000000000011000") then
						dadosLeitura <= r24;
					elsif(endereco = "00000000000000000000000000011001") then
						dadosLeitura <= r25;
					elsif(endereco = "00000000000000000000000000011010") then
						dadosLeitura <= r26;
					elsif(endereco = "00000000000000000000000000011011") then
						dadosLeitura <= r27;
					elsif(endereco = "00000000000000000000000000011100") then
						dadosLeitura <= r28;
					elsif(endereco = "00000000000000000000000000011101") then
						dadosLeitura <= r29;
					elsif(endereco = "00000000000000000000000000011110") then
						dadosLeitura <= r30;
					elsif(endereco = "00000000000000000000000000011111") then
						dadosLeitura <= r31;
					end if;
				end if;
						
				if(escreveMem = '1') then
					if(regEscrita = "00000000000000000000000000000000") then
						r0 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000000001") then
						r1 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000000010") then
						r2 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000000011") then
						r3 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000000100") then
						r4 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000000101") then
						r5 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000000110") then
						r6 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000000111") then
						r7 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000001000") then
						r8 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000001001") then
						r9 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000001010") then
						r10 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000001011") then
						r11 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000001100") then
						r12 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000001101") then
						r13 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000001110") then
						r14 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000001111") then
						r15 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000010000") then
						r16 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000010001") then
						r17 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000010010") then
						r18 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000010011") then
						r19 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000010100") then
						r20 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000010101") then
						r21 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000010110") then
						r22 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000010111") then
						r23 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000011000") then
						r24 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000011001") then
						r25 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000011010") then
						r26 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000011011") then
						r27 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000011100") then
						r28 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000011101") then
						r29 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000011110") then
						r30 <= dadosEscrita;
					elsif(regEscrita = "00000000000000000000000000011111") then
						r31 <= dadosEscrita;
					end if;
				end if;
			end if;
			
		end process;
END behavior;