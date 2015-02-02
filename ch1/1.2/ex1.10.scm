;;;; Ex 1.10

;;; The following computes a mathematical function called Ackermann's function
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

;;; What are the values of the following:
(A 1 10) ; 1024
(A 2 4)  ; 65536
(A 3 3)  ; 65536

;;; Now consider the following procedures, and give a concise mathematical
;;;   definition for the functions computed
(define (f n) (A 0 n))   ; 2n 

(define (g n) (A 1 n))   ; 2^n if n>0, else 0

(define (h n) (A 2 n))   ; 2^{h(n-1)} if n>1, else 2 if n==1, else 0

(define (k n) (* 5 n n)) ; 5n^2


;;; notes for the above problems
(g 2)
(A 1 2)
(A 0 (A 1 1))
(A 0 2)
4

(g 3)
(A 1 3)
(A 0 (A 1 2))
(A 0 (A 0 (A 1 1)))
(A 0 (A 0 2))
(A 0 4)
8

(h 2)
(A 2 2)
(A 1 (A 2 1))
(A 1 2)
(A 0 (A 1 1))
(A 0 2)
4

(h 3)
(A 2 3)
(A 1 (A 2 2))
(A 1 (A 1 (A 2 1)))
(A 1 (A 1 2))
(A 1 (A 0 (A 1 1)))
(A 1 (A 0 2))
(A 1 4)
(A 0 (A 1 3))
(A 0 (A 0 (A 1 2)))
(A 0 (A 0 (A 0 (A 1 1))))
(A 0 (A 0 (A 0 2)))
(A 0 (A 0 4))
(A 0 8)
16

(h 4)
65536

(h 0) ;0
(h 1) ;2 = 2^1
(h 2) ;4 = 2^2
(h 3) ;16 = 2^4
(h 4) ;65536 = 2^16
(h n) ; = 2^h(n-1), for n > 1

