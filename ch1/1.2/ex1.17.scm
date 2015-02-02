;;;; Ex 1.17

;;; Goal here is to design a multiplication procedure analogous to `fast-expt`
;;;   that uses a logarithmic number of steps, and is thus a logarithmic
;;;   recursive process.
;;;
;;; Use a procedure `double` that doubles an integer, and `halve` that divides
;;;   an even integer by 2.

(define (multiply a b)
  (cond ((or (= a 0) (= b 0)) 0)
        ((= a 1) b)
        ((= b 1) a)
        ((even? b) (multiply (double a) (halve b)))
        (else (+ a (multiply a (- b 1))))))

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
