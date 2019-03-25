-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity obstacle_FSM is
	generic(
		main_clk			: integer	:= 14;
		turn_clk			: integer 	:= 19;
		turn_len			: integer	:= 7;
		min_distance	: integer	:= 85
	);
	
	port(
		clk			: in	std_logic_vector(29 downto 0);
		front_dist	: in	unsigned(7 downto 0);
		reset			: in	std_logic;
		
		-- motor outputs
		left_motor	: out	std_logic;
		left_en		: out std_logic;
		right_motor	: out std_logic;
		right_en		: out	std_logic;
		-- state output
		state_out	: out unsigned(4 downto 0)
		
	);

end entity;

architecture rtl of obstacle_FSM is

	-- Build an enumerated type for the state machine
	type state_type is (stopped, straight, turn_left);

	-- Register to hold the current state
	signal state   : state_type;
	signal turn_count	: integer range 0 to turn_len;
	

begin

	-- Logic to advance to the next state
	process (clk(main_clk), reset)
	begin
		if reset = '1' then
			state <= stopped;
		elsif (clk(main_clk)'event and clk(main_clk) = '1') then
			case state is
				when stopped =>
					state <= straight;
				when straight =>
					if front_dist <= min_distance then
						state <= turn_left;
					else
						state <= straight;
					end if;
				when turn_left =>
					if turn_count = 0 then
						state <= straight;
					else
						state <= turn_left;
					end if;
			end case;
		end if;
	end process;
	
	-- counter for turning
	process(clk(turn_clk), state)
	begin
 		if (clk(turn_clk)'event and clk(turn_clk) = '1' ) then
			if (turn_count /= 0) then
				turn_count <= turn_count - 1;
			elsif state = straight then
				turn_count <= turn_len;
			end if;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when stopped =>
				-- both motors stopped
				left_en <= '0';
				right_en <= '0';
				-- don't care which direction
				left_motor <= '-';
				right_motor <= '-';
				
				-- state 0
				state_out <= to_unsigned(0, state_out'length);
			when straight =>
				-- both motors on
				left_en <= '1';
				right_en <= '1';
				-- both motors forward
				left_motor <= '1';
				right_motor <= '1';
				
				-- state 1
				state_out <= to_unsigned(1, state_out'length);
			when turn_left =>
				-- both motors on
				left_en <= '1';
				right_en <= '1';
				-- left motor forward, right motor reverse
				left_motor <= '0';
				right_motor <= '1';
				
				--state 2
				state_out <= to_unsigned(2, state_out'length);
		end case;
	end process;

end rtl;
