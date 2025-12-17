(import (srfi 1))

(include "input.scm")

(define (solve-line x)
  (let* ((dimension (car x))
        (presents (cdr x))
	(num-presents (fold + 0 presents))
	(dimension-x (quotient (car dimension) 3))
	(dimension-y (quotient (cadr dimension) 3))
	(dimension-xy (* dimension-x dimension-y)))
    ;(display dimension) (newline)
    ;(display presents) (newline)
    ;(display num-presents) (newline))
    (<= num-presents dimension-xy)))


(define (part1 x)
  (length (filter solve-line x)))

(display (part1 input)) (newline)
