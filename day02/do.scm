(import (srfi 1) (chicken irregex))

(define example '((11 22) (95 115) (998 1012) (1188511880 1188511890) (222220 222224) (1698522 1698528) (446443 446449) (38593856 38593862) (565653 565659) (824824821 824824827) (2121212118 2121212123)))

(include "input.scm")

(define (solve re ranges) (fold + 0 (map string->number (filter (lambda (x) (irregex-match? re x)) (map number->string (append-map (lambda (x) (let ((lo (car x)) (hi (cadr x))) (iota (- (+ hi 1) lo) lo))) ranges))))))
(display (solve (irregex "^(.+)\\1$") example)) (newline)
(display (solve (irregex "^(.+)\\1$") input)) (newline)
(display (solve (irregex "^(.+)\\1{1,}$") example)) (newline)
(display (solve (irregex "^(.+)\\1{1,}$") input)) (newline)
