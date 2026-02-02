(define example '(987654321111111 811111111111119 234234234234278 818181911112111))
(load "input.scm")

(define (take n lst)
  (if (or (= n 0) (null? lst))
      '()
      (cons (car lst) (take (- n 1) (cdr lst)))))

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
    (let* ((window (take (- (length digits) k -1) digits))
	   (best (apply max window))
	   (rest (cdr (memv best digits))))
      (cons best (solve rest (- k 1))))))

(define (solve-sum in k)
  (apply + (map (lambda (x) (digits->number (solve (number->digits x) k))) in)))

(display (solve-sum example 2)) (newline)
(display (solve-sum input 2)) (newline)
(display (solve-sum example 12)) (newline)
(display (solve-sum input 12)) (newline)
