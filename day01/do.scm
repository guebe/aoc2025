(define example '(-68 -30 48 -5 60 -55 -1 -99 14 -82))
(load "input.scm")

(define (part1 start result dials)
  (if (null? dials)
    result
    (let ((next (modulo (+ start (car dials)) 100)))
      (part1 next
	     (+ result (if (zero? next) 1 0))
	     (cdr dials)))))

(define (part2 start result dials)
  (if (null? dials)
    result
    (let ((next (+ start (car dials))))
      (part2 (modulo next 100)
	     (if (<= next 0)
	         (+ result (quotient next -100) (if (zero? start) 0 1))
	         (+ result (quotient next 100)))
	     (cdr dials)))))

(display (part1 50 0 example)) (newline)
(display (part1 50 0 input)) (newline)
(display (part2 50 0 example)) (newline)
(display (part2 50 0 input)) (newline)
