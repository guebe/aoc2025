(import (srfi 1) (srfi 95) (chicken bitwise))

(define example '(
( #b0110 (3) (1 3) (2) (2 3) (0 2) (0 1) (3 5 4 7))
( #b01000 (0 2 3 4) (2 3) (0 4) (0 1 2) (1 2 3 4) (7 5 12 7 2))
( #b101110 (0 1 2 3 4) (0 3 4) (0 1 2 4 5) (1 2) (10 11 11 5 10 5))
))

(include "input.scm")

(define (button-combinations lst)
  (if (null? lst)
      '(())
      (let ((rest (button-combinations (cdr lst))))
        (append rest
                (map (lambda (x) (cons (car lst) x)) rest)))))

(define (toggle-button acc x)
  (bitwise-xor acc (arithmetic-shift 1 x)))

(define (toggle-buttons buttons)
  (foldl toggle-button 0 (apply append buttons)))

(define (find-optimum combinations optimum)
  (if (null? combinations)
    10000000000
    (let* ((buttons (car combinations))
	   (result (toggle-buttons buttons))
	   (rest (cdr combinations)))
      (if (= result optimum)
        (length buttons)
        (find-optimum rest optimum)))))

(define (length< a b)
  (< (length a) (length b)))

(define (part1-line-solver line)
  (let* ((light-diagram (car line))
	 (buttons (cdr (take line (- (length line) 1))))
	 (combinations (sort (button-combinations buttons) length<)))
    (find-optimum combinations light-diagram)))
	 
(define (part1 x)
  (apply + (map part1-line-solver x)))

(display (part1 example)) (newline)
(display (part1 input)) (newline)
