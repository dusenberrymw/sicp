;;;; Ex 1.22

;;; The following procedure will take an integer _n_ and check to see if it
;;;   is prime.  If it is prime, then it will print 3 astericks and the
;;;   amount of time used to perform the test.
;;;
;;; ** NOTE ** `start-prime-test` has been modified to run the `prime?` test
;;;   in a loop because modern hardware is too fast for the accuracy of 
;;;   `runtime`.
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (define (iter n count)
    (prime? n)
    (if (> count 0)
      (iter n (- count 1))))
  (cond ((prime? n) 
         (iter n 1000)
         (report-prime (- (runtime) start-time)))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

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
;;;   theta(sqrt(n)), so the time should increase relative to that.
(search-for-primes 1000 1019)    ; 0.05
(search-for-primes 10000 10037)   ; 0.15
(search-for-primes 1000000 1000037) ; 1.6

;;; There is a 10x increase between n=1000 and n=10000, so the number of
;;;   steps should grow by a factor of sqrt(10).  Using our timing data,
;;;   sqrt(10) * 0.05 = 0.15 = timing for n=10000, so the order-of-growth 
;;;   seems correct.
;;;
;;; There is a 100x increasee between n=10,000 and n=1,000,000, so the number
;;;   of steps should grow by a factor of sqrt(100).  Using our timing data,
;;;   sqrt(100) * 0.15 = 1.5 ~= timing for n=1,000,000, so the timing does
;;;   seem to be comparible with the number of steps.

