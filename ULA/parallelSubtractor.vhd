entity parallelSubtractor is
	port (
		aInSub: in bit_vector (3 downto 0);
		bInSub: in bit_vector (3 downto 0);
		cOutSub: out bit;
		sOutSub: out bit_vector (3 downto 0)
	);
end parallelSubtractor;

architecture arq_parallelSubtractor of parallelSubtractor is
signal sigCSub: bit_vector (3 downto 0);
component fullAdder
	port (
		aInFull: in bit;
		bInFull: in bit;
		cInFull: in bit;
		sOutFull: out bit;
		cOutFull: out bit
	);
end component;
begin
	full_1: fullAdder
	port map(aInFull => aInSub(0), bInFull => (not bInSub(0)), cInFull => '1', sOutFull => sOutSub(0), cOutFull => sigCSub(0));
	full_2: fullAdder
	port map(aInFull => aInSub(1), bInFull => (not bInSub(1)), cInFull => sigCSub(0), sOutFull => sOutSub(1), cOutFull => sigCSub(1));
	full_3: fullAdder
	port map(aInFull => aInSub(2), bInFull => (not bInSub(2)), cInFull => sigCSub(1), sOutFull => sOutSub(2), cOutFull => sigCSub(2));
	full_4: fullAdder
	port map(aInFull => aInSub(3), bInFull => (not bInSub(3)), cInFull => sigCSub(2), sOutFull => sOutSub(3), cOutFull => sigCSub(3));
	cOutSub <= sigCSub(3) xor sigCSub(2);
end arq_parallelSubtractor;