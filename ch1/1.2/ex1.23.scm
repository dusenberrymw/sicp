;;;; Ex. 1.23

;;; The idea here is that once `smallest-divisor` checks to see if the number
;;;   is divisible by `2`, there is no reason to test larger even numbers.
;;; So, the goal here is to modify the code from ex 1.22, using a `next`
;;;   procedure that returns 3 if the input is 2, and otherwise return the
;;;   input plus 2.  Then re-run the timing tests.
;;; Since we're only going to be testing odd numbers > 2, we will end up 
;;;   running half of the numnber of tests, so the timing should be about
;;;   twice as fast in practice.

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
        (else (find-divisor n (next test-divisor)))))

(define (next n)
  (if (= n 2)
      3
      (+ n 2)))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

;;; Now, use this write a procedure `search-for-primes` that checks the
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
;;; EX 1.23 NOTE: We will indicate the time from ex 1.22, followed by the
;;;   time for this exercise.
(search-for-primes 1000 1019)    ; 0.05, 0.03
(search-for-primes 10000 10037)   ; 0.15, 0.1
(search-for-primes 1000000 1000037) ; 1.6, 1

;;; So, our results show that by only testing the odd numbers above 2, we
;;;   decreased the running time by a factor of ~1.5.
;;; We were expecting a the time to decrease by a factor of 2 (cut in half),
;;;   just based on the observation that we would be running half the number 
;;;   of tests.
;;; The small discrepancy is likely due to the fact that while we are
;;;   reducing the number of numbers we are testing, we did introduce an
;;;   additional `if` statement in our `next` procedure that is run on every
;;;   iteration.  Therefore, the number of steps are not exactly cut in half,
;;;   and thus our timings are not decreased by a factor of 2.


