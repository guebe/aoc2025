(import (srfi 1) (srfi 95))

(define example-ranges '((3 . 5) (10 . 14) (16 . 20) (12 . 18)))
(define example-ingredients '(1 5 8 11 17 32))

(include "input.scm")

(define (sort-ranges ranges)
  (sort ranges (lambda (a b) (< (car a) (car b)))))

(define (merge-ranges ranges)
  (foldl (lambda (acc x)
	   (let ((first (car acc)))
	     (if (<= (car x) (cdr first))
	       (cons (cons (car first) (max (cdr first) (cdr x))) (cdr acc))
	       (cons x acc))))
	 (list (car ranges))
	 (cdr ranges)))

(define (sum-ranges ranges)
  (foldl (lambda (acc x) (+ acc (- (+ (cdr x) 1) (car x)))) 0 ranges))

(define (part1 ranges ingredients)
  (length (filter (lambda (i) (any (lambda (r) (and (>= i (car r)) (<= i (cdr r)))) ranges)) ingredients)))

(define (part2 ranges)
  (sum-ranges (merge-ranges (sort-ranges ranges))))

(display (part1 example-ranges example-ingredients)) (newline)
(display (part1 input-ranges input-ingredients)) (newline)
(display (part2 example-ranges)) (newline)
(display (part2 input-ranges)) (newline)

