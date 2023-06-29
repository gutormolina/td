entity twoAminusB is
	port(
		aTAMB: in bit_vector (3 downto 0);
		bTAMB: in bit_vector (3 downto 0);
		sTAMB: out bit_vector (3 downto 0);
		cTAMB: out bit
	);
end twoAminusB;

architecture arq_twoAminusB of twoAminusB is
signal sigOutLSub: bit_vector (3 downto 0);
signal sigCLSub: bit;
signal sigCtAmB: bit;
component leftShifter
	port (
		aLeft: in bit_vector (3 downto 0);
		sLeft: out bit_vector (3 downto 0);
		cLeft: out bit
	);
end component;
component parallelSubtractor
	port (
		aInSub: in bit_vector (3 downto 0);
		bInSub: in bit_vector (3 downto 0);
		cOutSub: out bit;
		sOutSub: out bit_vector (3 downto 0)
	);
end component;
begin
	shifter: leftShifter
		port map(aLeft => aTAMB, sLeft => sigOutLSub, cLeft => sigCLSub);
	subtractor: parallelSubtractor
		port map(aInSub => sigOutLSub, bInSub => bTAMB, sOutSub => sTAMB, cOutSub =>  sigCtAmB);
	cTAMB <= sigCLSub or sigCtAmB;
end arq_twoAminusB;