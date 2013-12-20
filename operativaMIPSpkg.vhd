library ieee;
use ieee.std_logic_1164.all;

package operativaMIPSpkg is

	component memoriaMIPS IS
		PORT
		(
			address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clock		: IN STD_LOGIC;--  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END component;
	
	component bregMIPS is
		port (
				clk, wreg			: in std_logic;
				add1, add2, wadd	: in std_logic_vector(4 downto 0);
				wdata					: in std_logic_vector(31 downto 0);
				r1, r2				: out std_logic_vector(31 downto 0));
	end component;
	
	component ulaMIPS is
		port (
				opcode				: in std_logic_vector(3 downto 0);
				A,B					: in std_logic_vector(31 downto 0);
				shamt					: in std_logic_vector(4 downto 0);
				Z						: out std_logic_vector(31 downto 0);
				vai, zero, ovfl	: out std_logic);
		end component;

end package operativaMIPSpkg;