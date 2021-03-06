library IEEE;
use IEEE.std_logic_1164.all;

Entity Duration_ROM is 
	port(Data_in: in  STD_LOGIC_VECTOR (2 downto 0);
	     Dur: out STD_LOGIC_VECTOR (4 downto 0));
End Duration_ROM ;

Architecture Structure of Duration_ROM  is
Begin
	Process(Data_in)
	Begin
		Case Data_in is
		--   ROM for Note Durations           
			when "000" => Dur <= "00011";	-- 1/16 Note
			when "001" => Dur <= "-----";	-- 1/8 Note
			when "010" => Dur <= "01011";	-- 1/4 Note
			when "011" => Dur <= "-----";	-- Dotted 1/4 Note 
			when "100" => Dur <= "10111";	-- Half Note
			when "101" => Dur <= "-----";	-- Dotted 1/2 Note
			when "110" => Dur <= "00111";	-- Dotted 1/8 Note
			when "111" => Dur <= "00100";	-- Triplet 1/12 Note
		End Case;
	End process;
End Structure;
