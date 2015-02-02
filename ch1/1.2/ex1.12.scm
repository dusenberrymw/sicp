;;;; Ex 1.12

;;; Goal here is to write a procedure that can compute any given element of
;;;   Pascal's triangle.
;;; Assume elements can be indexed by (row, col), and that rows and columns
;;;   always start at 1

;;; Recursive procedure generating recursive process
(define (pascals-triangle row col)
  (cond ((or (< col 1) (> col row)) 0) ;outside the triangle
        ((or (= col 1) (= col row)) 1) ;first and last in any row are 1
        (else (+ (pascals-triangle (- row 1) (- col 1))
                 (pascals-triangle (- row 1) col))))) 


