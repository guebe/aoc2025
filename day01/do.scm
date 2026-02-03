(define example '(-68 -30 48 -5 60 -55 -1 -99 14 -82))
(load "input.scm")
(load "../test.scm")

; part1: count how often the dial reaches zero exactly
(define (part1 start dials acc)
  (if (null? dials)
    acc
    (let ((next (modulo (+ start (car dials)) 100)))
      (part1 next (cdr dials) (+ acc (if (zero? next) 1 0))))))

; part2: count how often the dial crosses zero
(define (part2 start dials acc)
  (if (null? dials)
    acc
    (let ((next (+ start (car dials))))
      (part2 (modulo next 100) (cdr dials)
	     (if (<= next 0)
	         (+ acc (quotient next -100) (if (zero? start) 0 1))
		 (+ acc (quotient next 100)))))))

(test (part1 50 example 0) 3)
(test (part1 50 input 0) 1055)
(test (part2 50 example 0) 6)
(test (part2 50 input 0) 6386)
