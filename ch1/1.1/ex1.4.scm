;;;; Ex 1.4

;;; In this function, the operator is itself a combination that returns a 
;;;  primitive operator (+ or -) in order to calculate the absolute value of b
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;;; Tests
(a-plus-abs-b 1 2) ;3
(a-plus-abs-b 1 -2) ;3

