--****** Song Rom  ADLD***
library IEEE;
use IEEE.std_logic_1164.all;

Entity Song_ROM is 
	port(Note_Num: 	in  STD_LOGIC_VECTOR (6 downto 0);
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
when "0000000"  => data <=  "010101010";
when "0000001"  => data <=  "010101111";
when "0000010"  => data <=  "010111111";
when "0000011"  => data <=  "011000111";
when "0000100"  => data <=  "010111010";
when "0000101"  => data <=  "010101010";
-- measure 2
when "0000110"  => data <=  "010111010";
when "0000111"  => data <=  "010111111";
when "0001000"  => data <=  "011000111";
when "0001001"  => data <=  "011010111";
when "0001010"  => data <=  "011000110";
when "0001011"  => data <=  "010111000";
when "0001100"  => data <=  "010101010";
-- measure 3
when "0001101"  => data <=  "011100010";
when "0001110"  => data <=  "011010111";
when "0001111"  => data <=  "011100111";
when "0010000"  => data <=  "100001111";
when "0010001"  => data <=  "011100110";
when "0010010"  => data <=  "011010000";
when "0010011"  => data <=  "011000010";
-- measure 4
when "0010100"  => data <=  "011010110";
when "0010101"  => data <=  "011000000";
when "0010110"  => data <=  "010111010";
when "0010111"  => data <=  "010101100";

--************ verse a ***************
-- measure 5
when "0011000"  => data <=  "010101010";
when "0011001"  => data <=  "010101111";
when "0011010"  => data <=  "010111111";
when "0011011"  => data <=  "011000111";
when "0011100"  => data <=  "010111010";
when "0011101"  => data <=  "010101010";
-- measure 6
when "0011110"  => data <=  "010111010";
when "0011111"  => data <=  "010111111";
when "0100000"  => data <=  "011000111";
when "0100001"  => data <=  "011010111";
when "0100010"  => data <=  "011000110";
when "0100011"  => data <=  "010111000";
when "0100100"  => data <=  "010101010";
-- measure 7
when "0100101"  => data <=  "011100010";
when "0100110"  => data <=  "011010111";
when "0100111"  => data <=  "011100111";
when "0101000"  => data <=  "100001111";
when "0101001"  => data <=  "011100110";
when "0101010"  => data <=  "011010000";
when "0101011"  => data <=  "011000010";
-- measure 8
when "0101100"  => data <=  "011010110";
when "0101101"  => data <=  "011000000";
when "0101110"  => data <=  "010111010";
when "0101111"  => data <=  "010101100";

--************ verse b ***************
-- measure 9
when "0110000"  => data <=  "011100010";
when "0110001"  => data <=  "011000111";
when "0110010"  => data <=  "011010111";
when "0110011"  => data <=  "011100111";
when "0110100"  => data <=  "011010010";
when "0110101"  => data <=  "011010010";
-- measure 10
when "0110110"  => data <=  "011000010";
when "0110111"  => data <=  "010101111";
when "0111000"  => data <=  "010111111";
when "0111001"  => data <=  "011000111";
when "0111010"  => data <=  "010111010";
when "0111011"  => data <=  "010100010";
-- measure 11
when "0111100"  => data <=  "010101010";
when "0111101"  => data <=  "010101111";
when "0111110"  => data <=  "010111111";
when "0111111"  => data <=  "011000111";
when "1000000"  => data <=  "011010010";
when "1000001"  => data <=  "011010010";
-- measure 12
when "1000010"  => data <=  "011000010";
when "1000011"  => data <=  "011010111";
when "1000100"  => data <=  "011000111";
when "1000101"  => data <=  "011010111";
when "1000110"  => data <=  "011100100";

--************ verse a ***************
-- measure 13
when "1000111"  => data <=  "010101010";
when "1001000"  => data <=  "010101111";
when "1001001"  => data <=  "010111111";
when "1001010"  => data <=  "011000111";
when "1001011"  => data <=  "010111010";
when "1001100"  => data <=  "010101010";
-- measure 14
when "1001101"  => data <=  "010111010";
when "1001110"  => data <=  "010111111";
when "1001111"  => data <=  "011000111";
when "1010000"  => data <=  "011010111";
when "1010001"  => data <=  "011000110";
when "1010010"  => data <=  "010111000";
when "1010011"  => data <=  "010101010";
-- measure 15
when "1010100"  => data <=  "011100010";
when "1010101"  => data <=  "011010111";
when "1010110"  => data <=  "011100111";
when "1010111"  => data <=  "100001111";
when "1011000"  => data <=  "011100110";
when "1011001"  => data <=  "011010000";
when "1011010"  => data <=  "011000010";
-- measure 16
when "1011011"  => data <=  "011010110";
when "1011100"  => data <=  "011000000";
when "1011101"  => data <=  "010111010";
when "1011110"  => data <=  "010101100";

-- pause between loop
when "1011111"  => data <=  "010000100";
when "1100000"  => data <=  "010000100";


when others => Data <= 	   "---------";--
			
		End Case;
		
	End process;
End Structure;