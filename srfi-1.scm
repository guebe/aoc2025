(define (take lis k)
  (if (zero? k)
      '()
      (cons (car lis)
	    (take (cdr lis) (- k 1)))))

(define (unfold-right p f g seed)
  (define (lp seed ans)
    (if (p seed)
        ans
	(lp (g seed)
	    (cons (f seed) ans))))
  (lp seed '()))

(define (unfold p f g seed)
  (if (p seed)
      '()
      (cons (f seed)
	    (unfold p f g (g seed)))))

(define (fold kons knil lis)
  (if (null? lis)
      knil
      (fold kons (kons (car lis) knil) (cdr lis))))

(define (drop-while pred lis)
  (define (lp lis)
    (if (null? lis)
        '()
	(if (pred (car lis))
	    (lp (cdr lis))
	    lis)))
  (lp lis))
