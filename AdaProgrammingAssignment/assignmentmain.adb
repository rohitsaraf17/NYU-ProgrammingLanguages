with text_io;
with MatrixMult;

procedure AssignmentMain is
	use text_io;
	package int_io is new integer_io(integer);
	use int_io;

	use MatrixMult;
	A,B,C : Matrix;

	task Reader1 is
		entry Read1;
	end Reader1;

        task Reader2 is
                entry Read2;
        end Reader2;	

	task Printer is
		entry Print;
	end Printer;

	task body Reader1 is
	begin
		accept Read1 do
	--		put("Enter the values for Matrix A:");
	--		New_Line;
			for I in 1..SIZE loop
				for J in 1..SIZE loop
					get(A(I,J));
				end loop;
			end loop;
		end Read1;
	end Reader1;

        task body Reader2 is
	begin
                accept Read2 do
	--		put("Enter the values for Matrix B:");
	--		New_Line;
                	for I in 1..SIZE loop
                        	for J in 1..SIZE loop
                        		get(B(I,J));
                        	end loop;
                	end loop;
		end Read2;
        end Reader2;

	task body Printer is
	begin
		accept Print;
		for I in 1..SIZE loop
			for J in 1..SIZE loop
				put(C(I,J));
				put(" ");
			end loop;
			New_Line;
		end loop;
	end Printer;

begin
	Reader1.Read1;
	Reader2.Read2;
	MatMult(A,B,C);
	Printer.Print;
end AssignmentMain;

