(define example '((11 22) (95 115) (998 1012) (1188511880 1188511890) (222220 222224) (1698522 1698528) (446443 446449) (38593856 38593862) (565653 565659) (824824821 824824827) (2121212118 2121212123)))
(load "input.scm")

(define (repeats-rec? n n-len p p-len start)
  (if (>= start n-len)
      #t
      (let ((end (+ start p-len)))
        (and (string=? (substring n start end) p)
             (repeats-rec? n n-len p p-len end)))))

; returns #t if the string n is made of repeating string p, false otherwise
(define (repeats? n p)
  (let ((n-len (string-length n))
	(p-len (string-length p)))
    (and (> p-len 0)
	 (< p-len n-len)
	 (= 0 (modulo n-len p-len))
         (repeats-rec? n n-len p p-len p-len))))

; part 1: check if number is its first half repeated
(define (part1-valid? n)
  (let* ((n (number->string n))
	 (n-len (string-length n)))
    (and (= 0 (modulo n-len 2))
	 (repeats? n (substring n 0 (quotient n-len 2))))))

(define (part2-valid-rec? n start end)
  (if (> start end)
    #f
    (or (repeats? n (substring n 0 start))
	(part2-valid-rec? n (+ start 1) end))))

; part 2: check if number repeats by any pattern
(define (part2-valid? n)
  (let ((n (number->string n)))
    (part2-valid-rec? n 1 (quotient (string-length n) 2))))

; sum valid numbers in range
(define (sum-range f start end)
  (if (> start end)
      0
      (+ (if (f start) start 0) (sum-range f (+ start 1) end))))

; solve across mulitple ranges
(define (solve f ranges)
  (if (null? ranges)
      0
      (+ (sum-range f (caar ranges) (cadar ranges)) (solve f (cdr ranges)))))

(display (solve part1-valid? example)) (newline)
(display (solve part1-valid? input)) (newline)
(display (solve part2-valid? example)) (newline)
(display (solve part2-valid? input)) (newline)
