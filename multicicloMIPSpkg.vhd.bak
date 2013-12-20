library ieee;
use ieee.std_logic_1164.all;

package multicicloMIPSpkg is

	component operativaMIPS is
		port (
				reset				: in std_logic;
				clk					: in std_logic;
				clkAddressMem		: in std_logic;
				opALU					: in std_logic_vector (1 downto 0);
				orgAALU				: in std_logic;
				orgBALU				: in std_logic_vector (1 downto 0);
				writeBREG			: in std_logic;
				regDst				: in std_logic;
				Mem2Reg				: in std_logic;
				writeMem				: in std_logic;
				iorD					: in std_logic;
				escreveIR			: in std_logic;
				orgPC					: in std_logic_vector (1 downto 0);
				escrevePC			: in std_logic;
				escrevePCCond		: in std_logic;
				escrevePCCondN		: in std_logic;
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
	end component;
	
	component controleMIPS is
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
				escrevePCCondN	: out std_logic;
				cntrEnd			: out std_logic_vector (1 downto 0);
				regEstado		: out std_logic_vector(3 downto 0));
	end component;
end package;