library ieee;
use ieee.std_logic_1164.all;

entity comp_mips_controle is
	port (
		clk      : in STD_LOGIC;
		new_inst : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		allow_W_R1 : out STD_LOGIC;
		allow_R_R1 : out STD_LOGIC;
		allow_W_R2 : out STD_LOGIC;
		allow_R_R2 : out STD_LOGIC;		
		allow_W_R3 : out STD_LOGIC;
		allow_R_R3 : out STD_LOGIC;		
		allow_W_R4 : out STD_LOGIC;
		allow_R_R4 : out STD_LOGIC;
		
		allow_W_PC : out STD_LOGIC;
		
		next_state : out STD_LOGIC_VECTOR(3 DOWNTO 0)
		
--		in1 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
--		in2 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
--		in3 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
--		in4 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
--		in5 : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end comp_mips_controle;

architecture arc of comp_mips_controle is
	signal inst1 : STD_LOGIC_VECTOR(31 DOWNTO 0); --instrucao no estagio busca
	signal inst2 : STD_LOGIC_VECTOR(31 DOWNTO 0); --instrucao no estagio de decodificacao
	signal inst3 : STD_LOGIC_VECTOR(31 DOWNTO 0); --instrucao no estagio de execucao
	signal inst4 : STD_LOGIC_VECTOR(31 DOWNTO 0); --instrucao no estagio de acesso a memoria
	signal inst5 : STD_LOGIC_VECTOR(31 DOWNTO 0); --instrucao no estagio de escrita
	
	signal state : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
begin
	process (clk)
		variable i1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
		variable i2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
		variable i3 : STD_LOGIC_VECTOR(31 DOWNTO 0);
		variable i4 : STD_LOGIC_VECTOR(31 DOWNTO 0);
		variable i5 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	begin
		if (clk = '0' and clk'event) then
			next_state <= state;
			
			if 	(state = "0000") then --BI
				--controle dos buffers
				allow_R_R1 <= '0';	
				allow_R_R2 <= '0';	
				allow_R_R3 <= '0';	
				allow_R_R4 <= '0';	
			elsif (state = "0001") then --BI | DC -- pode ter conflito	
				--controle dos buffers
				allow_R_R1 <= '1';
				allow_R_R2 <= '0';
				allow_R_R3 <= '0';
				allow_R_R4 <= '0';
			elsif (state = "0010") then --BI | DC | EX -- pode ter conflito
				--controle dos buffers
				allow_R_R1 <= '1';
				allow_R_R2 <= '1';
				allow_R_R3 <= '0';
				allow_R_R4 <= '0';
			elsif (state = "0011") then --BI | DC | EX | ME -- pode ter conflito
				--controle dos buffers
				allow_R_R1 <= '1';
				allow_R_R2 <= '1';
				allow_R_R3 <= '1';
				allow_R_R4 <= '0';				
			elsif (state = "0100") then --BI | DC | EX | ME | W -- FULL -- pode ter conflito
				--controle dos buffers
				allow_R_R1 <= '1';
				allow_R_R2 <= '1';
				allow_R_R3 <= '1';
				allow_R_R4 <= '1';
			elsif (state = "0101") then --DC | EX | ME | W
				--controle dos buffers
				allow_R_R1 <= '1';
				allow_R_R2 <= '1';
				allow_R_R3 <= '1';
				allow_R_R4 <= '1';
			elsif (state = "0110") then --EX | ME | W
				--controle dos buffers
				allow_R_R1 <= '0';
				allow_R_R2 <= '1';
				allow_R_R3 <= '1';
				allow_R_R4 <= '1';
			elsif (state = "0111") then --ME | W
				--controle dos buffers
				allow_R_R1 <= '0';
				allow_R_R2 <= '0';
				allow_R_R3 <= '1';
				allow_R_R4 <= '1';
			elsif (state = "1000") then --W -- END
				--controle dos buffers
				allow_R_R1 <= '0';
				allow_R_R2 <= '0';
				allow_R_R3 <= '0';
				allow_R_R4 <= '1';
			elsif (state = "1001") then --BI | | EX
				--controle dos buffers
				allow_R_R1 <= '0';	
				allow_R_R2 <= '1';	
				allow_R_R3 <= '0';	
				allow_R_R4 <= '0';
			elsif (state = "1010") then --BI | | | ME
				--controle dos buffers
				allow_R_R1 <= '0';	
				allow_R_R2 <= '0';	
				allow_R_R3 <= '1';	
				allow_R_R4 <= '0';
			elsif (state = "1011") then --BI | | | | W
				--controle dos buffers
				allow_R_R1 <= '0';		
				allow_R_R2 <= '0';	
				allow_R_R3 <= '0';	
				allow_R_R4 <= '1';
			elsif (state = "1100") then --BI | | EX | ME	
				--controle dos buffers
				allow_R_R1 <= '0';	
				allow_R_R2 <= '1';		
				allow_R_R3 <= '1';		
				allow_R_R4 <= '0';
			elsif (state = "1101") then --BI | | | ME | W	
				--controle dos buffers	
				allow_R_R1 <= '0';	
				allow_R_R2 <= '0';		
				allow_R_R3 <= '1';	
				allow_R_R4 <= '1';
			elsif (state = "1110") then --BI | | EX | ME | W
				--controle dos buffers
				allow_R_R1 <= '0';	
				allow_R_R2 <= '1';	
				allow_R_R3 <= '1';	
				allow_R_R4 <= '1';
			end if;
		end if;
	
		if (clk = '1' and clk'event) then			
			if 	(state = "0000") then --BI
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio
			
				allow_W_PC <= '1';
			
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_W_R2 <= '0';		
				allow_W_R3 <= '0';		
				allow_W_R4 <= '0';			

				state <= "0001";
			elsif (state = "0001") then --BI | DC -- pode ter conflito			
				i2 := inst1;
				i1 := new_inst;
				
				inst2 <= inst1;
				inst1 <= new_inst;
				
				allow_W_PC <= '1';
				state <= "0010";
			
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_W_R2 <= '1';
				allow_W_R3 <= '0';
				allow_W_R4 <= '0';
			
				if (i1(31 DOWNTO 26) = "000000") then -- R
					if (i2(31 DOWNTO 26) = "000000"-- A instruçao que ja estava e do Tipo R
						and (i1(25 DOWNTO 21) = i2(15 DOWNTO 11) or
							 i1(20 DOWNTO 16) = i2(15 DOWNTO 11))) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1001";						
					elsif (i2(31 DOWNTO 26) = "100011"  -- A instruçao que esta e um LW
						and (i1(25 DOWNTO 21) = i2(20 DOWNTO 16) or
							 i1(20 DOWNTO 16) = i2(20 DOWNTO 16))) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1001";						
					end if;
				elsif (i1(31 DOWNTO 26) = "101011") then -- SW
					if (i2(31 DOWNTO 26) = "000000" -- A instruçao que ja estava e do tipo R
						and (i1(25 DOWNTO 21) = i2(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i2(15 DOWNTO 11))) then -- conflito detectado -- SW com Tipo R
								allow_W_PC <= '0';
								state <= "1001";												
					elsif (i2(31 DOWNTO 26) = "100011"  -- A instrucao que estava eh um LW
						and (i1(25 DOWNTO 21) = i2(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i2(20 DOWNTO 16))) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1001";						
					end if;
				elsif (i1(31 DOWNTO 26) = "100011") then --LW
					if ((i2(31 DOWNTO 26) = "000000") -- A instruçao que ja estava e do tipo R
						and (i1(25 DOWNTO 21) = i2(15 DOWNTO 11))) then -- conflito detectado -- LW com Tipo R
								allow_W_PC <= '0';
								state <= "1001";						
					elsif ((i2(31 DOWNTO 26) = "100011")-- A instrucao que estava eh um LW
						and (i1(25 DOWNTO 21) = i2(20 DOWNTO 16))) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1001";						
					end if;
				elsif (i1(31 DOWNTO 26) = "000100") then --Branch
					if (i2(31 DOWNTO 26) = "000000"  -- A instruçao que ja estava e do tipo R
						and (i1(25 DOWNTO 21) = i2(15 DOWNTO 11) or
							i1(20 DOWNTO 16) = i2(15 DOWNTO 11))) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1001";						
					elsif (i2(31 DOWNTO 26) = "100011" -- A instruçao que esta e um LW
						and (i1(25 DOWNTO 21) = i2(20 DOWNTO 16) or
							i1(20 DOWNTO 16) = i2(20 DOWNTO 16))) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1001";						
					end if;
				end if;
			elsif (state = "0010") then --BI | DC | EX -- pode ter conflito
				i3 := inst2;
				i2 := inst1;
				i1 := new_inst;
				
				inst3 <= inst2;
				inst2 <= inst1;
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio			
				
				allow_W_PC <= '1';
				state <= "0011";
			
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_W_R2 <= '1';
				allow_W_R3 <= '1';
				allow_W_R4 <= '0';
						
				--transicao de estados
				if (i1(31 DOWNTO 26) = "000000") then -- A instruçao que chegou eh do Tipo R
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do Tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					elsif (i2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					elsif (i3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW - Tipo R com LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "101011") then -- A irucao que chegou eh um SW
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;						
					elsif (i2(31 DOWNTO 26) = "100011") then -- A irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1100";
						end if;						
					elsif (i3(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "100011") then -- A irucao que chegou eh um LW
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;						
					elsif (i2(31 DOWNTO 26) = "100011") then -- A irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1100";
						end if;						
					elsif (i3(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "000100") then --a irucao que chegou eh um branch
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado -- branch com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					elsif (i2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- branch com LW
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- Branch com tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					elsif (i3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW -- Branch com LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					end if;
				end if;
			elsif (state = "0011") then --BI | DC | EX | ME -- pode ter conflito
				i4 := inst3;
				i3 := inst2;
				i2 := inst1;
				i1 := new_inst;
				
				inst4 <= inst3;
				inst3 <= inst2;
				inst2 <= inst1;
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio
			
				allow_W_PC <= '1';
				state <= "0100";
						
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_W_R2 <= '1';
				allow_W_R3 <= '1';
				allow_W_R4 <= '1';
			
				--transicao de estados
				if (i1(31 DOWNTO 26) = "000000") then -- A instruçao que chegou eh do tipo R
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;					
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;					
					
					if (i4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i4(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i4(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i4(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i4(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i4(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "101011") then --a irucao que chegou eh um SW
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i2(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i3(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (i4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i4(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i4(15 DOWNTO 11)) then -- conflito detectado -- SW com tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i4(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i4(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i4(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "100011") then -- A irucao que chegou eh um LW
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i2(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i3(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (i4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i4(15 DOWNTO 11)) then -- conflito detectado -- SW com tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i4(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i4(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "000100") then --a irucao que chegou eh um branch
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (i4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i4(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i4(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i4(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i4(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i4(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
				end if;
			elsif (state = "0100") then --BI | DC | EX | ME | W -- FULL -- pode ter conflito
				i5 := inst4;
				i4 := inst3;
				i3 := inst2;
				i2 := inst1;
				i1 := new_inst;
				
				inst5 <= inst4;
				inst4 <= inst3;
				inst3 <= inst2;
				inst2 <= inst1;
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio
			
				allow_W_PC <= '1';
				state <= "0100";
			
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_W_R2 <= '1';
				allow_W_R3 <= '1';
				allow_W_R4 <= '1';
			
				if (i1(31 DOWNTO 26) = "000000") then -- A instruçao que chegou eh do tipo R
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado - Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;					
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (i4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i4(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i4(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i4(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i4(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i4(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "101011") then --a irucao que chegou eh um SW
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i2(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i3(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (i4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i4(15 DOWNTO 11) or 
						    i1(20 DOWNTO 16) = i4(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i4(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i4(20 DOWNTO 16) or 
						    i1(20 DOWNTO 16) = i4(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "100011") then -- A irucao que chegou eh um LW
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i2(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i3(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (i4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i4(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (i4(31 DOWNTO 26) = "100011") then --a irucao que estava eh um LW
						if (i1(25 DOWNTO 21) = i4(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (i1(31 DOWNTO 26) = "000100") then --a irucao que chegou eh um branch
					if (i2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (i1(25 DOWNTO 21) = i2(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i2(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i2(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i2(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (i3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do Tipo R
						if (i1(25 DOWNTO 21) = i3(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i3(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i3(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i3(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (i4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do Tipo R
						if (i1(25 DOWNTO 21) = i4(15 DOWNTO 11)) or
							(i1(20 DOWNTO 16) = i4(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (i4(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (i1(25 DOWNTO 21) = i4(20 DOWNTO 16)) or
							(i1(20 DOWNTO 16) = i4(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
				end if;
			elsif (state = "0101") then --DC | EX | ME | W
				inst5 <= inst4;
				inst4 <= inst3;
				inst3 <= inst2;
				inst2 <= inst1;
			
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_W_R2 <= '1';
				allow_W_R3 <= '1';
				allow_W_R4 <= '1';

				allow_W_PC <= '0';
				state <= "0110";
			elsif (state = "0110") then --EX | ME | W
				inst5 <= inst4;
				inst4 <= inst3;
				inst3 <= inst2;
			
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_W_R2 <= '0';
				allow_W_R3 <= '1';
				allow_W_R4 <= '1';

				allow_W_PC <= '0';
				state <= "0111";
			elsif (state = "0111") then --ME | W
				inst5 <= inst4;
				inst4 <= inst3;
			
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_W_R2 <= '0';
				allow_W_R3 <= '0';
				allow_W_R4 <= '1';

				allow_W_PC <= '0';
				state <= "1000";
			elsif (state = "1000") then --W -- END
				inst5 <= inst4;
			
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_W_R2 <= '0';
				allow_W_R3 <= '0';
				allow_W_R4 <= '0';
				
				allow_W_PC <= '0';
			elsif (state = "1001") then --BI | | EX
				inst3 <= inst2;
				
				--controle dos buffers
				allow_W_R1 <= '0';		
				allow_W_R2 <= '0';		
				allow_W_R3 <= '1';		
				allow_W_R4 <= '0';
				
				allow_W_PC <= '0';
				state <= "1010";
			elsif (state = "1010") then --BI | | | ME
				inst4 <= inst3;
				
				--controle dos buffers
				allow_W_R1 <= '0';		
				allow_W_R2 <= '0';		
				allow_W_R3 <= '0';		
				allow_W_R4 <= '1';
				
				allow_W_PC <= '0';
				state <= "1011";
			elsif (state = "1011") then --BI | | | | W
				inst5 <= inst4;
				
				--controle dos buffers
				allow_W_R1 <= '0';		
				allow_W_R2 <= '0';		
				allow_W_R3 <= '0';		
				allow_W_R4 <= '0';
				
				allow_W_PC <= '1';
				state <= "0001";
				
				inst2 <= inst1;
			elsif (state = "1100") then --BI | | EX | ME	
				inst4 <= inst3;
				inst3 <= inst2;
				
				--controle dos buffers
				allow_W_R1 <= '0';		
				allow_W_R2 <= '0';		
				allow_W_R3 <= '1';		
				allow_W_R4 <= '1';
				
				allow_W_PC <= '0';
				state <= "1101";
			elsif (state = "1101") then --BI | | | ME | W	
				inst5 <= inst4;
				inst4 <= inst3;
				
				--controle dos buffers		
				allow_W_R1 <= '0';		
				allow_W_R2 <= '0';		
				allow_W_R3 <= '0';		
				allow_W_R4 <= '1';
				
				allow_W_PC <= '0';
				state <= "1011";
			elsif (state = "1110") then --BI | | EX | ME | W
				inst5 <= inst4;
				inst4 <= inst3;
				inst3 <= inst2;
				
				--controle dos buffers			
				allow_W_R1 <= '0';		
				allow_W_R2 <= '0';		
				allow_W_R3 <= '1';		
				allow_W_R4 <= '1';
			
				allow_W_PC <= '0';
				state <= "1101";
			end if;
		end if;
		
--		in1 <= inst1;
--		in2 <= inst2;
--		in3 <= inst3;
--		in4 <= inst4;
--		in5 <= inst5;
	end process;
end arc;