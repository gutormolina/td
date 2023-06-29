entity inverter is
	port(
		aInvrtr: in bit_vector (3 downto 0);
		sInvrtr: out bit_vector (3 downto 0);
		cInvrtr: out bit
	);
end inverter;

architecture arq_inverter of inverter is
component parallelAdder
	port (
		aInPara: in bit_vector (3 downto 0);
		bInPara: in bit_vector (3 downto 0);
		sOutPara: out bit_vector (3 downto 0);
		cOutPara: out bit
	);
end component;
begin
	adder: parallelAdder
		port map(aInPara => (not aInvrtr), bInPara => "0001", sOutPara => sInvrtr, cOutPara => cInvrtr);
end arq_inverter;