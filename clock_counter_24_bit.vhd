-- Quartus Prime VHDL Template
-- Binary Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_counter_24_bit is

	generic
	(
		NUM_BITS : integer := 24
	);

	port
	(
		clk		  : in std_logic;
		q		  	  : buffer std_logic_vector ( NUM_BITS - 1 downto 0 )
	);

end entity;

architecture rtl of clock_counter_24_bit is
begin

	process (clk)
	begin
		if (rising_edge(clk)) then
			-- Increment the counter if counting is enabled			   
			q <= std_logic_vector( unsigned( q ) + 1 );
		end if;
		
	end process;

end rtl;
