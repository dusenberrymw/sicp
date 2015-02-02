;;;; Ex 1.27

;;; In this exercise we wante to demonstrate that the given Carmichael numbers
;;;   do indeed fool the Fermat test.
;;; Numbers to test: 561, 1105, 1729, 2465, 2821, 6601
(define (is-prime? n)
  (define (iter a)
    (cond ((= a 0) true)
          ((fermat-test n a) (iter (- a 1)))
          (else false)))
  (iter (- n 1)))

(define (fermat-test n a)
  (= (expmod a n n) a))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (square x)
  (* x x))

;;; Now test
;;; Numbers to test: 561, 1105, 1729, 2465, 2821, 6601
(is-prime? 7)    ; true (should be true)
(is-prime? 36)   ; false (should be false)
(is-prime? 561)  ; true (should be false)
(is-prime? 1105) ; true (should be false)
(is-prime? 1729) ; true (should be false)
(is-prime? 2465) ; true (should be false)
(is-prime? 2821) ; true (should be false)
(is-prime? 6601) ; true (should be false)

;;; So, we have shown that the given Carmichael numbers do in fact fool the
;;;   Fermat test for all values a < n.
