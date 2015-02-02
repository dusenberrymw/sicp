;;;; Ex 1.24

;;; The idea here is to take the `timed-prime-test` code from ex 1.22 and
;;;   modify it to use `fast-prime?`, which uses the Fermat test, and then
;;;   repeat the timings.  Since this algorithm has theta(log n) growth, the
;;;   time should increase by factors of `log n`.

;;; The following procedure will take an integer _n_ and check to see if it
;;;   is prime.  If it is prime, then it will print 3 astericks and the
;;;   amount of time used to perform the test.
;;;
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10000) 
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (square x)
  (* x x))

;;; Now, use this to write a procedure `search-for-primes` that checks the
;;;   primality of consecutive odd integers in a specified range.
(define (search-for-primes start end)
  (cond ((even? start) (search-for-primes (+ start 1) end))
        ((not (> start end)) (timed-prime-test start)
                             (search-for-primes (+ start 2) end))))

(define (even? n)
  (= (remainder n 2) 0))

;;; Now, use `search-for-primes` to find the three smallest primes larger 
;;;   than 1000, 10,000, and 1,000,000.  Then note the average time needed to 
;;;   calculate each.  The number of steps should have an order of growth of
;;;   theta(log n), so the time should increase relative to that.
(search-for-primes 1000 1019)       ; 0.32
(search-for-primes 10000 10037)     ; 0.38
(search-for-primes 1000000 1000037) ; 0.52
(search-for-primes 10000000 10000119) ; 0.65

;;; So, these timings display logarithmic growth in that there is a 10,000x
;;;   increase in `n` between the first and last examples, and yet the timing
;;;   is only doubled, thus adhering to the order of growth of theta(log n).

