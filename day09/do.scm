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

(define (combinations2 acc li1 li2)
  (if (null? (cdr li1))
    acc
    (if (null? li2)
      (combinations2
	acc
	(cdr li1)
	(cddr li1))
      (combinations2
	(cons (list (car li1) (car li2)) acc)
	li1
	(cdr li2)))))

(define (combinations li1)
  (reverse (combinations2 '() li1 (cdr li1))))

(define (distance2 a b)
  (let ((p1 (car a))
	(p2 (cadr a))
	(q1 (car b))
	(q2 (cadr b)))
    (* (+ (abs (- p1 q1)) 1) (+ (abs (- p2 q2)) 1))))

(define (distance li pair)
  (distance2 (list-ref li (car pair)) (list-ref li (cadr pair))))

(define (distance> a b)
  (> (car a) (car b)))

(define (part1 x)
  (caar (take (sort (map (lambda (y) (cons (distance x y) y)) (combinations (iota (length x)))) distance> ) 1)))

(define (get-polygon acc in)
  (if (null? (cdr in))
    (reverse acc)
    (get-polygon (cons (list (car in) (cadr in)) acc) (cdr in))))

(define (get-rectangle li pair)
  (list (list-ref li (car pair)) (list-ref li (cadr pair))))

(define (filter-inside rectangle polygon)
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
  (let ((polygon (get-polygon '() (append x (list (car x)))))
	(rectangles (map (lambda (y) (get-rectangle x y)) (combinations (iota (length x))))))
    (car (take (sort(map (lambda (y) (distance2 (car y) (cadr y)))
	 (filter (lambda (x) (filter-inside x polygon)) rectangles)
	 ) >) 1))
    ))

(display (part1 example)) (newline)
(display (part1 input)) (newline)
(display (part2 example)) (newline)
(display (part2 input)) (newline)
