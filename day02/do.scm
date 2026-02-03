(define example '((11 22) (95 115) (998 1012) (1188511880 1188511890) (222220 222224) (1698522 1698528) (446443 446449) (38593856 38593862) (565653 565659) (824824821 824824827) (2121212118 2121212123)))
(load "input.scm")
(load "../test.scm")

; returns #t if the string n is made of repeating string p, false otherwise
(define (repeats? n n-len p)
  (define p-len (string-length p))
  (define (recur start)
    (if (>= start n-len)
        #t
        (let ((end (+ start p-len)))
          (and (string=? (substring n start end) p)
               (recur end)))))
  (and (> p-len 0)
       (< p-len n-len)
       (= 0 (modulo n-len p-len))
       (recur p-len)))

; part 1: check if number is its first half repeated
(define (part1-valid? n)
  (define n-len (string-length n))
  (define end (quotient n-len 2))
  (and (= 0 (modulo n-len 2))
       (repeats? n n-len (substring n 0 end))))

; part 2: check if number repeats by any pattern
(define (part2-valid? n)
  (define n-len (string-length n))
  (define end (quotient n-len 2))
  (define (recur start)
    (if (> start end)
        #f
        (or (repeats? n n-len (substring n 0 start))
	    (recur (+ start 1)))))
  (recur 1))

; sum valid numbers in range
(define (sum-range f start end acc)
  (if (> start end)
      acc
      (sum-range f
		 (+ start 1)
		 end
		 (+ acc (if (f (number->string start)) start 0)))))

; solve across multiple ranges
(define (solve f ranges acc)
  (if (null? ranges)
      acc
      (solve f
	     (cdr ranges)
	     (+ acc (sum-range f (car (car ranges)) (car (cdr (car ranges))) 0)))))

(test (solve part1-valid? example 0) 1227775554)
(test (solve part1-valid? input 0) 18893502033)
(test (solve part2-valid? example 0) 4174379265)
(test (solve part2-valid? input 0) 26202168557)
