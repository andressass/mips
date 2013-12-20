library ieee;
use ieee.std_logic_1164.all;

entity testbench_multiciclo is
end entity testbench_multiciclo;

architecture test_multiciclo of testbench_multiciclo is
	signal reset0					: std_logic;
	signal clk0						: std_logic;
	signal clkAddressMem0		: std_logic;
	signal opALU_t0				: std_logic_vector (1 downto 0);
	signal orgAALU_t0				: std_logic;
	signal orgBALU_t0				: std_logic_vector (1 downto 0);
	signal writeBREG_t0			: std_logic;
	signal regDst_t0				: std_logic;
	signal Mem2Reg_t0				: std_logic;
	signal writeMem_t0			: std_logic;
	signal iorD_t0					: std_logic;
	signal escreveIR_t0			: std_logic;
	signal orgPC_t0				: std_logic_vector (1 downto 0); 
	signal escrevePC_t0			: std_logic;
	signal escrevePCCond_t0		: std_logic;
	signal escrevePCCondN_t0	: std_logic;
	signal cntrEnd_t0				: std_logic_vector (1 downto 0);
	signal regEstado_t0			: std_logic_vector(3 downto 0);
	signal PC_t0					: std_logic_vector(31 downto 0);
	signal saidaMuxMem_t0		: std_logic_vector(7 downto 0);
	signal RI_t0					: std_logic_vector(31 downto 0);
	signal MDR_t0					: std_logic_vector(31 downto 0);
	signal saidaMuxRegDst_t0	: std_logic_vector(4 downto 0);
	signal saidaMuxMem2Reg_t0	: std_logic_vector(31 downto 0);
	signal regA_t0					: std_logic_vector(31 downto 0);
	signal regB_t0					: std_logic_vector(31 downto 0);
	signal saidaCntrALU_t0		: std_logic_vector(3 downto 0);
	signal saidaMuxULA1_t0		: std_logic_vector(31 downto 0);
	signal saidaMuxULA2_t0		: std_logic_vector(31 downto 0);
	signal shamt_t0				: std_logic_vector(4 downto 0);
	signal zero_t0					: std_logic;
	signal SaidaALU_t0			: std_logic_vector(31 downto 0);
	signal saidaMuxPC_t0			: std_logic_vector(31 downto 0);
	signal loop0					: std_logic := '0';
begin
	multicicloMIPS0	: entity work.multicicloMIPS(behavior)
						port map (reset0, clk0, clkAddressMem0, opALU_t0, orgAALU_t0, orgBALU_t0, writeBREG_t0, regDst_t0, 
						Mem2Reg_t0, writeMem_t0, iorD_t0, escreveIR_t0, orgPC_t0, escrevePC_t0, escrevePCCond_t0, 
						escrevePCCondN_t0, cntrEnd_t0, regEstado_t0, PC_t0, saidaMuxMem_t0, RI_t0, MDR_t0, saidaMuxRegDst_t0, 
						saidaMuxMem2Reg_t0, regA_t0, regB_t0, saidaCntrALU_t0, saidaMuxULA1_t0, saidaMuxULA2_t0, 
						shamt_t0, zero_t0, SaidaALU_t0, saidaMuxPC_t0);
	
	multiciclo_behav0 : process is
	begin	
		-- fetch -> busca a instrucao addi
		clk0 <= '0';
		wait for 0.2 ns;
		
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute -> soma o registrador zero com o endereco 8192 extendido
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do endereco 8192 no registrador
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao lw	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute -> obtem endereco no registrador
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- le a memoria
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor que esta endereco 128 no registrador
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		 
		-- fetch -> busca a instrucao lw	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute -> obtem endereco no registrador
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- le a memoria
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor que esta endereco 129 no registrador
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;

		
		-- fetch -> busca a instrucao sll	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao srl	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao sra
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao and	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao or	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao xor	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao lw	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute -> obtem endereco no registrador
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- le a memoria
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor no registrador
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao beq
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao slt	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao beq
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao sub
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao sw	
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute 
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita do valor na memoria
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao addi		
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute -> soma o registrador com 4
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- escrita no registrador
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		
		-- fetch -> busca a instrucao j
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- decode -> registradores sao lidos
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		
		-- execute -> salta
		clk0 <= '1'; wait for 0.2 ns;
		clk0 <= '0'; wait for 0.2 ns;
		 
		loop0 <= '1';
		wait;	
	end process;
	
	clkAddressMem_behav : process is
	begin
		while loop0 = '0' loop
			clkAddressMem0 <= '0'; wait for 0.01 ns;
			clkAddressMem0 <= '1'; wait for 0.01 ns;
		end loop;
		wait;
	end process;
end architecture test_multiciclo;