package body MatrixMult is

	task type MultiplyType is
		entry mult(A,B : Matrix; I,j : Integer);
		entry assign(P:out Integer);
	end MultiplyType;
	
	task body MultiplyType is
		sum: integer;
		row: integer;
		col: integer;
		arr1: array(1..10) of integer;
		arr2: array(1..10) of integer;
	begin
		accept mult(A,B : Matrix; I,J : Integer) do
			sum := 0;
			row := I;
			col := J;
			for K in 1..SIZE loop
				arr1(K) := A(I,K);
				arr2(K) := B(K,J);
			end loop;
		end mult;
		for K in 1..SIZE loop		
			sum := sum + (arr1(K)*arr2(K));
		end loop;
		accept assign(P:out Integer) do
			P:= sum;
		end assign;
	end MultiplyType;

	Multiply: array(1..SIZE,1..SIZE) of MultiplyType;

	procedure MatMult(A, B : Matrix; C : out Matrix) is
		P: integer;
	begin
		for I in 1..SIZE loop
			for J in 1..SIZE loop
				Multiply(I,J).mult(A,B,I,J);
			end loop;
		end loop;
		for I in 1..SIZE loop
			for J in 1..SIZE loop
				Multiply(I,J).assign(P);
				C(I,J) := P;
			end loop;
		end loop;
	end MatMult;

end MatrixMult;
