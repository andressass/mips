library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ulaMIPS is
	port (
			opcode				: in std_logic_vector(3 downto 0);
			A,B					: in std_logic_vector(31 downto 0);
			shamt					: in std_logic_vector(4 downto 0);
			Z						: out std_logic_vector(31 downto 0);
			vai, zero, ovfl	: out std_logic);
	end ulaMIPS;
	
architecture behavior of ulaMIPS is
begin
	ula_behavior : process (opcode, A, B) is
	-- Declaracao de variaveis
	variable Z_var 				: std_logic_vector(31 downto 0);
	variable vai_var, ovfl_var	: std_logic;
	begin
		vai_var := '0';
		ovfl_var := '0';
		case opcode is
		
			-- Se for operacao add A, B
			when "0000" =>
				Z_var := std_logic_vector(unsigned(A) + unsigned(B));
				-- Deteccao de overflow
				if((signed(A) >= 0 and signed(B) >= 0 and signed(Z_var) < 0) or (signed(A) < 0 and signed(B) < 0 and signed(Z_var) >= 0)) then
					ovfl_var := '1';
				end if;
				-- Deteccao de vai-um: se o mais significativo do dois vetores for 1, ocorrera vai-um
				vai_var := A(31) and B(31);
				
			-- Se for operacao sub A, B
			when "0001" =>
				Z_var := std_logic_vector(unsigned(A) - unsigned(B));
				-- Deteccao de overflow
				if((signed(A) >= 0 and signed(B) < 0 and signed(Z_var) < 0) or (signed(A) < 0 and signed(B) >= 0 and signed(Z_var) >= 0)) then
					ovfl_var := '1';
				end if;
				
			-- Se for operacao and A, B
			when "0010" =>
				Z_var := std_logic_vector(signed(A) and signed(B));
				
			-- Se for operacao or A, B
			when "0011" =>
				Z_var := std_logic_vector(signed(A) or signed(B));
				
			-- Se for operacao not A
			when "0100" =>
				Z_var := std_logic_vector(not signed(A));
				
			-- Se for operacao xor A, B
			when "0101" =>
				Z_var := std_logic_vector(signed(A) xor signed(B));
				
			-- Se for operacao bypass A
			when "0110" =>
				Z_var := std_logic_vector(signed(A));	
				
			-- Se for operacao slt A, B
			when "0111" =>
				-- Se A menor que B
				if(signed(A) < signed(B)) then
					-- Z igual a 1
					Z_var := "00000000000000000000000000000001";
				-- Se A maior que B
				else
					-- Z igual a 0
					Z_var := "00000000000000000000000000000000";
				end if;
				
			-- Se for operacao sll
			when "1000" =>
				Z_var := std_logic_vector(unsigned(B) sll to_integer(unsigned(shamt)));
				
			-- Se for operacao srl
			when "1001" =>
				Z_var := std_logic_vector(unsigned(B) srl to_integer(unsigned(shamt)));
				
			-- Se for operacao sra
			when "1010" =>
				Z_var := to_stdlogicvector(to_bitvector(B) sra to_integer(unsigned(shamt)));
				
			-- Se outra operacao
			when others =>
				-- Faz nada
		end case;
		
		--Deteccao se resultado for igual a zero
		if(signed(Z_var) = 0) then
			zero <= '1';
		else
			zero <= '0';
		end if;
		
		-- Atribuicao das variaveis nas saidas
		Z 	  <= Z_var;
		vai  <= vai_var;
		ovfl <= ovfl_var;
	end process ula_behavior;
end architecture behavior;