;;;; Ex 1.18

;;; Goal here is to redesign the logarithmic recursive  multiplication 
;;;   procedure developed in ex 1.17 so that it is a logarithmic iterative
;;;   process, thus using a logarithmic number of steps, but only constant
;;;   space.
;;;
;;; Use a procedure `double` that doubles an integer, and `halve` that divides
;;;   an even integer by 2.
;;;
;;; Use the fact that a * b = 2a * b/2.
;;;
;;; Use `n` as a state variable where `n + a*b` is the _invariant quantity_. 
(define (multiply a b)
  (define (iter a b n)
    (cond ((= b 0) n)
          ((even? b) (iter (double a) (halve b) n))
          (else (iter a (- b 1) (+ n a)))))
  (iter a b 0))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

;;; Tests:
(multiply 3 0) ;0
(multiply 0 45) ;0
(multiply 1 867) ;867
(multiply 345 1) ;345
(multiply 3 4) ;12
(multiply 3 7) ;21
(multiply 32423 6457) ;209355311

