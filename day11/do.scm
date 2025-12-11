(import (srfi 1) (memoize))

(define example '(
(aaa you hhh)
(you bbb ccc)
(bbb ddd eee)
(ccc ddd eee fff)
(ddd ggg)
(eee out)
(fff out)
(ggg out)
(hhh ccc fff iii)
(iii out)
))

(define example2 '(
(svr aaa bbb)
(aaa fft)
(fft ccc)
(bbb tty)
(tty ccc)
(ccc ddd eee)
(ddd hub)
(hub fff)
(eee dac)
(dac fff)
(fff ggg hhh)
(ggg out)
(hhh out)
))

(include "input.scm")

(define (get-childs start in)
  (cdr (car (filter (lambda (x) (eq? (car x) start)) in))))

(define (find-path start in)
  (if (eq? start 'out)
      1
      (apply + (map (lambda (x) (find-path x in)) (get-childs start in))))) 

(define (part1 in)
  (find-path 'you in))

(define (find-path2 start in a b)
  (if (eq? start 'out)
      (if (and a b) 1 0)
        (let ((a (or a (eq? start 'dac)))
	      (b (or b (eq? start 'fft))))
	  (apply + (map (lambda (x) (fast-find-path2 x in a b)) (get-childs start in)))))) 

(define fast-find-path2 (memoize find-path2))

(define (part2 in)
  (fast-find-path2 'svr in #f #f))

(display (part1 example)) (newline)
(display (part1 input)) (newline)
(display (part2 example2)) (newline)
(display (part2 input)) (newline)
