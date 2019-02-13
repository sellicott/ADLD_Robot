LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY decode2to4 IS
	PORT (
		en		: IN 		STD_LOGIC;
		x		: IN 		STD_LOGIC_VECTOR(1 downto 0) ;
		y		: OUT		STD_LOGIC_VECTOR(3 downto 0)
	);
	
END decode2to4 ;

ARCHITECTURE Behavior OF decode2to4 IS
	SIGNAL xen 		: STD_LOGIC_VECTOR(2 downto 0) ;
BEGIN
	xen <= en & x ;
	PROCESS (xen)
	BEGIN
		IF xen = "111"  THEN
			y <= "1000" ;
		ELSIF xen = "110" THEN
			y <= "0100" ;
		ELSIF xen = "101" THEN
			y <= "0010" ;
		ELSIF xen = "100" THEN
			y <= "0001" ;
		-- this should never happen
		ELSE
			y <= "0000";
		END IF ;
	END PROCESS ;
END Behavior ; 