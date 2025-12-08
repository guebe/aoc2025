(import (srfi 1) (srfi 95))

(define example '(
(162 817 812)
(57 618 57)
(906 360 560)
(592 479 940)
(352 342 300)
(466 668 158)
(542 29 236)
(431 825 988)
(739 650 466)
(52 470 668)
(216 146 977)
(819 987 18)
(117 168 530)
(805 96 715)
(346 949 466)
(970 615 88)
(941 993 340)
(862 61 35)
(984 92 344)
(425 690 689)
))

(include "input.scm")

(define (combinations2 acc li1 li2)
  (if (null? li2)
      acc
      (combinations2
	(append acc (map (lambda (x) (list (car li1) x)) li2))
	(cdr li1)
	(cdr li2))))

(define (combinations li1)
  (combinations2 '() li1 (cdr li1)))

(define (distance2 a b)
  (let ((p1 (car a))
	(p2 (cadr a))
	(p3 (caddr a))
	(q1 (car b))
	(q2 (cadr b))
	(q3 (caddr b)))
    (sqrt (+ (expt (- p1 q1) 2) (expt (- p2 q2) 2) (expt (- p3 q3) 2)))))

(define (distance li pair)
  (distance2 (list-ref li (car pair)) (list-ref li (cadr pair))))

(define (distance< a b)
  (< (car a) (car b)))

(define (length< a b)
  (< (length a) (length b)))

(define (part1-step acc x)
  (let* ((a (cadr x))
	 (b (caddr x))
	 (A (car (filter (lambda (y) (member a y)) acc)))
	 (B (car (filter (lambda (y) (member b y)) acc)))
	 (C (filter (lambda (y) (not (or (member a y) (member b y)))) acc)))
    (cons (lset-union = A B) C)))

(define (part1 x n)
  (let 
    ((shortlist (take (sort (map (lambda (y) (cons (distance x y) y)) (combinations (iota (length x)))) distance< ) n))
     (setlist (map list (iota (length x)))))
    (apply * (take (sort (map length (foldl part1-step setlist shortlist)) >) 3))
    ))

(define (part2-step acc xx)
  (let* ((x (car xx))
	 (a (cadr x))
	 (b (caddr x))
	 (A (car (filter (lambda (y) (member a y)) acc)))
	 (B (car (filter (lambda (y) (member b y)) acc)))
	 (C (filter (lambda (y) (not (or (member a y) (member b y)))) acc)))
    (if (null? C)
        x
	(part2-step (cons (lset-union = A B) C) (cdr xx)))))

(define (part2 x)
  (let*
    ((shortlist (sort (map (lambda (y) (cons (distance x y) y)) (combinations (iota (length x)))) distance< ))
     (setlist (map list (iota (length x))))
     (res (part2-step setlist shortlist)))
     (* (car (list-ref x (cadr res))) (car (list-ref x (caddr res))))))

(display (part1 example 10)) (newline)
(display (part1 input 1000)) (newline)
(display (part2 example)) (newline)
(display (part2 input)) (newline)
