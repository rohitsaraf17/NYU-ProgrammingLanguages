Control.Print.printDepth := 100;
Control.Print.printLength := 100;

fun merge [] L = L
 |  merge S [] = S
 |  merge (x::xs) (y::ys) = if x < y 
                            then x :: merge xs (y::ys)
                            else y :: merge (x::xs) ys;




fun split [] = ([],[])
 |  split (x::xs) = let val (l1,l2) = split xs
                        in 
						    if ((length xs) mod 2 = 0) 
							then (x::l1,l2)
                            else (l1,x::l2)
                        end;




fun mergeSort [x] = [x]
 |  mergeSort L = let val (l1,l2) = split L
                      in 
                          merge (mergeSort l1) (mergeSort l2)
                      end;





fun sort (op <) [] = []
 |  sort (op <) [x] = [x]
 |  sort (op <) L = let fun merge [] L = L 
                         |  merge S [] = S 
						 |  merge (x::xs) (y::ys) = if x < y 
						                            then x :: merge xs (y::ys) 
													else y :: merge (x::xs) ys
                        fun split [] = ([],[]) 
					     |  split (x::xs) = let val (l1,l2) = split xs 
									                    in 
													        if ((length xs) mod 2 = 0) 
															then (x::l1,l2) 
															else (l1,x::l2) 
														end
						val (l1 ,l2) = split L 
					        in 
							    merge (sort (op <) l1) (sort (op <) l2) 
							end;




datatype 'a tree = empty | leaf of 'a | node of ('a * 'a tree * 'a tree);




fun labels (leaf n) = [n]
 |  labels empty = []
 |  labels (node (root, left, right)) = (labels left @ [root]) @ labels right;




infix ==;
fun replace (op ==) x y (leaf n) = if (n == x) 
                                   then (leaf y) 
								   else (leaf n)
 |  replace (op ==) x y empty = empty
 |  replace (op ==) x y (node(root, left, right)) = if (root == x) 
                                                    then (node(y, replace (op ==) x y left, replace (op ==) x y right)) 
													else (node(root, replace (op ==) x y left, replace (op ==) x y right));





fun replaceEmpty y empty = y
 |  replaceEmpty y (leaf n) = (leaf n)
 |  replaceEmpty y (node(root,left,right)) = (node(root, replaceEmpty y left, replaceEmpty y right));



fun increment empty = leaf 0
| increment (leaf a) = leaf (a+1)
| increment (node (a, L, R)) = node (a+1, L, R);
 
fun mapTree f empty = f empty
 |  mapTree f (leaf n) = f (leaf n)
 |  mapTree f (node (root, left, right)) = f (node(root, mapTree f left, mapTree f right));
 
 fun sortTree (op <) T = mapTree (fn empty => empty
                                  | (leaf n) => (leaf (sort (op <) n))
                                  | (node(root,left,right)) => (node(sort (op <) root,left,right))) 
					     T;