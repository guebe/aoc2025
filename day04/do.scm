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
(define (point+ p1 p2) (cons (+ (car p1) (car p2)) (+ (cdr p1) (cdr p2))))
(define (grid-height grid) (length grid))
(define (grid-width grid) (length (car grid)))
(define (grid-ref grid point) (list-ref (list-ref grid (car point)) (cdr point)))
(define grid-directions8 '((-1 . -1) (-1 . 0) (-1 . 1) (0 . -1) (0 . 1) (1 . -1) (1 . 0) (1 . 1)))
(define (grid-in-bounds? grid point)
  (let ((r (car point)) (c (cdr point)))
    (and (>= r 0) (>= c 0) (< r (grid-height grid)) (< c (grid-width grid)))))
(define (grid-neighbors grid directions point)
  (filter
    (lambda (point) (grid-in-bounds? grid point))
    (map (lambda (direction) (point+ point direction)) directions)))
(define (grid-points grid)
  (append-map
    (lambda (r) (map (lambda (c) (cons r c)) (iota (grid-width grid))))
    (iota (grid-height grid))))

(define (get-rolls grid)
  (filter
    (lambda (point) (char=? (grid-ref grid point) #\@))
    (grid-points grid)))

(define (<4-neighbor-rolls rolls)
  (let ((rolls-hash (make-hash-table)))
    (for-each (lambda (x) (hash-table-set! rolls-hash x #t)) rolls)
    (filter
      (lambda (x)
	(< (length (filter (lambda (y) (hash-table-exists? rolls-hash y))
			   (grid-neighbors grid grid-directions8 x))) 4))
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
(test (length (<4-neighbor-rolls (get-rolls grid))) 13)
(test (length (part2 (get-rolls grid))) 43)
(define grid (map string->list input))
(test (length (<4-neighbor-rolls (get-rolls grid))) 1367)
(test (length (part2 (get-rolls grid))) 9144)
