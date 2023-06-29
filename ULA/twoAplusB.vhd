entity twoAplusB is
	port(
		aTAPB: in bit_vector (3 downto 0);
		bTAPB: in bit_vector (3 downto 0);
		sTAPB: out bit_vector (3 downto 0);
		cTAPB: out bit
	);
end twoAplusB;

architecture arq_twoAplusB of twoAplusB is
signal sigOutLS: bit_vector (3 downto 0);
signal sigCLS: bit;
signal sigCtAPb: bit;
component leftShifter
	port (
		aLeft: in bit_vector (3 downto 0);
		sLeft: out bit_vector (3 downto 0);
		cLeft: out bit
	);
end component;
component parallelAdder
	port (
		aInPara: in bit_vector (3 downto 0);
		bInPara: in bit_vector (3 downto 0);
		sOutPara: out bit_vector (3 downto 0);
		cOutPara: out bit
	);
end component;
begin
	shifter: leftShifter
		port map(aLeft => aTAPB, sLeft => sigOutLS, cLeft => sigCLS);
	adder: parallelAdder
		port map(aInPara => sigOutLS, bInPara => bTAPB, sOutPara => sTAPB, cOutPara => sigCtAPb);
	cTAPB <= sigCLS or sigCtAPb;
end arq_twoAplusB;