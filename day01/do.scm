(define example '(-68 -30 48 -5 60 -55 -1 -99 14 -82))
(load "input.scm")

(define (step1 state r)
  (let ((x (modulo (+ (car state) r) 100)))
    (cons x
	  (+ (cdr state)
	     (if (= x 0)
	         1
	         0)))))

(define (step2 state r)
  (let ((x (+ (car state) r)))
    (cons (modulo x 100)
	  (+ (cdr state)
	     (if (<= x 0)
	         (+ (quotient x -100) (if (zero? (car state)) 0 1))
	         (quotient x 100))))))

(define (part1 x)
  (cdr (foldl step1 (cons 50 0) x)))

(define (part2 x)
  (cdr (foldl step2 (cons 50 0) x)))

(display (part1 example)) (newline)
(display (part1 input)) (newline)
(display (part2 example)) (newline)
(display (part2 input)) (newline)
