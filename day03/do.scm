(define example '(987654321111111 811111111111119 234234234234278 818181911112111))
(load "input.scm")

(define (take lis k)
  (if (zero? k)
      '()
      (cons (car lis)
	    (take (cdr lis) (- k 1)))))

(define (fold f acc lis)
  (if (null? lis)
      acc
      (fold f (f (car lis) acc) (cdr lis))))

(define (number->digits number)
  (define (f number acc)
    (if (= number 0)
        acc
        (f (quotient number 10) (cons (modulo number 10) acc))))
  (f number '()))

(define (digits->number digits)
  (define (f digits acc)
    (if (null? digits)
        acc
	(f (cdr digits) (+ (* acc 10) (car digits)))))
  (f digits 0))

(define (solve digits k)
  (if (= k 0)
    '()
    (let* ((window (take digits (- (length digits) k -1)))
	   (best (apply max window))
	   (rest (cdr (memv best digits))))
      (cons best (solve rest (- k 1))))))

(define (solve-sum in k)
  (apply + (map (lambda (x) (digits->number (solve (number->digits x) k))) in)))

(display (solve-sum example 2)) (newline)
(display (solve-sum input 2)) (newline)
(display (solve-sum example 12)) (newline)
(display (solve-sum input 12)) (newline)
