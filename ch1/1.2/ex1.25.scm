;;;; Ex 1.25

;;; In this exercise, a claim is made that the `expmod` procedure could have
;;;   been simplified to make use of our `fast-expt` procedure.  We want to
;;;   explore this claim and determine if it is correct, and if it would work
;;;   well for the `fast-prime?` procedure.

;;; Original `expmod`:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

;;; New claim for `expmod`:
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))


;;; While the new claim will work correctly, it has performance drawbacks.
;;;   The original version combine the exponential and modulo functions into
;;;   one procedure, and so was able to optimize them.  Essentially, the first
;;;   one determined b^(e/2) mod m, then squared this result and computed this
;;;   result mod m.  Thus we did not have to perform the modulo function on 
;;;   very large numbers.  However, the new version would fully compute b^e,
;;;   and then take the modulo of that value. When we use it to test large 
;;;   numbers, e=m, and thus b^e will be very large.

