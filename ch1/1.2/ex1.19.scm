;;;; Ex 1.19

;;; Goal here is to complete the following procedure, which an algorithm for
;;;   computing the Fibonacci numbers in logarithmic steps.
;;;
;;; From the iterative Fibonacci algorithm, there was a transformation of
;;;   state variables `a` and `b` such that `a <- a + b` and `b <- a`, which
;;;   we can call transformation `T`.  When we started with a=1 & b=0 and 
;;;   applied transformation `T` `n` times, we could compute Fib(n+1) and
;;;   Fib(n). Thus, we can compute the Fibonacci numbers as T^n.
;;;
;;; If we consider a slightly modified transaction `Tpq` such that
;;;   `a <- bq + aq + ap` and `b <- bp + aq`, then we can consider `T` as a 
;;;   special case of `Tpq` where `p=0` and `q=1`.
;;; Then, we can show that applying `Tpq` twice is the same as applying
;;;   a single transformation `Tp'q'`.  This will give us an explicit way to
;;;   square these transformations, and thus allow us to compute `T^n` using
;;;   successive squaring.
;;; This will result in a procedure that runs in a logarithmic number of
;;;   steps.
;;;

;;; Let's write out the two transformations `Tpq`:
;;;
;;;   a0 = bq + aq + ap
;;;   b0 = bp + aq
;;;
;;;   a1 = b0q + a0q + a0p
;;;   b1 = b0p + a0q
;;;
;;; Now, rewrite `a1` and `b1` in terms of the original `a` and `b`:
;;;
;;;   a1 = (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
;;;   b1 = (bp + aq)p + (bq + aq + ap)q
;;;
;;; Now, use the `b1` equation to calculate `p'` and `q'`:
;;;   b1 = bp' + aq'
;;;
;;;   b1 = (bp + aq)p + (bq + aq + ap)q
;;;   b1 = (bpp + aqp) + (bqq + aqq + apq)
;;;   b1 = bpp + bqq + aqp + aqq + apq
;;;   b1 = b(pp + qq) + a(qp + qq + pq)
;;;   b1 = b(pp + qq) + a(2qp + qq)
;;;   b1 = bp' + aq'
;;;
;;; So, `p'` and `q'` are:
;;;   p' = pp + qq
;;;   q' = 2qp + qq
(define (fib n)
  (define (iter a b p q count)
    (cond ((= count 0) b)
          ((even? count) (iter a 
                               b 
                               (+ (* p p) (* q q)) ;compute p'
                               (+ (* 2 (* q p)) (* q q)) ;compute q'
                               (/ count 2)))
          (else (iter (+ (* b q) (* a q) (* a p))
                      (+ (* b p) (* a q))
                      p
                      q
                      (- count 1)))))
  (iter 1 0 0 1 n))

(define (even? n)
  (= (remainder n 2) 0))

;;; Tests
(fib 0) ;0
(fib 1) ;1
(fib 2) ;1
(fib 3) ;2
(fib 4) ;3
(fib 5) ;5
(fib 6) ;8
(fib 7) ;13
(fib 8) ;21

