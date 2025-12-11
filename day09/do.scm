(import (srfi 1) (srfi 95))

(define example '(
(7 1)
(11 1)
(11 7)
(9 7)
(9 5)
(2 5)
(2 3)
(7 3)
))

(include "input.scm")

(define (combinations-impl acc li1 li2)
  (if (null? (cdr li1))
    acc
    (if (null? li2)
      (combinations-impl
	acc
	(cdr li1)
	(cddr li1))
      (combinations-impl
	(cons (list (car li1) (car li2)) acc)
	li1
	(cdr li2)))))

(define (combinations li1)
  (reverse (combinations-impl '() li1 (cdr li1))))

(define (get-rectangle li pair)
  (list (list-ref li (car pair)) (list-ref li (cadr pair))))

(define (get-rectangles x)
  (map (lambda (y) (get-rectangle x y)) (combinations (iota (length x)))))

(define (area rectangle)
  (let ((x1 (caar rectangle))
	(y1 (cadar rectangle))
	(x2 (caadr rectangle))
	(y2 (cadadr rectangle)))
    (* (+ (abs (- x1 x2)) 1) (+ (abs (- y1 y2)) 1))))

(define (part1 x)
  (car (take (sort (map area (get-rectangles x)) >) 1)))

(define (get-polygon-impl acc in)
  (if (null? (cdr in))
    (reverse acc)
    (get-polygon-impl (cons (list (car in) (cadr in)) acc) (cdr in))))

(define (get-polygon x)
  (get-polygon-impl '() (append x (list (car x)))))

(define (inside? rectangle polygon)
  (let ((x1 (caar rectangle))
	(y1 (cadar rectangle))
	(x2 (caadr rectangle))
	(y2 (cadadr rectangle)))
    (every (lambda (x)
	     (let ((px1 (caar x))
		   (py1 (cadar x))
		   (px2 (caadr x))
		   (py2 (cadadr x)))
	       (or (>= (min py1 py2) (max y1 y2))
		   (<= (max py1 py2) (min y1 y2))
		   (>= (min px1 px2) (max x1 x2))
		   (<= (max px1 px2) (min x1 x2))))) polygon)))

(define (part2 x)
  (let* ((polygon (get-polygon x)))
    (car (take (sort (map area (filter (lambda (y) (inside? y polygon)) (get-rectangles x))) >) 1))))

(display (part1 example)) (newline)
(display (part1 input)) (newline)
(display (part2 example)) (newline)
(display (part2 input)) (newline)
