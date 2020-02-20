;;; Base Case: list is empty, return 0
;;; Assumption: (count-numbers M) returns a count of the numbers in M, for
;;; any list M smaller than list.
;;; Step: If (car list) is a number, return 1 plus the count of the numbers in (cdr list).
;;; If (car list) is a list, then return the sum of the count of the
;;; numbers in (car list) and the count of the numbers in (cdr list).
;;; Otherwise, return 0 plus the count of the numbers in (cdr list).	  
(define (count-numbers list)
  (if (null? list) 0
      (+ (cond ((number? (car list)) 1)
               ((list? (car list)) (count-numbers (car list)))
               (else 0))
         (count-numbers (cdr list)))))


		 
;;; Base Case: L is empty, return x 
;;; Assumption: (insert x M) returns a list M combined with x at the right position(sorted), for
;;; any list M smaller than L.
;;; Step: If x is less than (car L) , return L combined with x at the front.
;;; Otherwise, return (car L) combined with the result of inserting x in (cdr L).	  
(define (insert x L)
    (if (null? L) (list x)
        (cond ((< x (car L)) (cons x L)) (else (cons (car L) (insert x (cdr L)))))))
		
		
;;; Base Case: L is empty, return M 
;;; Assumption: (insert-all N M) returns a list M combined with the list N in teh sorted order sorted, for
;;; any list N smaller than L.
;;; Step: Insert (car L) to M, which should work according to the previous solution.
;;; return (cdr L) combined with the result of inserting (car L) in M.		
(define (insert-all L M)
    (if (null? L) M
        (insert-all (cdr L) (insert (car L) M))))
		
		
;;; this works according to the above solution		
(define (sort L)
    (letrec ((insert (lambda (x L)
              (if (null? L) (list x)
                  (cond ((< x (car L)) (cons x L))
                        (else (cons (car L) (insert x (cdr L))))))))
        (insert-all (lambda (L M)
                           (if (null? L) M
                               (insert-all (cdr L) (insert (car L) M))))))
      (insert-all L `())))
		
				

(define (translate op)
    (cond ((eq? op `+) +)
          ((eq? op `*) *)
          ((eq? op `-) -)
          ((eq? op `/) /)))
		  
		  
		  
;;; Base Case: list is number, return number
;;; Assumption: (postfix-eval M) returns postfix evaluation of any list M, for
;;; any list M smaller than L.
;;; Step: If (car L) is a list, return the operation decided by (translate(caddr L))
;;; performed on (postfix-eval(car L)) and (postfix-eval(cadr L)).
;;; Otherwise, return the operation decided by (translate(caddr L))
;;; performed on (car L) and (cadr L).		  
(define (postfix-eval L)
    (if (number? L) L
        ( cond ((list? (car L)) ( (translate (caddr L)) (postfix-eval(car L)) (postfix-eval(cadr L))))
               (else ((translate (caddr L)) (car L) (cadr L))))))
		  
		  		  		  
;;; Base Case: L is empty, return the set containing the empty
;;; set, i.e. ’(()).
;;; Assumption: (powerset M) returns the powerset of M, for any set M
;;; smaller than L.
;;; Step: Append (powerset (cdr L)) with each element of (powerset (cdr L)) combined with (car L).		  
(define (powerset L)
    (if (null? L) `(())
        (let ((ans (powerset (cdr L))))
            (append ans (map (lambda(x)
                               (cons (car L) x)) ans)))))