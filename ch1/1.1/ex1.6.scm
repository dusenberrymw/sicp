;;;; Ex 1.6

;;; So the question is: can the "if" special form be implemented as a 
;;;  procedure using "cond"?

;;; Here's an example of a new if procedure
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;;; now these work:
(new-if (= 2 3) 0 5)
(new-if (= 1 1) 0 5)

;;; now given this
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x) (* x x))

(define (sqrt x)
  (sqrt-iter 1.0 x))

;;; the following version of Newton's method won't work
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
(sqrt 9)

;;; the reason is that since we have now defined "new-if" as an operator, 
;;;  the operands will all be evaluated prior to being passed as arguments to
;;;  the body of new-if
;;; this means that the else-clause portion will be evaluated beforehand, and
;;;  since it is equal to the sqrt-iter function, it will just recursively
;;;  continue in a infinite loop


