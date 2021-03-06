library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controleMIPS is
	port (
			clk				: in std_logic;
			codop				: in std_logic_vector(5 downto 0);
			opALU				: out std_logic_vector (1 downto 0);
			orgAALU			: out std_logic;
			orgBALU			: out std_logic_vector (1 downto 0);
			readBREG			: out std_logic;
			writeBREG		: out std_logic;
			regDst			: out std_logic;
			Mem2Reg			: out std_logic;
			readMem			: out std_logic;
			writeMem			: out std_logic;
			iorD				: out std_logic;
			escreveIR		: out std_logic;
			orgPC				: out std_logic_vector (1 downto 0); 
			escrevePC		: out std_logic;
			escrevePCCond	: out std_logic;
			escrevePCCondN : out std_logic;
			cntrEnd			: out std_logic_vector (1 downto 0);
			regEstado		: out std_logic_vector(3 downto 0));
end controleMIPS;

architecture behavior of controleMIPS is
signal estado 				: std_logic_vector(3 downto 0);
signal cntrEnd_signal	: std_logic_vector (1 downto 0) := "00";
signal saidaMUX 			: std_logic_vector(3 downto 0);
signal saidaROM1 			: std_logic_vector(3 downto 0);
signal saidaROM2 			: std_logic_vector(3 downto 0);
begin
	mem_microprog_behavior : process (estado, cntrEnd_signal) is
	begin
		cntrEnd 	 <= cntrEnd_signal;
		regEstado <= estado;
		
		-- Implementacao do microprograma
		case estado is
			-- Se for o estado 0, onde ocorre o fetch
			when "0000" =>
				--  A ula realiza a operacao Add
				opALU <= "00";
				-- Usa PC como a primeira entrada da ula
				orgAALU <= '0';				
				-- Usa 4 como a segunda entrada da ula
				orgBALU <= "01";
				
				readBREG	<= '0';
				writeBREG 	<= '0';
				regDst		<= '0';
				Mem2Reg		<= '0';
				readMem		<= '0';
				writeMem	<= '0';
				
				-- Le a memoria usando PC como endereco e escreve resultado no IR (e automaticamente no MDR)
				-- readMem <= '1';
				iorD <= '0';
				escreveIR <= '1';
				-- Escreve saida da ula no PC
				orgPC <= "00";
				escrevePC <= '1';
				
				escrevePCCond	<= '0';
				escrevePCCondN	<= '0';
				
				-- Escolhe a proxima microinstrucao sequencialmente
				cntrEnd_signal <= "11";
					
			-- Se for o estado 1, onde ocorre o decode
			when "0001" => 
				--  A ula realiza a operacao Add
				opALU <= "00";
				-- Usa PC como a primeira entrada da ula
				orgAALU <= '0';
				-- Usa o imediate extendido e deslocado 2 bits como a segunda entrada da ula
				orgBALU <= "11";
				-- Le os registradores AUTOMATICAMENTE indicados por rs e rt e os coloca nos registradores A e B
				readBREG <= '1';
				
				writeBREG 	<= '0';
				regDst		<= '0';
				Mem2Reg		<= '0';
				readMem		<= '0';
				writeMem	<= '0';
				iorD <= '0';
				escreveIR <= '0';
				orgPC <= "00";
				escrevePC <= '0';				
				escrevePCCond	<= '0';
				escrevePCCondN	<= '0';
				
				-- Despacha usando a ROM 1
				cntrEnd_signal <= "01";
				
			-- execute das instrucoes lw, sw e addi
				
			-- Se for o estado 2, onde ocorre o calculo do endereco para realizar a instrucao lw, sw ou addi
			when "0010" =>
				--  A ula realiza a operacao Add
				opALU <= "00";
				-- Usa o registrador A para ser a primeira entrada da ula
				orgAALU <= '1';
				-- Usa o imediate extendido como a segunda entrada da ula
				orgBALU <= "10";
				
				readBREG <= '0';				
				writeBREG 		<= '0';
				regDst		<= '0';
				Mem2Reg		<= '0';
				readMem		<= '0';
				writeMem	<= '0';
				iorD <= '0';
				escreveIR <= '0';
				orgPC <= "00";
				escrevePC <= '0';				
				escrevePCCond	<= '0';
				escrevePCCondN	<= '0';
				
				-- Despacha usando a ROM 2
				cntrEnd_signal <= "10";
				
			-- Se for o estado 3, onde ocorre o acesso a memoria da instrucao lw
			when "0011" =>
			
				opALU <= "00";
				readBREG <= '0';				
				writeBREG 		<= '0';
				regDst		<= '0';
				Mem2Reg		<= '0';
			
				-- Le a memoria usando o conteudo do registrador SaidaALU como endereco. Escreve resultado no MDR automaticamente
				readMem <= '1';
				
				writeMem	<= '0';
				
				iorD <= '1'; 
				
				escreveIR <= '0';
				orgPC <= "00";
				escrevePC <= '0';				
				escrevePCCond	<= '0';
				escrevePCCondN	<= '0';
				
				-- Escolhe a proxima microinstrucao sequencialmente
				cntrEnd_signal <= "11";
					
			-- Se for o estado 4, onde ocorre a conclusao da instrucao lw
			when "0100" =>
				
				opALU <= "00";
				readBREG <= '0';
			
				-- Escreve o conteudo em MDR no registrador indicado por rt
				writeBREG <= '1';
				regDst <= '0';
				Mem2Reg <= '1';
				
				readMem <= '0';				
				writeMem	<= '0';				
				iorD <= '0'; 				
				escreveIR <= '0';
				orgPC <= "00";
				escrevePC <= '0';				
				escrevePCCond	<= '0';
				escrevePCCondN	<= '0';
				
				-- Vai para a microinstrucao fetch para iniciar uma nova instrucao
				cntrEnd_signal <= "00";
					
			-- Se for o estado 5, onde ocorre o acesso a memoria da instrucao sw
			when "0101" =>
			
				opALU <= "00";
				readBREG <= '0';
				writeBREG <= '0';
				regDst <= '0';
				Mem2Reg <= '0';
				
				readMem <= '0';
				
				-- Escreve o conteudo do registrador B no endereco indicado pelo registrador SaidaALU
				writeMem <= '1';
				iorD <= '1';
				
				escreveIR <= '0';
				orgPC <= "00";
				escrevePC <= '0';				
				escrevePCCond	<= '0';
				escrevePCCondN	<= '0';
				
				-- Vai para a microinstrucao fetch para iniciar uma nova instrucao
				cntrEnd_signal <= "00";
				
			-- Se for o estado 6, onde ocorre o execute da instrucao do tipo-R
			when "0110" =>
				-- Utiliza o campo funct da instrucao para o controle da ula
				opALU <= "10";
				-- Usa o registrador A para ser a primeira entrada da ula
				orgAALU <= '1';
				-- Usa o registrador B para ser a segunda entrada da ula
				orgBALU <= "00";
				
				readBREG <= '0';
				writeBREG <= '0';
				regDst <= '0';
				Mem2Reg <= '0';				
				readMem <= '0';
				writeMem <= '0';
				iorD <= '0';				
				escreveIR <= '0';
				orgPC <= "00";
				escrevePC <= '0';				
				escrevePCCond	<= '0';
				escrevePCCondN	<= '0';
				-- Escolhe a proxima microinstrucao sequencialmente
				cntrEnd_signal <= "11";
				
			-- Se for o estado 7, onde ocorre a conclusao da instrucao do tipo-R
			when "0111" =>
			
				opALU <= "00";
				readBREG <= '0';
				
				-- Escreve o conteudo no registrador SaidaALU no registrador indicado por rd
				writeBREG <= '1';
				regDst <= '1';
				Mem2Reg <= '0';
				
				readMem <= '0';
				writeMem <= '0';
				iorD <= '0';				
				escreveIR <= '0';
				orgPC <= "00";
				escrevePC <= '0';				
				escrevePCCond	<= '0';
				escrevePCCondN	<= '0';
				
				-- Vai para a microinstrucao fetch para iniciar uma nova instrucao
				cntrEnd_signal <= "00";
				
			-- Se for o estado 8, onde ocorre a conclusao da instrucao beq
			when "1000" =>
				--  A ula realiza a operacao Sub 
				opALU <= "01";
				-- Usa o registrador A para ser a primeira entrada da ula
				orgAALU <= '1';
				-- Usa o registrador B para ser a segunda entrada da ula
				orgBALU <= "00";
				
				readBREG <= '0';
				writeBREG <= '0';
				regDst <= '0';
				Mem2Reg <= '0';
				readMem <= '0';
				writeMem <= '0';
				iorD <= '0';				
				escreveIR <= '0';
				
				-- Se a saida Zero da ula estiver ativa, escreve o PC com o conteudo do registrador SaidaALU
				orgPC <= "01";
				
				escrevePC <= '0';	
				
				escrevePCCond <= '1';
				
				escrevePCCondN	<= '0';
				
				-- Vai para a microinstrucao fetch para iniciar uma nova instrucao
				cntrEnd_signal <= "00";
				
			-- Se for o estado 9, onde ocorre a conclusao da instrucao jump
			when "1001" =>
			
				opALU <= "00";
				
				readBREG <= '0';
				writeBREG <= '0';
				regDst <= '0';
				Mem2Reg <= '0';
				readMem <= '0';
				writeMem <= '0';
				iorD <= '0';				
				escreveIR <= '0';
				
				-- Escreve o PC com o endereco de jump da instrucao
				orgPC <= "10";
				escrevePC <= '1';
				
				escrevePCCond <= '0';				
				escrevePCCondN	<= '0';
				
				-- Vai para a microinstrucao fetch para iniciar uma nova instrucao
				cntrEnd_signal <= "00";
				
			-- Se for o estado 10, onde ocorre a conclusao da instrucao addi
			when "1010" =>
			
				opALU <= "00";				
				readBREG <= '0';
				
				-- Escreve o conteudo em MDR no registrador indicado por rt
				writeBREG <= '1';
				regDst <= '0';
				Mem2Reg <= '0';
				
				readMem <= '0';
				writeMem <= '0';
				iorD <= '0';				
				escreveIR <= '0';
				orgPC <= "00";
				escrevePC <= '0';				
				escrevePCCond <= '0';				
				escrevePCCondN	<= '0';
				
				-- Vai para a microinstrucao fetch para iniciar uma nova instrucao
				cntrEnd_signal <= "00";
			
			-- Se for o estado 11, onde ocorre a conclusao da instrucao bne
			when "1011" =>
				--  A ula realiza a operacao Sub 
				opALU <= "01";
				-- Usa o registrador A para ser a primeira entrada da ula
				orgAALU <= '1';
				-- Usa o registrador B para ser a segunda entrada da ula
				orgBALU <= "00";
				
				readBREG <= '0';
				writeBREG <= '0';
				regDst <= '0';
				Mem2Reg <= '0';				
				readMem <= '0';
				writeMem <= '0';
				iorD <= '0';				
				escreveIR <= '0';
				
				
				-- Se a saida Zero da ula NAO estiver ativa, escreve o PC com o conteudo do registrador SaidaALU
				orgPC <= "01";
				
				escrevePC <= '0';				
				escrevePCCond <= '0';
				
				escrevePCCondN <= '1';
				-- Vai para a microinstrucao fetch para iniciar uma nova instrucao
				cntrEnd_signal <= "00";
				
				
			-- Se outra operacao
			when others =>
				-- Faz nada
		end case;
	end process mem_microprog_behavior;
	
	-- Implementacao da logica de estado
	select_mux_behavior : with cntrEnd_signal select
						-- A proxima microinstrucao deve ser fetch para que uma nova instrucao seja iniciada
		saidaMUX <= "0000" when "00",
						-- Despacha usando a ROM1
						saidaROM1 when "01",
						-- Despacha usando a ROM 2
						saidaROM2 when "10",
						-- Vai pra proxima microinstrucao
						std_logic_vector(unsigned(estado) + 1) when "11",
						-- Se outra operacao
						"UUUU" when others;
	
	--------------------------
	-- Despacha usando a ROM 1
	--------------------------
	select_rom1_behavior : with codop select
						 -- Se for uma instrucao do tipo-R
		saidaROM1 <= "0110" when "000000",
						 -- Se for uma instrucao jmp
						 "1001" when "000010",
						 -- Se for uma instrucao beq
						 "1000" when "000100",
						 -- Se for uma instrucao lw
						 "0010" when "100011",
						 -- Se for uma instrucao sw
						 "0010" when "101011",
						 -- Se for uma instrucao addi
						 "0010" when "001000",
						 -- Se for uma instrucao bne
						 "1011" when "000101",
						 -- Se outra operacao
						 "UUUU" when others;
	
	--------------------------
	-- Despacha usando a ROM 2
	--------------------------
	select_rom2_behavior : with codop select
						 -- Se for uma instrucao lw
		saidaROM2 <= "0011" when "100011",
						 -- Se for uma instrucao sw
						 "0101" when "101011",
						 -- Se for uma instrucao addi
						 "1010" when "001000",
						 -- Se outra operacao
						 "UUUU" when others;
	
	--------------------------------------
	-- Implementacao do Registrador estado
	--------------------------------------
	controle_behavior : process (clk) is
	begin
		--Se estiver na subida do clock
		if clk'event and clk = '1' then
			-- O valor do estado muda
			estado <= saidaMUX;
		end if;
	end process controle_behavior;		
end architecture behavior;