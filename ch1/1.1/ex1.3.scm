;;;; Ex 1.3

(define (square x) 
  (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (largest x y) 
  (if (> x y) x y))

(define (sum-of-squares-of-two-largest x y z) 
  (if (> x y)
      (sum-of-squares x (largest y z))
      (sum-of-squares y (largest x z))))

;;; Tests
(sum-of-squares-of-two-largest 1 2 3) ;3^2 + 2^2 = 9 + 4 = 13
(sum-of-squares-of-two-largest 2 1 3) ;13
(sum-of-squares-of-two-largest 2 3 1) ;13
(sum-of-squares-of-two-largest 3 2 1) ;13
(sum-of-squares-of-two-largest 3 1 2) ;13
(sum-of-squares-of-two-largest (- 3) (- 1) (- 2)) ;(-1)^2 + (-2)^2 = 1 + 4 = 5

