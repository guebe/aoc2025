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

(define (add-button acc button)
  (let ((idx (car acc))
	(lst (cdr acc)))
    (display idx) (newline)
    (display lst) (newline)))

(define (process-buttons result i buttons activation)
  (if (null? buttons)
    (sort result <)
    (let* ((first-buttons (car buttons))
	   (other-buttons (cdr buttons))
	   (result (if (member activation first-buttons) (cons i result) result)))
      (process-buttons result (+ i 1) other-buttons activation))))

(define (part2-line-solver line)
  (let* ((buttons (cdr (take line (- (length line) 1))))
	 (results (car (drop line (- (length line) 1))))
	 (number-buttons (length buttons))
	 (number-results (length results))
	 (button-result-map (map (lambda (x) (process-buttons '() 0 buttons x)) (iota number-results))))
    (map (lambda (x) (begin
		       (display "(declare-const b") (display x) (display " Int)")(newline)
		       (display "(assert (>= b") (display x) (display " 0))")(newline)
		       )) (iota number-buttons))
    (map (lambda (x) 
	   (let ((res (car x))
	         (btns (car (cdr x))))
	     (display "(assert (= ") (display res) (display " (+") 
	     (map (lambda (x) (begin (display " b") (display x))) btns)
	     (display ")))") (newline)))
	 (apply map list (cons results (list button-result-map))))
    (display "(define-fun joltage () Int (+")
    (map (lambda (x) (begin (display " b") (display x))) (iota number-buttons))
    (display "))") (newline)
    (display "(minimize joltage)") (newline)
    (display "(check-sat)") (newline)
    (display "(get-value (joltage))") (newline)
    (display "(reset)") (newline)
    ))

(define (part2 x)
  (map part2-line-solver x))

;(display (part1 example)) (newline)
;(display (part1 input)) (newline)
;(part2 example)
(part2 input)
