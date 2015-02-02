;;;; Ex 1.16

;;; Goal is to define a procedure that generates an interative process for 
;;;   computing exponents that uses successive squaring and a logarithmic 
;;;   number of steps.
;;;
;;; Hint: Using the observation that (b^(n/2))^2 = (b^2)^(n/2), keep the
;;;   exponent `n`, the base `b`, and an additional state variable `a`. Then
;;;   define the state transformation such that the product a*b^n is unchanged
;;;   from state to state.
;;;
;;; The value that remains unchanged (a*b^n in this case) from state to state
;;;   is known as an _invariant quantity_.

;;; Let's use the following rules:
;;;
;;;   Start with a = 1.
;;;   If n == 0:
;;;     Return a
;;;   If `n` is even:
;;;     Set b = b^2
;;;     Set n = n/2
;;;     Set a = a
;;;   Else:
;;;     Set b = b
;;;     Set n = n - 1
;;;     Set a = a * b
(define (expt b n)
  (define (iter b n a)
    (cond ((= n 0) a)
          ((even? n) (iter (square b) (/ n 2) a))
          (else (iter b (- n 1) (* a b)))))
  (iter b n 1))

(define (even? n)
  (= (remainder n 2) 0))

(define (square n)
  (* n n))

;;; Tests:
(expt 3 0) ;1
(expt 3 1) ;3
(expt 3 2) ;9
(expt 3 3) ;27
(expt 3 10);59049
(expt 17 5);1419857

