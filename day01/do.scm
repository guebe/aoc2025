(define example '(-68 -30 48 -5 60 -55 -1 -99 14 -82))
(load "input.scm")

; part1: count how often the dial reaches zero exactly
(define (part1 start dials)
  (if (null? dials)
    0
    (let ((next (modulo (+ start (car dials)) 100)))
      (+ (if (zero? next) 1 0)
	 (part1 next (cdr dials))))))

; part2: count how often the dial crosses zero
(define (part2 start dials)
  (if (null? dials)
    0
    (let ((next (+ start (car dials))))
      (+ (if (<= next 0)
	     (+ (quotient next -100) (if (zero? start) 0 1))
	     (quotient next 100))
	 (part2 (modulo next 100) (cdr dials))))))

(display (part1 50 example)) (newline)
(display (part1 50 input)) (newline)
(display (part2 50 example)) (newline)
(display (part2 50 input)) (newline)
