package MatrixMult is
        SIZE : constant Integer := 10;
        type Matrix is array(1..SIZE,1..SIZE) of Integer;
        procedure MatMult(A, B : Matrix; C : out Matrix);
end MatrixMult;

