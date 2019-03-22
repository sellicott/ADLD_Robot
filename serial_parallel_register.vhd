-- Quartus Prime VHDL Template
-- Basic Shift Register with Multiple Taps

library ieee;
use ieee.std_logic_1164.all;

entity serial_parallel_register is

	generic
	(
		DATA_WIDTH : natural := 8
	);

	port 
	(
		
		parallel_in	 : in std_logic_vector((DATA_WIDTH-1) downto 0);
		enable		 : in std_logic;
		clk			 : in std_logic;
		shift_load	 : in std_logic;
		sr_in		 	 : in std_logic;
		parallel_out : out std_logic_vector((DATA_WIDTH-1) downto 0);
		sr_out		 : out std_logic
	);

end entity;

architecture rtl of serial_parallel_register is

	-- Build a 2-D array type for the shift register
	signal sr: std_logic_vector((DATA_WIDTH-1) downto 0);

begin

	process (clk)
	begin
		if (rising_edge(clk)) then
			if (enable = '1') then
			
				if (shift_load = '1') then
					for i in 1 to DATA_WIDTH-1 loop
						sr(i) <= sr(i-1);
					end loop;

					-- Load new data into the first stage
					sr(0) <= sr_in;
				else
					sr <= parallel_in;
				end if;

			end if;
		end if;
	end process;

	-- Capture data from multiple stages in the shift register
	parallel_out <= sr;

end rtl;
