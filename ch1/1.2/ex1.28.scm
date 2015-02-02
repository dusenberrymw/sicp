;;;; Ex 1.28

;;; Goal here is to implement the Miller-Rabin test, which is a test for
;;;   primality that cannot be fooled.  This test starts with an alternate
;;;   form of Fermat's Little Theorem that states that if `n` is a prime number
;;;   and `a` is any positive integer less than `n`, then `a^(n-1)` is
;;;   congruent to `1 modulo n`. This is effectively taking 
;;;   `a^n mod n == a mod n` and dividing both sides by `a`.
;;; So, we follow the above with random values of `a`, much in the same way
;;;   as the Fermat test, however, when we are performing the squaring step
;;;   in `expmod`, we check to see if we have found a nontrivial square root
;;;   of 1 modulo n, or in other words, a number not equal to 1 or n-1 whose
;;;   square is equal to 1 modulo n.  If this is true, then `n` is not prime.

(define (is-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (is-prime? n (- times 1)))
        (else false)))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) 
          (nontrivial-check (expmod base (/ exp 2) m) m))
        (else 
          (remainder (* base (expmod base (- exp 1) m)) m))))

(define (nontrivial-check x n)
  (if (and (not (or (= x 1) (= x (- n 1))))
           (= (square x) (remainder 1 n)))
      0
      (remainder (square x) n)))

(define (square x)
  (* x x))

;;; Now test
(is-prime? 7 1000)    ; true (should be true)
(is-prime? 36 1000)   ; false (should be false)
(is-prime? 96 1000)   ; false (should be false)
(is-prime? 127 1000)   ; true (should be true)
;;; Carmichael numbers to test: 561, 1105, 1729, 2465, 2821, 6601
(is-prime? 561 1000)  ; false (should be false)
(is-prime? 1105 1000) ; false (should be false)
(is-prime? 1729 1000) ; false (should be false)
(is-prime? 2465 1000) ; false (should be false)
(is-prime? 2821 1000) ; false (should be false)
(is-prime? 6601 1000) ; false (should be false)

;;; So, we have shown that the given Carmichael numbers do not fool the
;;;   Miller-Rabin test.

