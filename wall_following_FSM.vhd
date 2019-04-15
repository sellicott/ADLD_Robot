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
		main_clk			  : integer	:= 14;
		turn_clk			  : integer 	:= 19;
		turn_len			  : integer	:= 7;
		min_front_dist	  : integer	:= 50;
		min_side_dist	  : integer	:= 50;
		max_side_dist	  : integer	:= 55;
		far_dist			  : integer	:= 60;
		back_far_dist    : integer := 60
	);
	
	port(
		clk			: in	std_logic_vector(29 downto 0);
		front_dist	: in	unsigned(7 downto 0);
		left_dist	: in	unsigned(7 downto 0);
		right_dist	: in 	unsigned(7 downto 0);
		back_left_dist		: in	unsigned(7 downto 0);
		back_right_dist	: in  unsigned(7 downto 0);
		left_follow 		: in  std_logic;
		reset					: in	std_logic;
		
		-- motor outputs
		left_motor	: out	std_logic;
		left_en		: out std_logic;
		right_motor	: out std_logic;
		right_en		: out	std_logic;
		-- state output
		state_out	: out unsigned(3 downto 0);
		count_out	: out unsigned(7 downto 0);
		led_out		: out std_logic_vector(2 downto 0)
		
	);

end entity;

architecture rtl of wall_following_FSM is

	-- Build an enumerated type for the state machine
	type state_type is (stopped, straight, correct_in, correct_out, turn_90, past_wall);

	-- Register to hold the current state
	signal state   	: state_type;
	signal turn_count	: integer range 0 to turn_len;
	
	signal inside_motor		: std_logic;
	signal outside_motor		: std_logic;
	signal inside_en			: std_logic;
	signal outside_en			: std_logic;
	signal inside_dist		: unsigned(7 downto 0);
	signal back_dist			: unsigned(7 downto 0);
	

begin
	
	-- assign motors and sensors based on which wall we are following
	process (left_follow)
	begin
		if (left_follow = '1') then
			-- select the left 45 sensor and the left back sensor
			inside_dist <= left_dist;
			back_dist <= back_left_dist;
			
			left_motor <= inside_motor;
			right_motor <= outside_motor;
			left_en <= inside_en;
			right_en <= outside_en;
		else
			-- select the right 45 sensor and the right back sensor
			inside_dist <= right_dist;
			back_dist <= back_right_dist;
			
			right_motor <= inside_motor;
			left_motor <= outside_motor;
			right_en <= inside_en;
			left_en <= outside_en;
		end if;
	end process;
	
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
					if inside_dist > far_dist AND back_dist < back_far_dist then
						state <= past_wall;
					
					-- wall in front, turn 90 degrees
					elsif front_dist <= min_front_dist then
						state <= turn_90;
						
					-- keep following the wall 
					-- we are vearing left, turn right
					elsif inside_dist <= min_side_dist then
						state <= correct_out;
						
					-- we are vearing right, turn left
					elsif inside_dist >  max_side_dist then
						state <= correct_in;
						
					-- we are in range
					else
						state <= straight;
					end if;
					
				when correct_in =>
					if inside_dist > far_dist AND back_dist < back_far_dist then
						state <= past_wall;
						
					-- keep turning left until left distance
					-- sensor is back in range
					elsif inside_dist >  max_side_dist then
						state <= correct_in;
						
					else
						state <= straight;
					end if;
						
				when correct_out =>
					if inside_dist > far_dist AND back_dist < back_far_dist then
						state <= past_wall;
						
					-- keep turning left until left distance
					-- sensor is back in range
					elsif inside_dist <= min_side_dist then
						state <= correct_out;
						
					else
						state <= straight;
					end if;
				
				when turn_90 =>
					if turn_count = 0 then
						state <= straight;
					else
						state <= turn_90;
					end if;
				
				when past_wall =>
					-- wait until the back sensor is a big number
					if back_dist > back_far_dist then
						state <= correct_in;
					elsif front_dist < min_front_dist then
						state <= turn_90;
					else
						state <= past_wall;
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
				inside_en <= '0';
				outside_en <= '0';
				-- don't care which direction
				inside_motor <= '-';
				outside_motor <= '-';
				
				-- state 0
				state_out <= to_unsigned(0, state_out'length);
			when straight =>
				-- both motors on
				inside_en <= '1';
				outside_en <= '1';
				-- both motors forward
				inside_motor <= '1';
				outside_motor <= '1';
				
				-- state 1
				state_out <= to_unsigned(1, state_out'length);
				
			when correct_in =>
				-- outside motor on
				inside_en <= '0';
				outside_en <= '1';
				-- outside motor fwd
				inside_motor <= '-';
				outside_motor <= '1';
				
				-- state 1
				state_out <= to_unsigned(2, state_out'length);
			
			when correct_out =>
				-- inside motor on
				inside_en <= '1';
				outside_en <= '0';
				-- inside motor fwd
				inside_motor <= '1';
				outside_motor <= '-';
				
				-- state 1
				state_out <= to_unsigned(3, state_out'length);
				
			when turn_90 =>
				-- both motors on
				inside_en <= '1';
				outside_en <= '1';
				-- inside motor forward, outside motor reverse
				inside_motor <= '1';
				outside_motor <= '0';
				
				--state 2
				state_out <= to_unsigned(4, state_out'length);
				
			when past_wall =>
				-- both motors on
				inside_en <= '1';
				outside_en <= '1';
				-- both motors forward
				inside_motor <= '1';
				outside_motor <= '1';
				
				-- state 1
				state_out <= to_unsigned(5, state_out'length);
		end case;
	end process;
	
	count_out <= to_unsigned(turn_count, count_out'length);
	
	process(inside_dist, back_dist, front_dist)
	begin
		if (inside_dist > far_dist) then
			led_out(0) <= '1';
		else
			led_out(0) <= '0';
		end if;
		
		if (back_dist > back_far_dist) then
			led_out(1) <= '1';
		else
			led_out(1) <= '0';
		end if;
		
		if (front_dist < min_front_dist) then
			led_out(2) <= '1';
		else
			led_out(2) <= '0';
		end if;
	end process;
end rtl;
