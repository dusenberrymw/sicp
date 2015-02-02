;;;; Ex. 1.26

;;; In this exercise, we are given an alternative version of `expmod` that
;;;   uses explicit mulitplication rather than calling `square`.  Apparently
;;;   it causes `fast-prime?` to run slower, and an explanation given is that
;;;   it transformed the process from theta(log n) to theta(n). Goal is to
;;;   explain why.

;;; Original `expmod`:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

;;; New `expmod`:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))


;;; The problem with the new version is that in using an explicit
;;;   multiplication, now there are two identical recursive calls for every
;;;   even exp.  So, we have taken a process that may have called itself
;;;   recursively log(n) times (technically log base 2) and changed it so 
;;;   that at every level of recursion, there are now 2 calls instead of one,
;;;   which ends up being 2^log(n) times, or effecively n calls (since log 
;;;   base 2).  
;;; So, instead of a logarithmic recursive process, the behavior is now tree 
;;;   recursive, and has an order of growth of theta(n).

