(define example '(-68 -30 48 -5 60 -55 -1 -99 14 -82 ))
(load "input.scm")

(define (part1 position password distances)
  (if (null? distances)
    password
    ((lambda (new-position)
       (part1 new-position
	      (+ password (if (zero? new-position) 1 0))
	      (cdr distances)))
     (modulo (+ position (car distances)) 100))))

(define (part2 position password distances)
  (if (null? distances)
    password
    ((lambda (new-position)
       (part2 (modulo new-position 100)
	      (if (<= new-position 0)
		(+ password (quotient new-position -100) (if (zero? position) 0 1))
		(+ password (quotient new-position 100)))
	      (cdr distances)))
     (+ position (car distances)))))

(display (part1 50 0 example)) (newline)
(display (part1 50 0 input)) (newline)
(display (part2 50 0 example)) (newline)
(display (part2 50 0 input)) (newline)
