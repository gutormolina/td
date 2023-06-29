entity ULA is
	port(
		A: in bit_vector (3 downto 0);
		B: in bit_vector (3 downto 0);
		F: in bit_vector (3 downto 0);
		S: out bit_vector (13 downto 0);
		V: out bit;
		Z: out bit;
		N: out bit
	);
end ULA;

architecture arq_ULA of ULA is

signal paraToSMux: bit_vector (3 downto 0);
signal subToSMux: bit_vector (3 downto 0);
signal lShiftToSMux: bit_vector (3 downto 0);
signal tApBToSMux: bit_vector (3 downto 0);
signal tAmBToSMux: bit_vector (3 downto 0);
signal invrToSMux: bit_vector (3 downto 0);
signal paraToCMux: bit;
signal subToCMux: bit;
signal lShiftToCMux: bit;
signal tApBToCMux: bit;
signal tAmBToCMux: bit;
signal invrToCMux: bit;
signal muxToBCD: bit_vector (3 downto 0);

component parallelAdder
	port (
		aInPara: in bit_vector (3 downto 0);
		bInPara: in bit_vector (3 downto 0);
		sOutPara: out bit_vector (3 downto 0);
		cOutPara: out bit
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
component bcdTo7Seg
	port(
	bcdIn: in bit_vector (3 downto 0);
	segOut: out bit_vector (13 downto 0)
	);
end component;
component leftShifter
	port(
		aLeft: in bit_vector (3 downto 0);
		sLeft: out bit_vector (3 downto 0);
		cLeft: out bit
	);
end component;
component twoAplusB
	port(
		aTAPB: in bit_vector (3 downto 0);
		bTAPB: in bit_vector (3 downto 0);
		sTAPB: out bit_vector (3 downto 0);
		cTAPB: out bit
	);
end component;
component twoAminusB
	port(
		aTAMB: in bit_vector (3 downto 0);
		bTAMB: in bit_vector (3 downto 0);
		sTAMB: out bit_vector (3 downto 0);
		cTAMB: out bit
	);
end component;
component inverter
	port(
		aInvrtr: in bit_vector (3 downto 0);
		sInvrtr: out bit_vector (3 downto 0);
		cInvrtr: out bit
	);
end component;

begin
	parallelAdder1: parallelAdder
		port map(aInPara => A, bInPara => B, sOutPara => paraToSMux, cOutPara => paraToCMux);
		
	parallelSubtractor1: parallelSubtractor
		port map(aInSub => A, bInSub => B, sOutSub => subToSMux, cOutSub => subToCMux);

	leftShifter1: leftShifter
		port map(aLeft => A, sLeft => lShiftToSMux, cLeft => lShiftToCMux);
	
	twoAplusB1: twoAplusB
		port map(aTAPB => A, bTAPB => B, sTAPB => tApBToSMux, cTAPB => tApBToCMux);
	
	twoAminusB1: twoAminusB
		port map(aTAMB => A, bTAMB => B, sTAMB => tAmBToSMux, cTAMB => tAmBToCMux);
		
	inverter1: inverter
		port map(aInvrtr => A, sInvrtr => invrToSMux, cInvrtr => invrToCMux);
	
	converter: bcdTo7Seg
		port map(bcdIn => muxToBCD, segOut => S);
		
	with F select --mux de saída
		muxToBCD <=
			paraToSMux when "0000",
			subToSMux when "0001",
			lShiftToSMux when "0010",
			(A or B) when "0011",
			(A xor B) when "0100",
			(A and B) when "0101",
			not A when "0110",
			tApBToSMux when "0111",
			tAmBToSMux when "1000",
			invrToSMux when "1001",
			"0000" when others;
			
	with F select --mux de overflow
		V <=
			paraToCMux when "0000",
			subToCMux when "0001",
			lShiftToCMux when "0010",
			'0' when "0011",
			'0' when "0100",
			'0' when "0101",
			'0' when "0110",
			tApBToCMux when "0111",
			tAmBToCMux when "1000",
			invrToCMux when "1001",
			'0' when others;
		
	with muxToBCD select --mux de zero
		Z <=
			'1' when "0000",
			'0' when others;
		
	with muxToBCD(3) select --mux de negativo
		N <=
			'1' when '1',
			'0' when '0';

end arq_ULA;