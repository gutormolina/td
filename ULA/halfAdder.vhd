entity halfAdder is
	port(
		aHalf: in bit;
		bHalf: in bit;
		sHalf: out bit;
		cHalf: out bit
	);
end halfAdder;

architecture arq_halfAdder of halfAdder is
begin
	sHalf <= aHalf xor bHalf;
	cHalf <= aHalf and bHalf;
end arq_halfAdder;