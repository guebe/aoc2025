(import (srfi 1))

(define example '(
"..............."
".......^......."
"..............."
"......^.^......"
"..............."
".....^.^.^....."
"..............."
"....^.^...^...."
"..............."
"...^.^...^.^..."
"..............."
"..^...^.....^.."
"..............."
".^.^.^.^.^...^."
"..............."
))

(include "input.scm")

(define (filter-splitter splitter)
  (filter
    (lambda (pos) (char=? (list-ref splitter pos) #\^))
    (iota (length splitter))))

(define (part1-filter-colide splitters beams)
  (filter (lambda (beam) (member beam splitters)) beams))

(define (part1-filter-non-colide splitters beams)
  (filter (lambda (beam) (not (member beam splitters))) beams))

(define (part1-colide-or-pass splitters beams)
  (let* ((colisions (part1-filter-colide splitters beams))
	 (non-colisions (part1-filter-non-colide splitters beams))
	 (left-colisions (map (lambda (x) (- x 1)) colisions))
	 (right-colisions (map (lambda (x) (+ x 1)) colisions)))
    (cons
      (length colisions)
      (delete-duplicates (append non-colisions left-colisions right-colisions)))))

(define (part1-step state splitters)
  (let* ((num (car state))
	 (beams (cdr state))
	 (next (part1-colide-or-pass splitters beams))
	 (new-num (car next))
	 (new-beams (cdr next)))
    (cons (+ num new-num) new-beams)))

(define (part1 x x-beams)
  (car (foldl part1-step (cons 0 x-beams) (map filter-splitter (map string->list x)))))

(define (part2-filter-colide splitters beams)
  (filter (lambda (beam) (member (car beam) splitters)) beams))

(define (part2-filter-non-colide splitters beams)
  (filter (lambda (beam) (not (member (car beam) splitters))) beams))

(define (same-beam? b1 b2) (= (car b1) (car b2)))

(define (merge-duplicates acc beam)
  (let ((same-beam (filter (lambda (x) (same-beam? x beam)) acc))
        (not-same-beam (filter (lambda (x) (not (same-beam? x beam))) acc)))
    (if (null? same-beam)
      (cons beam acc)
      (cons (cons (car beam) (+ (cdr (car same-beam)) (cdr beam))) not-same-beam))))

(define (part2-colide-or-pass beams splitters)
  (let* ((colisions (part2-filter-colide splitters beams))
         (non-colisions (part2-filter-non-colide splitters beams))
	 (left-colisions (map (lambda (x) (let ((beam (car x))(multiplier (cdr x))) (cons (- beam 1) multiplier))) colisions))
	 (right-colisions (map (lambda (x) (let ((beam (car x))(multiplier (cdr x))) (cons (+ beam 1) multiplier))) colisions)))
    (foldl merge-duplicates '() (append non-colisions left-colisions right-colisions))))

(define (add-beam state r)
  (+ state (cdr r)))

(define (part2 x x-beams)
  (foldl add-beam 0 (foldl part2-colide-or-pass x-beams (map filter-splitter (map string->list x)))))

(display (part1 example '(7))) (newline)
(display (part1 input '(70))) (newline)
(display (part2 example '((7 . 1)))) (newline)
(display (part2 input '((70 . 1)))) (newline)
