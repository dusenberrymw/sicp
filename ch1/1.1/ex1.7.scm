;;;; Ex 1.7

;;; In the notes, we designed an implementation of Newton's Method as follows:
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x)
               x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x) (* x x))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9) ; 3.00009155413138 

;;; The problem is that `good-enough?` may fail to work correctly for very
;;;  large or small numbers due to limited precision
;;;
;;; Some examples:
;;;  * `x` is too small, so the guess seems good due to the difference check
;;;    not being high enough precision to adequately compare
(square (sqrt 0.000000043)) ; 0.00097659... instead of 0.000000043
;;;  * `x` is too large, so the good-enough? check loses accuracy past the
;;;    decimal point, and so the difference is never less than 0.001, and thus
;;;    and infinite loop occurs
;;;  NOTE: use CTRL-C CTRL-X in the separate REPL window to stop the loop
(square (sqrt 43242343423423423423423424))


;;; Now, let's implement `good-enough?` & `sqrt` overall in a better way:
;;; Keep track of the previous guess, and we can say the new guess is good
;;;  enough if the difference between this guess and the previous guess
;;;  is a miniscule fraction of this guess (ie, the guess is barely changing)
;;; Since we are now just relying on the percentage change of whatever the
;;;  guess currently is, it won't have issue with numerical precision.
(define (sqrt-iter guess prev-guess x)
  (if (good-enough? guess prev-guess)
    guess
    (sqrt-iter (improve guess x)
               guess
               x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess prev-guess)
  (< (abs (/ (abs (- prev-guess guess))
             guess))
     0.0001))

(define (sqrt x)
  (sqrt-iter 1.0 100 x))

(sqrt 9) ; 3.00009155413138 

;;; Now it works much better
;;;
;;; Same examples again, this time they work:
(square (sqrt 0.000000043)) ; 0.000000043
(square (sqrt 43242343423423423423423424)) ; 43242343423423423423423424

