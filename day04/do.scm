;(import (scheme r5rs))
;(load "../../femtolisp/aliases.scm")
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

(define (is-roll? r c)
  (char=? #\@ (string-ref (list-ref grid r) c)))

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
		   (is-roll? r c))
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
    (if (>= c (string-length cols))
        acc
        (scan-cols cols r (+ c 1)
                   (if (char=? #\@ (string-ref cols c))
                       (cons (+ c (* r 1024)) acc)
                       acc))))
  (scan-rows grid 0 '()))

(define (count-forklift-access-1 rolls)
  (count (lambda (x) (forklift-access? x rolls)) rolls))

(define (remove-roll! r c)
  (string-set! (list-ref grid r) c #\.))

;  (define (recur i c rest)
;    ;(display c)
;    ;(newline)
;    (if (null? rest)
;        i
;	(if (forklift-access? (car rest) rolls)
;	    (recur (+ i 1) (+ c 1) (cdr rest))
;	    (recur i (+ c 1) (cdr rest)))))
;  (recur 0 0 rolls))

(define (filter-forklift-access rolls)
  (filter (lambda (x) (forklift-access? x rolls)) rolls))

(define (count-forklift-access-2 rolls)
  (define (recur rolls acc)
    (let ((accessible (filter-forklift-access rolls)))
      (if (null? accessible)
	  acc
	  ((lambda ()
	  (for-each (lambda (p) (remove-roll! (quotient p 1024) (modulo p 1024)))
                    accessible)
	  (recur (filter (lambda (p) (not (memv p accessible))) rolls)
		 (+ acc (length accessible))))))))
  (recur rolls 0))

(define grid example)
(define grid-height (length grid))
(define grid-width (string-length (car grid)))
(define rolls (make-rolls grid))
(test (count-forklift-access-1 rolls) 13)
(test (count-forklift-access-2 rolls) 43)
(define grid input)
(define grid-height (length grid))
(define grid-width (string-length (car grid)))
(define rolls (make-rolls grid))
(test (count-forklift-access-1 rolls) 1367)
(test (count-forklift-access-2 rolls) 9144)
