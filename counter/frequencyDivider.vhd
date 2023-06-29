LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY frequencyDivider IS
	PORT (
		clk50: IN std_logic;
		sel: IN std_logic;
		clk1: OUT std_logic
	);
END frequencyDivider;

ARCHITECTURE arch_frequencyDivider OF frequencyDivider IS

CONSTANT TIMECONST1 : integer := 25000000;
CONSTANT TIMECONST2 : integer := 6250000;
SIGNAL count: integer range 0 to 25000000 := 0;
SIGNAL temp: std_logic := '0';

BEGIN
	PROCESS(clk50, sel)
		BEGIN
			IF (clk50'EVENT AND clk50='1')THEN
				IF(sel='0')THEN
					count <= count + 1;
					IF (count = TIMECONST1)THEN
						count <= 0;
						temp <= not temp;
					END IF;
				ELSIF(sel='1')THEN
					count <= count + 1;
					IF (count = TIMECONST2)THEN
						count <= 0;
						temp <= not temp;
					END IF;
				END IF;
			END IF;
	clk1 <= temp;		
	END PROCESS;
END arch_frequencyDivider;