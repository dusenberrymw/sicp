;;;; Ex 1.11

;;; Given the following rules about a function _f_,
;;;   f(n) = n                            if n < 3
;;;   f(n) = f(n-1) + 2f(n-2) + 3f(n-3)   if n >= 3
;;; write a procedure to compute _f_ with a _recursive_ process:
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

;;; Now write a procedure to compute _f_ with an _iterative_ process:
(define (f n)
  (define (iter a b c count)
    (if (< count 3)
      a
      (iter (+ a (* 2 b) (* 3 c)) a b (- count 1))))
  (if (< n 3)
    n
    (iter 2 1 0 n)))
;;; in the above, a, b, & c contain the values for f(n-1), f(n-2), f(n-3)
;;;   respectively, starting with n = 3

