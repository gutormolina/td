entity bcdTo7Seg is
	port(
	bcdIn: in bit_vector (3 downto 0);
	segOut: out bit_vector (13 downto 0)
	);
end bcdTo7Seg;

architecture arq_bcdTo7Seg of bcdTo7Seg is
begin
	with bcdIn select
		segOut <=
			"11111100000000" when "1000",
			"11111100001111" when "1001",
			"11111100100000" when "1010",
			"11111100100100" when "1011",
			"11111101001100" when "1100",
			"11111100000110" when "1101",
			"11111100010010" when "1110",
			"11111101001111" when "1111",
			"11111110000001" when "0000",
			"11111111001111" when "0001",
			"11111110010010" when "0010",
			"11111110000110" when "0011",
			"11111111001100" when "0100",
			"11111110100100" when "0101",
			"11111110100000" when "0110",
			"11111110001111" when "0111";
end arq_bcdto7Seg;