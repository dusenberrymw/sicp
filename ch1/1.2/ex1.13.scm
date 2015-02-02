;;;; Ex 1.13

;;; The **goal** here is to prove that Fib(n) is the _closest integer_ to
;;;   phi^n / sqrt(5), where phi = (1 + sqrt(5))/2.
;;;
;;; Hint: let psi = (1 - sqrt(5))/2
;;;
;;; Also, phi is the golden ratio, and satisfies the following:
;;;   phi^2 = phi + 1
;;;
;;; And psi also satisfies the following:
;;;   psi^2 = psi + 1
;;;
;;; Hint: As a means to solve the overall proof, use induction and the 
;;;   definition of the Fibonacci numbers to prove that 
;;;     Fib(n) = (phi^n - psi^n) /  sqrt(5)  [EQ1]
;;;

;;; Base Cases: Show that the EQ1 statement holds for n=0 and n=1
;;;
;;; Fib(0)  = (phi^0 - psi^0) / sqrt(5)
;;; 0       = (1 - 1) / sqrt(5)
;;; 0       = (0) / sqrt(5)
;;; 0       = 0
;;;
;;; Fib(1)  = (phi^1 - psi^1) / sqrt(5)
;;; 1       = (phi - psi) / sqrt(5)
;;; 1       = ((1 + sqrt(5))/2 - (1 - sqrt(5))/2) / sqrt(5)
;;; 1       = (1/2 + sqrt(5)/2 - (1/2 - sqrt(5)/2) / sqrt(5)
;;; 1       = (1/2 + sqrt(5)/2 - 1/2 + sqrt(5)/2) / sqrt(5)
;;; 1       = sqrt(5) / sqrt(5)
;;; 1       = 1
;;;
;;; We have shown that the EQ1 statement is true for n=0 and n=1
;;;

;;; Inductive step: Show that if the EQ1 statement is true for n-1, and n-2, 
;;;   then it holds for n
;;;
;;; Fib(n)  = Fib(n-1) + Fib(n-2) = ((phi^(n-1) - psi^(n-1)) / sqrt(5)) 
;;;                                 + ((phi^(n-2) - psi^(n-2)) / sqrt(5))
;;;      = (phi^(n-1) - psi^(n-1) + phi^(n-2) - psi^(n-2)) / sqrt(5)
;;;      = (phi^(n-1) + phi^(n-2) - psi^(n-1) - psi^(n-2)) / sqrt(5)
;;;      = ((phi + 1) * phi^(n-2) - (psi + 1) * (psi^(n-2))) / sqrt(5)
;;; and using phi^2 = phi + 1,
;;;      = (phi^2 * phi^(n-2) - psi^2 * psi^(n-2)) / sqrt(5)
;;;      = (phi^n - psi^n) / sqrt(5)
;;;
;;; We have shown that the EQ1 statement is true for n
;;;   Fib(n) = (phi^n - psi^n) / sqrt(5)
;;;

;;; Final proof
;;;
;;; Given the EQ1 statement as true, prove that
;;;   Fib(n) is the closest integer to phi^n / sqrt(5)
;;;
;;; We have just shown the following:
;;;   Fib(n) = (phi^n - psi^n) / sqrt(5)
;;;
;;; Which we can rearrange as follows:
;;;   Fib(n) = (phi^n - psi^n) / sqrt(5)
;;;   Fib(n) = phi^n/sqrt(5) - psi^n/sqrt(5)
;;;   Fib(n) - phi^n/sqrt(5) = -psi^n/sqrt(5)
;;;   Fib(n) - phi^n/sqrt(5) = -(psi^n/sqrt(5))
;;;
;;; So, we want to prove that Fib(n) is the closest integer to phi^n/sqrt(5),
;;;   or that the difference between Fib(n) and phi^n/sqrt(5) is less than 
;;;   0.5 (absolute difference, so sign doesn't matter)
;;;
;;; So, prove that:
;;;   psi^n/sqrt(5) < 1/2
;;;   psi^n         < sqrt(5)/2
;;;
;;; Since 
;;;   2^2       = 4
;;; so,
;;;   sqrt(5)   > 2
;;;   sqrt(5)/2 > 1
;;; or, another way to write it:
;;;   sqrt(5)/2 = 1.11803...
;;;   sqrt(5)/2 > 1
;;; and 
;;;   psi = (1-sqrt(5))/2
;;;   psi = -0.61803...
;;;   psi < 1
;;; and
;;;   n is an integer, so n >= 0
;;; we can show that
;;;   psi^n <= 1 for all n (which are >= 0)
;;;
;;; So, if
;;;   sqrt(5)/2 > 1
;;; and
;;;   psi^n <= 1
;;; then
;;;   psi^n < sqrt(5)/2
;;; and
;;;   psi^n/sqrt(5) < 1/2
;;;
;;; Therefore, given
;;;   Fib(n) - phi^n/sqrt(5) = -(psi^n/sqrt(5))
;;; we've shown that
;;;   Fib(n) - phi^n/sqrt < -(1/2)
;;;
;;; Thus,
;;;   Fib(n) is the closest integer to phi^n/sqrt(5)
;;;
;;; QED

