LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comp_ULA_Controle IS
	PORT (
		opALU : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		
		out0  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END comp_ULA_Controle;

ARCHITECTURE behavior OF comp_ULA_Controle IS
BEGIN

	PROCESS (opALU, funct)
	BEGIN
		if (opALU = "00") then -- lw sw
			out0 <= "0010";
		elsif (opALU = "01") then --beq
			out0 <= "0110";
		elsif (opALU = "10") then --R
			if (funct = "100000") then --add -- livro
				out0 <= "0010";
			elsif (funct = "100001") then --addi
				out0 <= "0010";
			elsif (funct = "100010") then --sub -- livro
				out0 <= "0110";
			elsif (funct = "100011") then --subi
				out0 <= "0110";
			elsif (funct = "100100") then --and -- livro
				out0 <= "0000";
			elsif (funct = "100101") then --or -- livro
				out0 <= "0001";
			elsif (funct = "100110") then --andi
				out0 <= "0000";
			elsif (funct = "100111") then --ori
				out0 <= "0001";
			elsif (funct = "101000") then --sll
				out0 <= "1110";
			elsif (funct = "101001") then --srl
				out0 <= "1111";
			elsif (funct = "101010") then --slt -- livro
				out0 <= "0111";
			elsif (funct = "101011") then --slti
				out0 <= "0111";
			elsif (funct = "101100") then
			elsif (funct = "101101") then
			elsif (funct = "101110") then
			elsif (funct = "101111") then
			end if;
		end if;
	END PROCESS;

END behavior;
