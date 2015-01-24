;;;; Ex 1.5

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;;; With an interpreter that uses applicative-order evaluation, this will
;;;  result in undefined behavior (symbol p evaluation will be stuck in 
;;;  infinite loop).  This is due to all operands being evaluated first with
;;;  applicative-order eval.
;;; With an interpreter that uses normal-order evaluation, this will result in
;;;  0, since the all arguments will be fully expanded to primitive operators
;;;  before any evaluation occurs.  Since 'if' statements only evaluate the
;;;  clauses as needed, '(p)' will not be evaluated when '0' is passed in as 
;;;  an argument.
;;;
;;; NOTE: use CTRL-c CTRL-X in separate repl shell (not the vim buffer) to 
;;;  abort this process
(test 0 (p))

