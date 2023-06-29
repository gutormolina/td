entity parallelAdder is
	port (
		aInPara: in bit_vector (3 downto 0);
		bInPara: in bit_vector (3 downto 0);
		sOutPara: out bit_vector (3 downto 0);
		cOutPara: out bit
	);
end parallelAdder;

architecture arq_parallelAdder of parallelAdder is
signal sigCPara: bit_vector (3 downto 0);
component halfAdder
	port (
		aHalf: in bit;
		bHalf: in bit;
		sHalf: out bit;
		cHalf: out bit
	);
end component;
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
	half: halfAdder
	port map(aHalf => aInPara(0), bHalf => bInPara(0), sHalf => sOutPara(0), cHalf => sigCPara(0));
	full_1: fullAdder
	port map(aInFull => aInPara(1), bInFull => bInPara(1), cInFull => sigCPara(0), sOutFull => sOutPara(1), cOutFull => sigCPara(1));
	full_2: fullAdder
	port map(aInFull => aInPara(2), bInFull => bInPara(2), cInFull => sigCPara(1), sOutFull => soutPara(2), coutFull => sigCPara(2));
	full_3: fullAdder
	port map(ainFull => ainPara(3), binFull => bInPara(3), cInFull => sigCPara(2), soutFull => soutPara(3), coutFull => sigCPara(3));
	cOutPara <= sigCPara(2) xor SigCPara(3);
end arq_parallelAdder;