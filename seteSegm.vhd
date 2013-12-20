library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seteSegm is
	port (
			digito	: in std_logic_vector(3 downto 0);
			oHEX 	: out std_logic_vector(6 downto 0)
	);
end seteSegm;

architecture behavior of seteSegm is
begin	
	with digito select
				-- zero aceso
		oHEX <= "1000000" when "0000",
				-- um aceso
				"1111001" when "0001",
				-- dois aceso
				"0100100" when "0010",
				-- tres aceso
				"0110000" when "0011",
				-- quatro aceso
				"0011001" when "0100",
				-- cinco aceso
				"0010010" when "0101",
				-- seis aceso
				"0000010" when "0110",
				-- sete aceso
				"1111000" when "0111",
				-- oito aceso
				"0000000" when "1000",
				-- nove aceso
				"0011000" when "1001",
				-- A aceso
				"0001000" when "1010",
				-- b aceso
				"0000011" when "1011",
				-- C aceso
				"1000110" when "1100",
				-- d aceso
				"0100001" when "1101",
				-- E aceso
				"0000110" when "1110",
				-- F aceso
				"0001110" when "1111",
				-- Outro caso
				"UUUUUUU" when others;
end architecture;