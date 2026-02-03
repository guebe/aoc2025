(import (srfi 1))

(define example '(
"..@@.@@@@."
"@@@.@.@.@@"
"@@@@@.@.@@"
"@.@@@@..@."
"@@.@@@@.@@"
".@@@@@@@.@"
".@.@.@.@@@"
"@.@@@.@@@@"
".@@@@@@@@."
"@.@.@@@.@."
))

(load "input.scm")
(load "../test.scm")

;; point is (row . column)
;; point is (row * 1024 + column)

;; gets all points neighboring (in 8 directions) point, but only if the new
;; point is inside grid dimensions
(define (neighbors point rolls)
  (define directions '((-1 . -1) (-1 . 0) (-1 . 1) (0 . -1) (0 . 1) (1 . -1) (1 . 0) (1 . 1)))
  (define (recur d acc)
    (if (or (null? d) (>= acc 4))
        (< acc 4) 
	(let ((x (car d)))
          (let ((r (+ (car x) (quotient point 1024)))
	        (c (+ (cdr x) (modulo point 1024))))
	    (if (and (>= r 0) (>= c 0) (< r grid-height) (< c grid-width) (memv (+ c (* 1024 r)) rolls))
	        (recur (cdr d) (+ 1 acc))
	        (recur (cdr d) acc))))))
  (recur directions 0))

(define (get-rolls grid)
  (append-map (lambda (r) (let ((row (list-ref grid r)))
			    (filter-map (lambda (c) (if (char=? #\@ (list-ref row c)) (+ c (* r 1024)) #f))
					(iota grid-width))))
	      (iota grid-height)))

(define (<4-neighbor-rolls rolls)
    (filter
      (lambda (x) (neighbors x rolls))
      rolls))

(define (part2 rolls)
  (let loop ((state rolls)
	     (acc '()))
    (let ((result (<4-neighbor-rolls state)))
      (if (null? result)
	acc
	(loop
	  (filter (lambda (point) (not (member point result))) state)
	  (append acc result))))))

(define grid (map string->list example))
(define grid-height (length grid))
(define grid-width (length (car grid)))
(define rolls (get-rolls grid))
(test (length (<4-neighbor-rolls rolls)) 13)
(test (length (part2 rolls)) 43)
(define grid (map string->list input))
(define grid-height (length grid))
(define grid-width (length (car grid)))
(define rolls (get-rolls grid))
(test (length (<4-neighbor-rolls rolls)) 1367)
(test (length (part2 rolls)) 9144)
