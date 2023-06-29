entity fullAdder is
	port (
		aInFull: in bit;
		bInFull: in bit;
		cInFull: in bit;
		sOutFull: out bit;
		cOutFull: out bit
	);
end fullAdder;
	
architecture arq_fullAdder of fullAdder is
signal sigSFull, sigC1Full, sigC2Full: bit;
component halfAdder
	port (
		aHalf: in bit;
		bHalf: in bit;
		sHalf: out bit;
		cHalf: out bit
	);
end component;
begin
	half1: halfAdder
	port map(aHalf => aInFull, bHalf => bInFull, sHalf => sigSFull, cHalf => sigC1Full);
	half2: halfAdder
	port map(aHalf => sigSFull, bHalf => cInFull, sHalf => sOutFull, cHalf => sigC2Full);
	cOutFull <= sigC1Full or sigC2Full;
end arq_fullAdder;
