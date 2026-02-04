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
(load "../srfi-1.scm")

(define *directions* '((-1 . -1) (-1 . 0) (-1 . 1)
                      (0 . -1)           (0 . 1)
                      (1 . -1)  (1 . 0)  (1 . 1)))

;; Check paper rolls (@) in on-grid neighbors (8 directions).
;; Returns #t if >= 4 rolls found (early-exit).
;; Returns #f otherwise.
;; This function is tail recursive
(define (forklift-access? point rolls)
  (define (recur d acc)
    (if (or (null? d) (= acc 4))
	(< acc 4) 
	(let* ((dir (car d)) ;; dir is pair (row . column)
	       (r (+ (car dir) (quotient point 1024)))
	       (c (+ (cdr dir) (modulo point 1024))))
	  (if (and (>= r 0) (>= c 0) (< r grid-height) (< c grid-width)
		   (memv (+ c (* 1024 r)) rolls))
	      (recur (cdr d) (+ 1 acc))
	      (recur (cdr d) acc)))))
  (recur *directions* 0))

;; make a lists of points where we found a roll
;; point is encoded as number=row*1024 + column
;; This is O(N) in space and time
;; This function is tail recursive
(define (make-rolls grid)
  (define (scan-rows rows r acc)
    (if (null? rows)
        acc
        (scan-rows (cdr rows) (+ r 1) (scan-cols (car rows) r 0 acc))))
  (define (scan-cols cols r c acc)
    (if (null? cols)
        acc
        (scan-cols (cdr cols) r (+ c 1)
                   (if (char=? #\@ (car cols))
                       (cons (+ c (* r 1024)) acc)
                       acc))))
  (scan-rows grid 0 '()))

(define (count-forklift-access-1 rolls)
  (count (lambda (x) (forklift-access? x rolls)) rolls))

(define (filter-forklift-access rolls)
    (filter (lambda (x) (forklift-access? x rolls)) rolls))

(define (count-forklift-access-2 rolls)
  (define (recur rolls acc)
    (let ((accessible (filter-forklift-access rolls)))
      (if (null? accessible)
	  acc
	  (recur (filter (lambda (p) (not (memv p accessible))) rolls)
		 (+ acc (length accessible))))))
  (recur rolls 0))

(define grid (map string->list example))
(define grid-height (length grid))
(define grid-width (length (car grid)))
(define rolls (make-rolls grid))
(test (count-forklift-access-1 rolls) 13)
(test (count-forklift-access-2 rolls) 43)
(define grid (map string->list input))
(define grid-height (length grid))
(define grid-width (length (car grid)))
(define rolls (make-rolls grid))
(test (count-forklift-access-1 rolls) 1367)
(test (count-forklift-access-2 rolls) 9144)
