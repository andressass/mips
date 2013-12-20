library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.multicicloMIPSpkg.all;

entity multicicloMIPS is
	port (
			reset				: in std_logic;
			clk					: in std_logic;
			clkAddressMem		: in std_logic;
			opALU_t				: out std_logic_vector (1 downto 0);
			orgAALU_t			: out std_logic;
			orgBALU_t			: out std_logic_vector (1 downto 0);
			writeBREG_t			: out std_logic;
			regDst_t				: out std_logic;
			Mem2Reg_t			: out std_logic;
			writeMem_t			: out std_logic;
			iorD_t				: out std_logic;
			escreveIR_t			: out std_logic;
			orgPC_t				: out std_logic_vector (1 downto 0);
			escrevePC_t			: out std_logic;
			escrevePCCond_t	: out std_logic;
			escrevePCCondN_t	: out std_logic;
			cntrEnd_t			: out std_logic_vector (1 downto 0);
			regEstado_t			: out std_logic_vector(3 downto 0);
			PC_t					: out std_logic_vector(31 downto 0);
			saidaMuxMem_t		: out std_logic_vector(7 downto 0);
			RI_t					: out std_logic_vector(31 downto 0);
			MDR_t					: out std_logic_vector(31 downto 0);
			saidaMuxRegDst_t	: out std_logic_vector(4 downto 0);
			saidaMuxMem2Reg_t	: out std_logic_vector(31 downto 0);
			regA_t				: out std_logic_vector(31 downto 0);
			regB_t				: out std_logic_vector(31 downto 0);
			saidaCntrALU_t		: out std_logic_vector(3 downto 0);
			saidaMuxULA1_t		: out std_logic_vector(31 downto 0);
			saidaMuxULA2_t		: out std_logic_vector(31 downto 0);
			shamt_t				: out std_logic_vector(4 downto 0);
			zero_t				: out std_logic;
			SaidaALU_t			: out std_logic_vector(31 downto 0);
			saidaMuxPC_t		: out std_logic_vector(31 downto 0)
	);
end multicicloMIPS;

architecture behavior of multicicloMIPS is
	signal opALU_sinal			: std_logic_vector (1 downto 0);
	signal orgAALU_sinal			: std_logic;
	signal orgBALU_sinal			: std_logic_vector (1 downto 0);
	signal writeBREG_sinal		: std_logic;
	signal regDst_sinal			: std_logic;
	signal Mem2Reg_sinal			: std_logic;
	signal writeMem_sinal		: std_logic;
	signal iorD_sinal				: std_logic;
	signal escreveIR_sinal		: std_logic;
	signal orgPC_sinal			: std_logic_vector (1 downto 0);
	signal escrevePC_sinal		: std_logic;
	signal escrevePCCondN_sinal: std_logic;
	signal escrevePCCond_sinal	: std_logic;
	signal RI_sinal				: std_logic_vector(31 downto 0);
begin
	opALU_t 				<= opALU_sinal;
	orgAALU_t			<= orgAALU_sinal;	
	orgBALU_t			<= orgBALU_sinal;
	writeBREG_t 		<= writeBREG_sinal;
	regDst_t				<= regDst_sinal;
	Mem2Reg_t			<= Mem2Reg_sinal;
	writeMem_t			<= writeMem_sinal;
	iorD_t				<= iorD_sinal;
	escreveIR_t			<= escreveIR_sinal;
	orgPC_t				<= orgPC_sinal;
	escrevePC_t			<= escrevePC_sinal;
	escrevePCCond_t	<= escrevePCCond_sinal;
	escrevePCCondN_t	<= escrevePCCondN_sinal;
	RI_t					<= RI_sinal;
	-----------------------------
	-- Implementacao da operativa
	-----------------------------
	operativa: operativaMIPS
		port map (
					reset				=> reset,
					clk					=> clk,
					clkAddressMem		=> clkAddressMem,
					opALU			  		=> opALU_sinal,
					orgAALU				=> orgAALU_sinal,
					orgBALU				=> orgBALU_sinal,	
					writeBREG			=> writeBREG_sinal,
					regDst				=> regDst_sinal,
					Mem2Reg				=> Mem2Reg_sinal,
					writeMem				=> writeMem_sinal,
					iorD					=> iorD_sinal,
					escreveIR			=> escreveIR_sinal,
					orgPC					=> orgPC_sinal,
					escrevePC			=> escrevePC_sinal,	
					escrevePCCond		=> escrevePCCond_sinal,	
					escrevePCCondN		=> escrevePCCondN_sinal,	
					PC_t					=> PC_t,	
					saidaMuxMem_t		=> saidaMuxMem_t,	
					RI_t					=> RI_sinal,	
					MDR_t					=>	MDR_t,
					saidaMuxRegDst_t	=> saidaMuxRegDst_t,
					saidaMuxMem2Reg_t	=> saidaMuxMem2Reg_t,
					regA_t				=> regA_t,
					regB_t				=> regB_t,
					saidaCntrALU_t		=> saidaCntrALU_t,
					saidaMuxULA1_t		=> saidaMuxULA1_t,
					saidaMuxULA2_t		=> saidaMuxULA2_t,
					shamt_t				=> shamt_t,
					zero_t				=> zero_t,
					SaidaALU_t			=> SaidaALU_t,
					saidaMuxPC_t		=> saidaMuxPC_t
		);
		
		----------------------------
		-- Implementacao do controle
		----------------------------
		controle : controleMIPS
			port map (
						clk				=> clk,	
						codop				=> RI_sinal(31 downto 26),
						opALU				=> opALU_sinal,
						orgAALU			=> orgAALU_sinal,	
						orgBALU			=> orgBALU_sinal,
						writeBREG		=> writeBREG_sinal,
						regDst			=> regDst_sinal,
						Mem2Reg			=> Mem2Reg_sinal,
						writeMem			=> writeMem_sinal,
						iorD				=> iorD_sinal,
						escreveIR		=> escreveIR_sinal,
						orgPC				=> orgPC_sinal,
						escrevePC		=> escrevePC_sinal,
						escrevePCCond	=> escrevePCCond_sinal,
						escrevePCCondN	=> escrevePCCondN_sinal,	
						cntrEnd			=> cntrEnd_t,
						regEstado		=> regEstado_t
			);
			
end architecture behavior;