;;;; Ex 1.8

;;; Implement the cube-root function using Newton's method, which says that
;;;  if y is a guess for the cube root of x, then a better guess can be 
;;;  calculated by (x/y^2 + 2y)/3
(define (cube-root-iter guess prev-guess x)
  (if (good-enough? guess prev-guess)
    guess
    (cube-root-iter (improve guess x)
               guess
               x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) 
        (* 2 guess)) 
     3))

(define (square x) (* x x))

(define (good-enough? guess prev-guess)
  (< (abs (/ (abs (- prev-guess guess))
             guess))
     0.0001))

(define (cube-root x)
  (cube-root-iter 1.0 100 x))

;;; Now test:
(cube-root 27) ; 3.000000000
(cube-root 64) ; 4.000000000


