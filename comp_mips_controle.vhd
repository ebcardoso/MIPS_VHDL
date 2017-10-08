library ieee;
use ieee.std_logic_1164.all;

entity comp_mips_controle is
	port (
		clk      : in  STD_LOGIC;
		new_inst : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		
		allow_W_R1 : out  STD_LOGIC;
		allow_R_R1 : out  STD_LOGIC;
		allow_W_R2 : out  STD_LOGIC;
		allow_R_R2 : out  STD_LOGIC;		
		allow_W_R3 : out  STD_LOGIC;
		allow_R_R3 : out  STD_LOGIC;		
		allow_W_R4 : out  STD_LOGIC;
		allow_R_R4 : out  STD_LOGIC;
		
		allow_W_PC : out STD_LOGIC;
		
		--sinais de controle saida
		--EX
		EX_RegDst  : out STD_LOGIC;
		EX_OpALU   : out STD_LOGIC_VECTOR(1 DOWNTO 0);
		EX_OrigALU : out STD_LOGIC;
		--MEM
		MEM_Branch     : out STD_LOGIC;
		MEM_LeMem      : out STD_LOGIC;
		MEM_EscreveMem : out STD_LOGIC;
		--WB
		MEM_EscreveReg : out STD_LOGIC;
		MEM_MemparaReg : out STD_LOGIC--;
		--
		
		--next_state : out STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		--in1 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		--in2 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		--in3 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		--in4 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		--in5 : out STD_LOGIC_VECTOR(31 DOWNTO 0)
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
	process (clk)--, new_inst, inst1, inst2, inst3, inst4, inst5)
	begin
		if (clk = '1' and clk'event) then
			--next_state <= state;
			
			if 	(state = "0000") then --BI
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio
			
				allow_W_PC <= '1';
			
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_R_R1 <= '0';		
				allow_W_R2 <= '0';	
				allow_R_R2 <= '0';		
				allow_W_R3 <= '0';	
				allow_R_R3 <= '0';		
				allow_W_R4 <= '0';	
				allow_R_R4 <= '0';			
			
				state <= "0001";
			elsif (state = "0001") then --BI | DC -- pode ter conflito
				inst2 <= inst1;
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio
				
				allow_W_PC <= '1';
				state <= "0010";
			
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_R_R1 <= '1';
				allow_W_R2 <= '1';
				allow_R_R2 <= '0';
				allow_W_R3 <= '0';
				allow_R_R3 <= '0';
				allow_W_R4 <= '0';
				allow_R_R4 <= '0';
			
				if (inst1(31 DOWNTO 26) = "000000") then -- R
					if (inst2(31 DOWNTO 26) = "000000"-- A instruçao que ja estava e do Tipo R
						and (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11) or
							 inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11))) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1001";
						
					elsif (inst2(31 DOWNTO 26) = "100011"  -- A instruçao que esta e um LW
						and (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16) or
							 inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16))) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1001";
						
					end if;
				elsif (inst1(31 DOWNTO 26) = "101011") then -- SW
					if (inst2(31 DOWNTO 26) = "000000" -- A instruçao que ja estava e do tipo R
						and (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11))) then -- conflito detectado -- SW com Tipo R
								allow_W_PC <= '0';
								state <= "1001";
												
					elsif (inst2(31 DOWNTO 26) = "100011"  -- A instrucao que estava eh um LW
						and (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16))) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1001";
						
					end if;
				elsif (inst1(31 DOWNTO 26) = "100011") then --LW
					if ((inst2(31 DOWNTO 26) = "000000") -- A instruçao que ja estava e do tipo R
						and (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11))) then -- conflito detectado -- LW com Tipo R
								allow_W_PC <= '0';
								state <= "1001";
						
					elsif ((inst2(31 DOWNTO 26) = "100011")-- A instrucao que estava eh um LW
						and (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16))) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1001";
						
					end if;
				elsif (inst1(31 DOWNTO 26) = "000100") then --Branch
					if (inst2(31 DOWNTO 26) = "000000"  -- A instruçao que ja estava e do tipo R
						and (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11) or
							inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11))) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1001";
						
					elsif (inst2(31 DOWNTO 26) = "100011" -- A instruçao que esta e um LW
						and (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16) or
							inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16))) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1001";
						
					end if;
				end if;
			elsif (state = "0010") then --BI | DC | EX -- pode ter conflito
				inst3 <= inst2;
				inst2 <= inst1;
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio			
				
				allow_W_PC <= '1';
				state <= "0011";
			
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_R_R1 <= '1';
				allow_W_R2 <= '1';
				allow_R_R2 <= '1';
				allow_W_R3 <= '1';
				allow_R_R3 <= '0';
				allow_W_R4 <= '0';
				allow_R_R4 <= '0';
			
				--sinais de controla da instrucao do 3 estagio
				if (inst3(31 DOWNTO 26) = "000000")	then --R
					--EX
					EX_RegDst  <= '1';
					EX_OpALU   <= "10";
					EX_OrigALU <= '0';
				elsif (inst3(31 DOWNTO 26) = "100011") then --lw
					--EX
					EX_RegDst  <= '0';
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "101011") then --sw
					--EX
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "000100") then --beq
					--MEX
					EX_OpALU   <= "01";
					EX_OrigALU <= '0';
				end if;
						
				--transicao de estados
				if (inst1(31 DOWNTO 26) = "000000") then -- A instruçao que chegou eh do Tipo R
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do Tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					elsif (inst2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					elsif (inst3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW - Tipo R com LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					end if;
				elsif (inst1(31 DOWNTO 26) = "101011") then -- A instrucao que chegou eh um SW
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;						
					elsif (inst2(31 DOWNTO 26) = "100011") then -- A instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1100";
						end if;						
					elsif (inst3(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (inst1(31 DOWNTO 26) = "100011") then -- A instrucao que chegou eh um LW
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;						
					elsif (inst2(31 DOWNTO 26) = "100011") then -- A instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1100";
						end if;						
					elsif (inst3(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (inst1(31 DOWNTO 26) = "000100") then --a instrucao que chegou eh um branch
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado -- branch com Tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					elsif (inst2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- branch com LW
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- Branch com tipo R
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					elsif (inst3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW -- Branch com LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado
								allow_W_PC <= '0';
								state <= "1100";
						end if;
					end if;
				end if;
			elsif (state = "0011") then --BI | DC | EX | ME -- pode ter conflito
				inst4 <= inst3;
				inst3 <= inst2;
				inst2 <= inst1;
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio
			
				allow_W_PC <= '1';
				state <= "0100";
						
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_R_R1 <= '1';
				allow_W_R2 <= '1';
				allow_R_R2 <= '1';
				allow_W_R3 <= '1';
				allow_R_R3 <= '1';
				allow_W_R4 <= '1';
				allow_R_R4 <= '0';
				
				--sinais de controla da instrucao do 3 estagio
				if (inst3(31 DOWNTO 26) = "000000")	then --R
					--EX
					EX_RegDst  <= '1';
					EX_OpALU   <= "10";
					EX_OrigALU <= '0';
				elsif (inst3(31 DOWNTO 26) = "100011") then --lw
					--EX
					EX_RegDst  <= '0';
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "101011") then --sw
					--EX
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "000100") then --beq
					--MEX
					EX_OpALU   <= "01";
					EX_OrigALU <= '0';
				end if;
				
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
			
				--transicao de estados
				if (inst1(31 DOWNTO 26) = "000000") then -- A instruçao que chegou eh do tipo R
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;					
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;					
					
					if (inst4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst4(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst4(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst4(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst4(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst4(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
				elsif (inst1(31 DOWNTO 26) = "101011") then --a instrucao que chegou eh um SW
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst2(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst3(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (inst4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst4(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst4(15 DOWNTO 11)) then -- conflito detectado -- SW com tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst4(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst4(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst4(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (inst1(31 DOWNTO 26) = "100011") then -- A instrucao que chegou eh um LW
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst2(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst3(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (inst4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst4(15 DOWNTO 11)) then -- conflito detectado -- SW com tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst4(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst4(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (inst1(31 DOWNTO 26) = "000100") then --a instrucao que chegou eh um branch
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (inst4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst4(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst4(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst4(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst4(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst4(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
				end if;
			elsif (state = "0100") then --BI | DC | EX | ME | W -- FULL -- pode ter conflito
				inst5 <= inst4;
				inst4 <= inst3;
				inst3 <= inst2;
				inst2 <= inst1;
				inst1 <= new_inst; -- coloca instrucao que chegou para o primeiro estagio
			
				allow_W_PC <= '1';
				state <= "0100";
			
				--controle dos buffers
				allow_W_R1 <= '1';
				allow_R_R1 <= '1';
				allow_W_R2 <= '1';
				allow_R_R2 <= '1';
				allow_W_R3 <= '1';
				allow_R_R3 <= '1';
				allow_W_R4 <= '1';
				allow_R_R4 <= '1';
			
				--sinais de controla da instrucao do 3 estagio
				if (inst3(31 DOWNTO 26) = "000000")	then --R
					--EX
					EX_RegDst  <= '1';
					EX_OpALU   <= "10";
					EX_OrigALU <= '0';
				elsif (inst3(31 DOWNTO 26) = "100011") then --lw
					--EX
					EX_RegDst  <= '0';
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "101011") then --sw
					--EX
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "000100") then --beq
					--MEX
					EX_OpALU   <= "01";
					EX_OrigALU <= '0';
				end if;
				
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
				
				--sinais de controla da instrucao do 5 estagio
				if (inst5(31 DOWNTO 26) = "000000")	then --R
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "100011") then --lw
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '1';
				elsif (inst5(31 DOWNTO 26) = "101011") then --sw
					--WB
					MEM_EscreveReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "000100") then --beq
					--WB
					MEM_EscreveReg <= '0';
				end if;
			
				if (inst1(31 DOWNTO 26) = "000000") then -- A instruçao que chegou eh do tipo R
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado - Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;					
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (inst4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst4(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst4(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst4(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst4(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst4(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (inst5(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst5(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst5(15 DOWNTO 11)) then -- conflito detectado -- Tipo R com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst5(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst5(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst5(20 DOWNTO 16)) then -- conflito detectado -- Tipo R com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
				elsif (inst1(31 DOWNTO 26) = "101011") then --a instrucao que chegou eh um SW
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst2(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst3(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (inst4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst4(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst4(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst4(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst4(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst4(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (inst5(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst5(15 DOWNTO 11) or 
						    inst1(20 DOWNTO 16) = inst5(15 DOWNTO 11)) then -- conflito detectado -- SW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst5(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst5(20 DOWNTO 16) or 
						    inst1(20 DOWNTO 16) = inst5(20 DOWNTO 16)) then -- conflito detectado -- SW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
				elsif (inst1(31 DOWNTO 26) = "100011") then -- A instrucao que chegou eh um LW
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst2(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1110";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst3(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (inst4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst4(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst4(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst4(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;
					end if;
					
					if (inst5(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst5(15 DOWNTO 11)) then -- conflito detectado -- LW com Tipo R
							allow_W_PC <= '0';
							state <= "1110";
						end if;						
					elsif (inst5(31 DOWNTO 26) = "100011") then --a instrucao que estava eh um LW
						if (inst1(25 DOWNTO 21) = inst5(20 DOWNTO 16)) then -- conflito detectado -- LW com LW
							allow_W_PC <= '0';
							state <= "1100";
						end if;					end if;
				elsif (inst1(31 DOWNTO 26) = "000100") then --a instrucao que chegou eh um branch
					if (inst2(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst2(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst2(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst2(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst2(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst2(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (inst3(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do Tipo R
						if (inst1(25 DOWNTO 21) = inst3(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst3(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst3(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst3(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst3(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (inst4(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do Tipo R
						if (inst1(25 DOWNTO 21) = inst4(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst4(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst4(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst4(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst4(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					end if;
					
					if (inst5(31 DOWNTO 26) = "000000") then -- A instruçao que ja estava e do tipo R
						if (inst1(25 DOWNTO 21) = inst5(15 DOWNTO 11)) or
							(inst1(20 DOWNTO 16) = inst5(15 DOWNTO 11)) then -- conflito detectado -- Branch com Tipo R
								allow_W_PC <= '0';
								state <= "1110";
						end if;
					elsif (inst5(31 DOWNTO 26) = "100011") then -- A instruçao que esta e um LW
						if (inst1(25 DOWNTO 21) = inst5(20 DOWNTO 16)) or
							(inst1(20 DOWNTO 16) = inst5(20 DOWNTO 16)) then -- conflito detectado -- Branch com LW
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
				allow_R_R1 <= '1';
				allow_W_R2 <= '1';
				allow_R_R2 <= '1';
				allow_W_R3 <= '1';
				allow_R_R3 <= '1';
				allow_W_R4 <= '1';
				allow_R_R4 <= '1';
				
				--sinais de controla da instrucao do 3 estagio
				if (inst3(31 DOWNTO 26) = "000000")	then --R
					--EX
					EX_RegDst  <= '1';
					EX_OpALU   <= "10";
					EX_OrigALU <= '0';
				elsif (inst3(31 DOWNTO 26) = "100011") then --lw
					--EX
					EX_RegDst  <= '0';
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "101011") then --sw
					--EX
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "000100") then --beq
					--MEX
					EX_OpALU   <= "01";
					EX_OrigALU <= '0';
				end if;
				
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
				
				--sinais de controla da instrucao do 5 estagio
				if (inst5(31 DOWNTO 26) = "000000")	then --R
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "100011") then --lw
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '1';
				elsif (inst5(31 DOWNTO 26) = "101011") then --sw
					--WB
					MEM_EscreveReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "000100") then --beq
					--WB
					MEM_EscreveReg <= '0';
				end if;

				allow_W_PC <= '0';
				state <= "0110";
			elsif (state = "0110") then --EX | ME | W
				inst5 <= inst4;
				inst4 <= inst3;
				inst3 <= inst2;
			
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';
				allow_W_R2 <= '0';
				allow_R_R2 <= '1';
				allow_W_R3 <= '1';
				allow_R_R3 <= '1';
				allow_W_R4 <= '1';
				allow_R_R4 <= '1';
				
				--sinais de controla da instrucao do 3 estagio
				if (inst3(31 DOWNTO 26) = "000000")	then --R
					--EX
					EX_RegDst  <= '1';
					EX_OpALU   <= "10";
					EX_OrigALU <= '0';
				elsif (inst3(31 DOWNTO 26) = "100011") then --lw
					--EX
					EX_RegDst  <= '0';
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "101011") then --sw
					--EX
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "000100") then --beq
					--MEX
					EX_OpALU   <= "01";
					EX_OrigALU <= '0';
				end if;
				
				
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
				
				--sinais de controla da instrucao do 5 estagio
				if (inst5(31 DOWNTO 26) = "000000")	then --R
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "100011") then --lw
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '1';
				elsif (inst5(31 DOWNTO 26) = "101011") then --sw
					--WB
					MEM_EscreveReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "000100") then --beq
					--WB
					MEM_EscreveReg <= '0';
				end if;

				allow_W_PC <= '0';
				state <= "0111";
			elsif (state = "0111") then --ME | W
				inst5 <= inst4;
				inst4 <= inst3;
			
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';
				allow_W_R2 <= '0';
				allow_R_R2 <= '0';
				allow_W_R3 <= '0';
				allow_R_R3 <= '1';
				allow_W_R4 <= '1';
				allow_R_R4 <= '1';
				
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
				
				--sinais de controla da instrucao do 5 estagio
				if (inst5(31 DOWNTO 26) = "000000")	then --R
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "100011") then --lw
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '1';
				elsif (inst5(31 DOWNTO 26) = "101011") then --sw
					--WB
					MEM_EscreveReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "000100") then --beq
					--WB
					MEM_EscreveReg <= '0';
				end if;

				allow_W_PC <= '0';
				state <= "1000";
			elsif (state = "1000") then --W -- END
				inst5 <= inst4;
			
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';
				allow_W_R2 <= '0';
				allow_R_R2 <= '0';
				allow_W_R3 <= '0';
				allow_R_R3 <= '0';
				allow_W_R4 <= '0';
				allow_R_R4 <= '1';
				
				--sinais de controla da instrucao do 5 estagio
				if (inst5(31 DOWNTO 26) = "000000")	then --R
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "100011") then --lw
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '1';
				elsif (inst5(31 DOWNTO 26) = "101011") then --sw
					--WB
					MEM_EscreveReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "000100") then --beq
					--WB
					MEM_EscreveReg <= '0';
				end if;
				
				allow_W_PC <= '0';
			elsif (state = "1001") then --BI | | EX
				inst3 <= inst2;
				
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';		
				allow_W_R2 <= '0';	
				allow_R_R2 <= '1';		
				allow_W_R3 <= '1';	
				allow_R_R3 <= '0';		
				allow_W_R4 <= '0';	
				allow_R_R4 <= '0';
				
				--sinais de controla da instrucao do 3 estagio
				if (inst3(31 DOWNTO 26) = "000000")	then --R
					--EX
					EX_RegDst  <= '1';
					EX_OpALU   <= "10";
					EX_OrigALU <= '0';
				elsif (inst3(31 DOWNTO 26) = "100011") then --lw
					--EX
					EX_RegDst  <= '0';
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "101011") then --sw
					--EX
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "000100") then --beq
					--MEX
					EX_OpALU   <= "01";
					EX_OrigALU <= '0';
				end if;
				
				allow_W_PC <= '0';
				state <= "1010";
			elsif (state = "1010") then --BI | | | ME
				inst4 <= inst3;
				
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';		
				allow_W_R2 <= '0';	
				allow_R_R2 <= '0';		
				allow_W_R3 <= '0';	
				allow_R_R3 <= '1';		
				allow_W_R4 <= '1';	
				allow_R_R4 <= '0';				
								
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
				
				allow_W_PC <= '0';
				state <= "1011";
			elsif (state = "1011") then --BI | | | | W
				inst5 <= inst4;
				
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';		
				allow_W_R2 <= '0';	
				allow_R_R2 <= '0';		
				allow_W_R3 <= '0';	
				allow_R_R3 <= '0';		
				allow_W_R4 <= '0';	
				allow_R_R4 <= '1';

				--sinais de controla da instrucao do 5 estagio
				if (inst5(31 DOWNTO 26) = "000000")	then --R
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "100011") then --lw
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '1';
				elsif (inst5(31 DOWNTO 26) = "101011") then --sw
					--WB
					MEM_EscreveReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "000100") then --beq
					--WB
					MEM_EscreveReg <= '0';
				end if;
				
				allow_W_PC <= '1';
				state <= "0001";
				
				inst2 <= inst1;
			elsif (state = "1100") then --BI | | EX | ME	
				inst4 <= inst3;
				inst3 <= inst2;
				
				--controle dos buffers
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';		
				allow_W_R2 <= '0';	
				allow_R_R2 <= '1';		
				allow_W_R3 <= '1';	
				allow_R_R3 <= '1';		
				allow_W_R4 <= '1';	
				allow_R_R4 <= '0';

				--sinais de controla da instrucao do 3 estagio
				if (inst3(31 DOWNTO 26) = "000000")	then --R
					--EX
					EX_RegDst  <= '1';
					EX_OpALU   <= "10";
					EX_OrigALU <= '0';
				elsif (inst3(31 DOWNTO 26) = "100011") then --lw
					--EX
					EX_RegDst  <= '0';
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "101011") then --sw
					--EX
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "000100") then --beq
					--MEX
					EX_OpALU   <= "01";
					EX_OrigALU <= '0';
				end if;
				
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
				
				allow_W_PC <= '0';
				state <= "1101";
			elsif (state = "1101") then --BI | | | ME | W	
				inst5 <= inst4;
				inst4 <= inst3;
				
				--controle dos buffers		
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';		
				allow_W_R2 <= '0';	
				allow_R_R2 <= '0';		
				allow_W_R3 <= '0';	
				allow_R_R3 <= '1';		
				allow_W_R4 <= '1';	
				allow_R_R4 <= '1';	
				
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
				
				--sinais de controla da instrucao do 5 estagio
				if (inst5(31 DOWNTO 26) = "000000")	then --R
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "100011") then --lw
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '1';
				elsif (inst5(31 DOWNTO 26) = "101011") then --sw
					--WB
					MEM_EscreveReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "000100") then --beq
					--WB
					MEM_EscreveReg <= '0';
				end if;
				
				allow_W_PC <= '0';
				state <= "1011";
			elsif (state = "1110") then --BI | | EX | ME | W
				inst5 <= inst4;
				inst4 <= inst3;
				inst3 <= inst2;
				
				--controle dos buffers			
				allow_W_R1 <= '0';
				allow_R_R1 <= '0';		
				allow_W_R2 <= '0';	
				allow_R_R2 <= '1';		
				allow_W_R3 <= '1';	
				allow_R_R3 <= '1';		
				allow_W_R4 <= '1';	
				allow_R_R4 <= '1';	
				
				--sinais de controla da instrucao do 3 estagio
				if (inst3(31 DOWNTO 26) = "000000")	then --R
					--EX
					EX_RegDst  <= '1';
					EX_OpALU   <= "10";
					EX_OrigALU <= '0';
				elsif (inst3(31 DOWNTO 26) = "100011") then --lw
					--EX
					EX_RegDst  <= '0';
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "101011") then --sw
					--EX
					EX_OpALU   <= "00";
					EX_OrigALU <= '1';
				elsif (inst3(31 DOWNTO 26) = "000100") then --beq
					--MEX
					EX_OpALU   <= "01";
					EX_OrigALU <= '0';
				end if;
				
				--sinais de controla da instrucao do 4 estagio
				if (inst4(31 DOWNTO 26) = "000000")	then --R
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "100011") then --lw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '1';
					MEM_EscreveMem <= '0';
				elsif (inst4(31 DOWNTO 26) = "101011") then --sw
					--MEM
					MEM_Branch     <= '0';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '1';
				elsif (inst4(31 DOWNTO 26) = "000100") then --beq
					--MEM
					MEM_Branch     <= '1';
					MEM_LeMem      <= '0';
					MEM_EscreveMem <= '0';
				end if;
				
				--sinais de controla da instrucao do 5 estagio
				if (inst5(31 DOWNTO 26) = "000000")	then --R
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "100011") then --lw
					--WB
					MEM_EscreveReg <= '1';
					MEM_MemparaReg <= '1';
				elsif (inst5(31 DOWNTO 26) = "101011") then --sw
					--WB
					MEM_EscreveReg <= '0';
				elsif (inst5(31 DOWNTO 26) = "000100") then --beq
					--WB
					MEM_EscreveReg <= '0';
				end if;
			
				allow_W_PC <= '0';
				state <= "1101";
			end if;
		end if;
		
		--in1 <= inst1;
		--in2 <= inst2;
		--in3 <= inst3;
		--in4 <= inst4;
		--in5 <= inst5;
	end process;
end arc;