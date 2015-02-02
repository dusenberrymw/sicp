;;;; Ex 1.20

;;; Goal is to consider the `gcd` procedure below and use the substitution
;;;   model to illustrate the process for evaluating `(gcd 206 40)` using
;;;   the _normal-order evalution_ rules, as well as the _applicative-order
;;;   evaluation_ rules.
;;; Indicate how many times the `remainder` operation
;;;   is performed in each type of evaluation.
(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

;;; Normal-order evaluation:
;;; first, expand all arguments
;;; Note that we will have to evaluate the `if` predicates along the way so 
;;;   that we will know if we need to evaluate the consequent or the 
;;;   alternative.
(gcd 206 40)

(if (= 40 0)
  206
  (gcd 40 (remainder 206 40)))

(gcd 40 (remainder 206 40))

(if (= (remainder 206 40) 0)
  40
  (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

(if (= 6 0) ; +1 eval
  40
  (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))

(if (= (remainder 40 (remainder 206 40)) 0)
  (remainder 206 40)
  (gcd (remainder 40 (remainder 206 40)) 
       (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

(if (= 4 0) ; +2 evals
  (remainder 206 40)
  (gcd (remainder 40 (remainder 206 40)) 
       (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

(gcd (remainder 40 (remainder 206 40)) 
     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
  (remainder 40 (remainder 206 40))
  (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40) 
                           (remainder 40 (remainder 206 40))))))

(if (= 2 0) ; +4 evals
  (remainder 40 (remainder 206 40))
  (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40) 
                           (remainder 40 (remainder 206 40))))))

(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40) 
                           (remainder 40 (remainder 206 40)))))

(if (= (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40) 
                           (remainder 40 (remainder 206 40)))) 0)
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
  (gcd (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40) 
                           (remainder 40 (remainder 206 40))))
       (remainder (remainder (remainder 206 40) 
                             (remainder 40 (remainder 206 40)))
             (remainder (remainder 40 (remainder 206 40))
                        (remainder (remainder 206 40) 
                                   (remainder 40 (remainder 206 40)))))))

(if (= 0 0) ; +7 evals
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
  (gcd (remainder (remainder 40 (remainder 206 40))
                (remainder (remainder 206 40) 
                           (remainder 40 (remainder 206 40))))
       (remainder (remainder (remainder 206 40) 
                             (remainder 40 (remainder 206 40)))
             (remainder (remainder 40 (remainder 206 40))
                        (remainder (remainder 206 40) 
                                   (remainder 40 (remainder 206 40)))))))

(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
2 ; +4 evals

;;; So, with normal order evaluation, `remainder` gets performed
;;;   1 + 2 + 4 + 7 + 4 = 18 times.


;;; Applicative-order Evaluation
;;; Note that we skip writing out the if statements because we evaluate the
;;;   arguments to `gcd` before entering the procedure.
(gcd 206 40)
(gcd 40 (remainder 206 40))
(gcd 40 6) ; +1 eval
(gcd 6 (remainder 40 6))
(gcd 6 4) ; +1 eval
(gcd 4 (remainder 6 4))
(gcd 4 2) ; +1 eval
(gcd 2 (remainder 4 2))
(gcd 2 0) ; +1 eval
2

;;; So, with applicative-order evaluation, `remainder` gets performed 4 times.

