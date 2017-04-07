LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_mem_instrucoes IS
	PORT (
		clk: IN STD_LOGIC;
		
		endereco : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		dados : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END comp_mem_instrucoes;

ARCHITECTURE behavior OF comp_mem_instrucoes IS

	signal r0  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000011111000000";
	signal r1  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000001111100000000000011010";
	signal r2  : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000011010";
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
	process(clk, endereco,
	        r0,  r1,  r2,  r3,  r4,  r5,  r6,  r7,  r8,  r9,
			  r10, r11, r12, r13, r14, r15, r16, r17, r18, r19,
			  r20, r21, r22, r23, r24, r25, r26, r27, r28, r29,
			  r30, r31)
		begin		
			if (CLK = '1' and CLK'event) then
				if(endereco = "00000000000000000000000000000000") then
					dados <= r0;
				elsif(endereco = "00000000000000000000000000000001") then
					dados <= r1;
				elsif(endereco = "00000000000000000000000000000010") then
					dados <= r2;
				elsif(endereco = "00000000000000000000000000000011") then
					dados <= r3;
				elsif(endereco = "00000000000000000000000000000100") then
					dados <= r4;
				elsif(endereco = "00000000000000000000000000000101") then
					dados <= r5;
				elsif(endereco = "00000000000000000000000000000110") then
					dados <= r6;
				elsif(endereco = "00000000000000000000000000000111") then
					dados <= r7;
				elsif(endereco = "00000000000000000000000000001000") then
					dados <= r8;
				elsif(endereco = "00000000000000000000000000001001") then
					dados <= r9;
				elsif(endereco = "00000000000000000000000000001010") then
					dados <= r10;
				elsif(endereco = "00000000000000000000000000001011") then
					dados <= r11;
				elsif(endereco = "00000000000000000000000000001100") then
					dados <= r12;
				elsif(endereco = "00000000000000000000000000001101") then
					dados <= r13;
				elsif(endereco = "00000000000000000000000000001110") then
					dados <= r14;
				elsif(endereco = "00000000000000000000000000001111") then
					dados <= r15;
				elsif(endereco = "00000000000000000000000000010000") then
					dados <= r16;
				elsif(endereco = "00000000000000000000000000010001") then
					dados <= r17;
				elsif(endereco = "00000000000000000000000000010010") then
					dados <= r18;
				elsif(endereco = "00000000000000000000000000010011") then
					dados <= r19;
				elsif(endereco = "00000000000000000000000000010100") then
					dados <= r20;
				elsif(endereco = "00000000000000000000000000010101") then
					dados <= r21;
				elsif(endereco = "00000000000000000000000000010110") then
					dados <= r22;
				elsif(endereco = "00000000000000000000000000010111") then
					dados <= r23;
				elsif(endereco = "00000000000000000000000000011000") then
					dados <= r24;
				elsif(endereco = "00000000000000000000000000011001") then
					dados <= r25;
				elsif(endereco = "00000000000000000000000000011010") then
					dados <= r26;
				elsif(endereco = "00000000000000000000000000011011") then
					dados <= r27;
				elsif(endereco = "00000000000000000000000000011100") then
					dados <= r28;
				elsif(endereco = "00000000000000000000000000011101") then
					dados <= r29;
				elsif(endereco = "00000000000000000000000000011110") then
					dados <= r30;
				elsif(endereco = "00000000000000000000000000011111") then
					dados <= r31;
				end if;
			end if;			
		end process;
END behavior;