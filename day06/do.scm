(import (srfi 1))

(define example1 '(
(123 328  51 64)
( 45 64  387 23)
(  6 98  215 314)
(*   +   *   +)
))


(define example2-nums '(
"123 328  51 64 "
" 45 64  387 23 "
"  6 98  215 314"
))

(define example2-ops '( *   +   *   +))

(include "input.scm")

(define (transpose matrix)
  (if (every null? matrix)
    '()
    (cons (map car matrix) (transpose (map cdr matrix)))))

(define (part1 x)
  (apply + (map eval (map reverse (transpose x)))))

(define (space? x) (char=? x #\space))

(define (not-space? x) (not (space? x)))

(define (all-spaces? x) (every space? x))

(define (filter-not-spaces x) (filter not-space? x))

(define (whitespace-list->number x) (string->number (list->string (filter-not-spaces x))))

(define (split-columns x)
  (if (null? x)
    '()
    (let-values (((list1 list2) (break all-spaces? x)))
      (cons list1
	    (if (null? list2)
	      '()
	      (split-columns (cdr list2)))))))

(define (part2 nums ops)
  (let* ((chars (split-columns (transpose (map string->list nums))))
	 (ints (map (lambda (x) (map whitespace-list->number x)) chars)))
    (apply + (map eval (map cons ops ints)))))

(display (part1 example1)) (newline)
(display (part1 input1)) (newline)
(display (part2 example2-nums example2-ops)) (newline)
(display (part2 input2-nums input2-ops)) (newline)
