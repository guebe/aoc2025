(import (srfi 1))

(define example '(987654321111111 811111111111119 234234234234278 818181911112111))

(include "input.scm")

(define (number->digits number)
  (map (lambda (x) (- (char->integer x) 48)) (string->list (number->string number))))

(define (digits->number digits)
  (string->number (list->string (map (lambda (x) (integer->char (+ x 48))) digits))))

(define (solve digits k)
  (if (= k 0)
    '()
    (let* ((window (take digits (- (length digits) (- k 1))))
	   (best (fold max 0 window))
	   (rest (cdr (drop-while (lambda (x) (not (= x best))) digits))))
      (cons best (solve rest (- k 1))))))

(define (solve-sum in k)
  (apply + (map (lambda (x) (digits->number (solve (number->digits x) k))) in)))

(display (solve-sum example 2)) (newline)
(display (solve-sum input 2)) (newline)
(display (solve-sum example 12)) (newline)
(display (solve-sum input 12)) (newline)
