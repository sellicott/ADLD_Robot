--****** Song Rom  ADLD***
library IEEE;
use IEEE.std_logic_1164.all;

Entity Song_ROM is 
	port(Note_Num: 	in  STD_LOGIC_VECTOR (5 downto 0);
		 Octave: 	out  STD_LOGIC_VECTOR (1 downto 0);
		 Note: 		out STD_LOGIC_VECTOR (3 downto 0);
		 Duration: 	out  STD_LOGIC_VECTOR (2 downto 0));
End Song_ROM;

	Architecture Structure of Song_ROM  is
	signal data: STD_LOGIC_VECTOR (8 downto 0);
Begin
		Octave <= data(8 downto 7);
		Note <= data(6 downto 3);
	    Duration <= data(2 downto 0);
	Process(Note_Num)
	Begin
		Case Note_Num is
-- O the Deep, Deep Love of Jesus

--************ verse a ***************
-- measure 1
when "000101"  => data <=  "010101010";
when "000101"  => data <=  "010101111";
when "000111"  => data <=  "010111111";
when "001000"  => data <=  "011000111";
when "000111"  => data <=  "010111010";
when "000101"  => data <=  "010101010";
-- measure 2
when "000111"  => data <=  "010111010";
when "000111"  => data <=  "010111111";
when "001000"  => data <=  "011000111";
when "001010"  => data <=  "011010111";
when "001000"  => data <=  "011000110";
when "000111"  => data <=  "010111000";
when "000101"  => data <=  "010101010";
-- measure 3
when "001100"  => data <=  "011100010";
when "001010"  => data <=  "011010111";
when "001100"  => data <=  "011100111";
when "000001"  => data <=  "100001111";
when "001100"  => data <=  "011100110";
when "001010"  => data <=  "011010000";
when "001000"  => data <=  "011000010";
-- measure 4
when "001010"  => data <=  "011010110";
when "001000"  => data <=  "011000000";
when "000111"  => data <=  "010111010";
when "000101"  => data <=  "010101100";

--************ verse a ***************
-- measure 5
when "000101"  => data <=  "010101010";
when "000101"  => data <=  "010101111";
when "000111"  => data <=  "010111111";
when "001000"  => data <=  "011000111";
when "000111"  => data <=  "010111010";
when "000101"  => data <=  "010101010";
-- measure 6
when "000111"  => data <=  "010111010";
when "000111"  => data <=  "010111111";
when "001000"  => data <=  "011000111";
when "001010"  => data <=  "011010111";
when "001000"  => data <=  "011000110";
when "000111"  => data <=  "010111000";
when "000101"  => data <=  "010101010";
-- measure 7
when "001100"  => data <=  "011100010";
when "001010"  => data <=  "011010111";
when "001100"  => data <=  "011100111";
when "000001"  => data <=  "100001111";
when "001100"  => data <=  "011100110";
when "001010"  => data <=  "011010000";
when "001000"  => data <=  "011000010";
-- measure 8
when "001010"  => data <=  "011010110";
when "001000"  => data <=  "011000000";
when "000111"  => data <=  "010111010";
when "000101"  => data <=  "010101100";

--************ verse b ***************
-- measure 9
when "001100"  => data <=  "011100010";
when "001000"  => data <=  "011000111";
when "001010"  => data <=  "011010111";
when "001100"  => data <=  "011100111";
when "001010"  => data <=  "011010010";
when "001010"  => data <=  "011010010";
-- measure 10
when "001000"  => data <=  "011000010";
when "000101"  => data <=  "010101111";
when "000111"  => data <=  "010111111";
when "001000"  => data <=  "011000111";
when "000111"  => data <=  "010111010";
when "000100"  => data <=  "010100010";
-- measure 11
when "000101"  => data <=  "010101010";
when "000101"  => data <=  "010101111";
when "000111"  => data <=  "010111111";
when "001000"  => data <=  "011000111";
when "001010"  => data <=  "011010010";
when "001010"  => data <=  "011010010";
-- measure 12
when "001000"  => data <=  "011000010";
when "001010"  => data <=  "011010111";
when "001000"  => data <=  "011000111";
when "001010"  => data <=  "011010111";
when "001100"  => data <=  "011100100";

--************ verse a ***************
-- measure 1
when "000101"  => data <=  "010101010";
when "000101"  => data <=  "010101111";
when "000111"  => data <=  "010111111";
when "001000"  => data <=  "011000111";
when "000111"  => data <=  "010111010";
when "000101"  => data <=  "010101010";
-- measure 2
when "000111"  => data <=  "010111010";
when "000111"  => data <=  "010111111";
when "001000"  => data <=  "011000111";
when "001010"  => data <=  "011010111";
when "001000"  => data <=  "011000110";
when "000111"  => data <=  "010111000";
when "000101"  => data <=  "010101010";
-- measure 3
when "001100"  => data <=  "011100010";
when "001010"  => data <=  "011010111";
when "001100"  => data <=  "011100111";
when "000001"  => data <=  "100001111";
when "001100"  => data <=  "011100110";
when "001010"  => data <=  "011010000";
when "001000"  => data <=  "011000010";
-- measure 4
when "001010"  => data <=  "011010110";
when "001000"  => data <=  "011000000";
when "000111"  => data <=  "010111010";
when "000101"  => data <=  "010101100";

when others => Data <= 	   "---------";--
			
		End Case;
		
	End process;
End Structure;