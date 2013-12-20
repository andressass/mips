library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bregMIPS is
	port (
			clk, wreg			: in std_logic;
			add1, add2, wadd	: in std_logic_vector(4 downto 0);
			wdata					: in std_logic_vector(31 downto 0);
			r1, r2				: out std_logic_vector(31 downto 0));
end bregMIPS;

architecture behavior of bregMIPS is
type reg is array (0 to 31) of std_logic_vector(31 downto 0);
signal breg : reg;
begin

	--Barramento de saida r1 e r2 para a leitura dos registradores
	r1 <= breg(to_integer(unsigned(add1)));
	r2 <= breg(to_integer(unsigned(add2)));
			
	breg_behavior : process (clk, wreg) is
	begin
		--Se estiver na subida do clock
		if clk'event and clk = '1' then	
			
			-- Registrador zero sempre igual a 0
			breg(0) <= "00000000000000000000000000000000";
			
			--Se o sinal de escrita wreg estiver setado, o registrador que tem o endereco em wadd sera carregado com o dado wdata
			if wreg = '1' then 
				if(to_integer(unsigned(wadd)) /= 0) then
					breg(to_integer(unsigned(wadd))) <= wdata;
				end if;				
			end if;
		end if;
	end process breg_behavior;
end architecture behavior;
	