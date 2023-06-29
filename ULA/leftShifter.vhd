entity leftShifter is
	port(
		aLeft: in bit_vector (3 downto 0);
		sLeft: out bit_vector (3 downto 0);
		cLeft: out bit
	);
end leftShifter;

architecture arq_leftShifter of leftShifter is
begin
	sLeft(0) <= '0';
	sLeft(1) <= aLeft(0);
	sLeft(2) <= aLeft(1);
	sLeft(3) <= aLeft(2);
	cLeft <= aLeft(3) XOR aLeft(2);
end arq_leftShifter;