-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wall_following_FSM is
	generic(
		main_clk			: integer	:= 14;
		turn_clk			: integer 	:= 19;
		turn_len			: integer	:= 7;
		min_front_dist	: integer	:= 50;
		min_side_dist	: integer	:= 50;
		max_side_dist	: integer	:= 55
		
	);
	
	port(
		clk			: in	std_logic_vector(29 downto 0);
		front_dist	: in	unsigned(7 downto 0);
		left_dist	: in	unsigned(7 downto 0);
		right_dist	: in 	unsigned(7 downto 0);
		reset			: in	std_logic;
		
		-- motor outputs
		left_motor	: out	std_logic;
		left_en		: out std_logic;
		right_motor	: out std_logic;
		right_en		: out	std_logic;
		-- state output
		state_out	: out unsigned(3 downto 0);
		count_out	: out unsigned(7 downto 0)
		
	);

end entity;

architecture rtl of wall_following_FSM is

	-- Build an enumerated type for the state machine
	type state_type is (stopped, straight, turn_left, turn_right, turn_90);

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
					-- wall in front, turn 90 degrees
					if front_dist <= min_front_dist then
						state <= turn_90;
					-- keep following the wall 
					-- we are vearing left, turn right
					elsif left_dist <= min_side_dist then
						state <= turn_right;
					-- we are vearing right, turn left
					elsif left_dist >  max_side_dist then
						state <= turn_left;
					-- we are in range
					else
						state <= straight;
					end if;
					
				when turn_left =>
					-- keep turning left until left distance
					-- sensor is back in range
					if left_dist >  max_side_dist then
						state <= turn_left;
					else
						state <= straight;
					end if;
						
				when turn_right =>
					-- keep turning left until left distance
					-- sensor is back in range
					if left_dist <= min_side_dist then
						state <= turn_right;
					else
						state <= straight;
					end if;
				
				when turn_90 =>
					if turn_count = 0 then
						state <= straight;
					else
						state <= turn_90;
					end if;
					
			end case;
		end if;
	end process;
	
	-- counter for turning
	process(clk(turn_clk), state)
	begin
		if state /= turn_90 then
			turn_count <= turn_len;
 		elsif (clk(turn_clk)'event and clk(turn_clk) = '1' ) then
			if (turn_count /= 0) then
				turn_count <= turn_count - 1;
			else
				turn_count <= turn_count;
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
				-- left motor on
				left_en <= '1';
				right_en <= '0';
				-- left motor forward
				left_motor <= '1';
				right_motor <= '-';
				
				-- state 1
				state_out <= to_unsigned(2, state_out'length);
			
			when turn_right =>
				-- left motor on
				left_en <= '0';
				right_en <= '1';
				-- left motor forward
				left_motor <= '-';
				right_motor <= '1';
				
				-- state 1
				state_out <= to_unsigned(3, state_out'length);
				
			when turn_90 =>
				-- both motors on
				left_en <= '1';
				right_en <= '1';
				-- left motor forward, right motor reverse
				left_motor <= '0';
				right_motor <= '1';
				
				--state 2
				state_out <= to_unsigned(4, state_out'length);
		end case;
	end process;
	
	count_out <= to_unsigned(turn_count, count_out'length);
end rtl;
