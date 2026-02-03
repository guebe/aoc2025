(import (srfi 1) (srfi 69))

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
(define (grid-ref grid point) (list-ref (list-ref grid (car point)) (cdr point)))

;; gets all points neighboring (in 8 directions) point, but only if the new
;; point is inside grid dimensions
(define (neighbors point)
  (let ((directions '((-1 . -1) (-1 . 0) (-1 . 1) (0 . -1) (0 . 1) (1 . -1) (1 . 0) (1 . 1))))
    (filter (lambda (p) (let ((r (car p)) (c (cdr p))) (and (>= r 0) (>= c 0) (< r grid-height) (< c grid-width))))
	    (map (lambda (d) (cons (+ (car point) (car d)) (+ (cdr point) (cdr d))))
		 directions))))

(define (get-rolls grid)
  (filter (lambda (point) (char=? (grid-ref grid point) #\@))
	  (append-map (lambda (r) (map (lambda (c) (cons r c)) 
				       (iota grid-width)))
		      (iota grid-height))))

(define (<4-neighbor-rolls rolls)
  (let ((rolls-hash (make-hash-table)))
    (for-each (lambda (x) (hash-table-set! rolls-hash x #t)) rolls)
    (filter
      (lambda (x)
	(< (length (filter (lambda (y) (hash-table-exists? rolls-hash y))
			   (neighbors x))) 4))
      rolls)))

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
