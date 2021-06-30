;;; _EMAIL_ ddeveci18@ku.edu.tr    _DATE_ 28.10.2019
;;;
;;; Comp200 Project 1
;;;
;;; Due Oct 28, 2019
;;;
;;; Before you start:
;;;
;;; * Please read the detailed instructions for this project from the
;;; file project1.pdf available in the Projects section of the
;;; course website.
;;;
;;; * Please read "Project Submission Instructions" carefully and make
;;; sure you understand everything before you start working on your
;;; project in order to avoid problems.
;;;
;;; While you are working:
;;; * Type all your work and notes in the appropriate sections of this file.
;;; * Please do not delete any of the existing lines.
;;; * Use the procedure names given in the instructions.
;;; * Remember to frequently save (C-x C-s) and check-in (comp101-put) your file.
;;; * Use semicolon (;) to comment out text, tests and unused code.
;;; * Remember to document your code.
;;; * Remember our collaboration policy: you can discuss with your friends but
;;;
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;
;;; When you are done:
;;; * Perform a final save and check-in.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email comp101help@ku.edu.tr if you have any questions.
;;; * Make sure your file loads without errors.
;;;
;;;   *** IF (load "project1.scm") GIVES ERRORS YOUR PROJECT WILL NOT BE GRADED ***
;;;

;_BANNER_
;;; Problem 1: Some Simple Probability Theory

; Description for factorial: (before the definition of each procedure,
; please write a description about what the procedure does and what
; its input and output should be, making sure the lines are commented
; out with semi-colons)

;;Description : multiplies the number n and all the numbers below it until 1
;;number->number

(#%require (only racket/base random))
(define factorial
  (lambda (n)
    (cond ((= n 1) 1)
          ((= n 0) 1)
          (else (* n (factorial (- n 1)))))
    )
  )

; Test cases for factorial: (after the definition of each procedure,
; please cut and paste some test cases you have run, making sure the
; lines are commented out with semi-colons)

(factorial 5 )  ; -> 120
(factorial 5 )  ; -> 120
(factorial 10 )  ; -> 3628800
(factorial 1 )  ; -> 1
(factorial 0 )  ; -> 1
(factorial 8 )  ; -> 40320


;;; Description for binomial: divides n factorial by (n-b) factorial times b factorial
;;(number,number)->number

(define binomial 
  (lambda (n b)
    (if (> b n) 0
    (/ (factorial n)(* (factorial(- n b)) (factorial b)))
    )))

; Test cases for binomial:

(binomial 5 1)  ; -> 5
(binomial 5 2)  ; -> 10
(binomial 10 5)  ; -> 252
(binomial 7 3)  ; -> 35
(binomial 4 8)  ; -> 0

;;; Description for binomial-2: takes care of b>n, b=0 and b=1 and multiplies by n/b each time it calls itself.
;;(number,number)->number


(define binomial-2
  (lambda (n b)
    (cond ((= b 1) (+ 1 (- n b)))
      ((= b 0) 1)
      ((> b n) 0)
      (else (* (/ n b) (binomial-2 (- n 1) (- b 1)))))
))
; Test cases for binomial-2:

(binomial-2 5 1)  ; -> 5
(binomial-2 5 2)  ; -> 10
(binomial-2 10 5)  ; -> 252
(binomial-2 7 3)  ; -> 35
(binomial-2 4 8)  ; -> 0


;;; Description for exactly-b-smarties: multiplies binomial coefficient of b and n,
;;;p to the power of b and (1 - p) to the power of (n - b)
;;(number,number,number)->number

(define exactly-b-smarties 
  (lambda (n b p)
    (* (binomial n b) (expt p b) (expt (- 1 p) (- n b)))

    ))

; Test cases for exactly-b-smarties:

(exactly-b-smarties 1 1 0.5)   ; -> 0.5
(exactly-b-smarties 2 1 0.5)   ; -> 0.5
(exactly-b-smarties 2 2 0.5)   ; -> 0.25
(exactly-b-smarties 2 1 0.3)   ; -> 0.42
(exactly-b-smarties 10 2 0.3)  ; -> 0.23347444049999985

;_BANNER_
;;; Problem 2: More Probability Theory

;;; Description for atleast-b-smarties: returns probability of finding at least b smarties in a bag of n smarties by adding exactly b smarties for each b,
;;; b+1, b+2, up to n, where p is the probability of finding an orange smarties.
;;(number,number,number)->number
;;; Recursive

(define atleast-b-smarties 
  (lambda (n b p)
    (if(= b n)
       (exactly-b-smarties n n p)
       (+ (exactly-b-smarties n b p)(atleast-b-smarties n (+ b 1) p))
       )
    ))

; Test cases for atleast-b-smarties:

(atleast-b-smarties 9 5 0.5)        ; -> 0.5
(atleast-b-smarties 19 10 0.5)      ; -> 0.5
(atleast-b-smarties 10 5 0.6)       ; -> 0.8337613824000002
(atleast-b-smarties 15 5 0.3)       ; -> 0.48450894077315665


;;; Description for atleast-b-smarties-2: the helper funciton adds exactly b times every time to total, updates b by b+1 and returns total when n=b
;;and  atleast-b-smarties-2 calls  atleast-b-smarties-2-helper with total=0.
;;;(number,number,number)->number
;;; Iterative
(define atleast-b-smarties-2
  (lambda (n b p)
    (atleast-b-smarties-2-helper n b p 0)
))

(define atleast-b-smarties-2-helper
  (lambda(n b p total) (cond ((= b n) (+ total (exactly-b-smarties n b p)))
                             ((> b n) 0)
                             (else (atleast-b-smarties-2-helper n (+ b 1) p (+ total (exactly-b-smarties n b p))))
                             )
    )
  )

; Test cases for atleast-b-smarties-2:

(atleast-b-smarties-2 9 5 0.5)        ; -> 0.5
(atleast-b-smarties-2 19 10 0.5)      ; -> 0.5
(atleast-b-smarties-2 10 5 0.6)       ; -> 0.8337613824000002
(atleast-b-smarties-2 15 5 0.3)       ; -> 0.48450894077315665

;_BANNER_
;;; Problem 3: Choosing a Bag

;;; Description for good-bag: returns true if there is at least a 50% chance that it will have 8 or more orange Smarties.
;;;(number,number)->boolean

(define good-bag
  (lambda (n p)
    (cond ((< n 8) #f)
          (else (if (>= (atleast-b-smarties n 8 p) 0.5)
                    #t
                    #f))
          )
    ))

; Test cases for good-bag:

(good-bag 7 1)       ; -> #f
(good-bag 8 1)      ; -> #t
(good-bag 8 0.5)    ; -> #f
(good-bag 8 0.99)   ; -> #t
(good-bag 16 0.5)    ; -> #t
(good-bag 16 0.7)    ; -> #t
(good-bag 16 0.4)    ; -> #f


;_BANNER_
;;; Problem 4: Choosing a Value for p

;;; Description of minimum-p : calls helper function with x=inc where the helper returns inc if the bag is a good funtion and increments x by inc until it is a good bag.
;;;(number number)->number

(define minimum-p
  (lambda (n inc)
    (minimum-p-helper n inc inc)
    ))

(define minimum-p-helper
  (lambda(n inc x)
    (if(good-bag n inc)
       inc
       (minimum-p-helper n (+ x inc) x) ;;;it should've been -> (minimum-p-helper n inc (+ inc x)) (but it returned true values?)
       )
    ))

; Test cases for minimum-p:
(minimum-p 12 0.1)    ; -> 0.7
(minimum-p 12 0.01)    ; -> 0.6300000000000003
(minimum-p 12 0.001)    ; -> 0.6220000000000004
(minimum-p 12 0.0001)    ; -> 0.6214999999999479
(minimum-p 12 0.00001)    ; -> 0.6214799999998064
(minimum-p 15 0.1) ; -> 0.5
(minimum-p 15 0.01) ; -> 0.5000000000000002
(minimum-p 15 0.001) ; -> 0.5000000000000003

;_BANNER_
;;; Problem 5: Choosing p More Efficiently

;;; Description of minimum-p-new: displays number of times minimum-p is called and result of minimum-p
;;;where counter counts number of times minimum-p is called

(define minimum-p-new
  (lambda (n inc)
    (display "Number of calls to good-bag: ")
    (display (counter n inc inc 0))
    (newline)
    (display (minimum-p n inc))
    (newline)
))

(define counter
  (lambda(n inc x count)
    (if(good-bag n inc)
       (+ 1 count)
       (counter n (+ x inc) x (+ count 1))
       )
    ))

; Test cases for minimum-p-new:

(minimum-p-new 15 0.1)    ; ->Number of calls to good-bag: 5
				;0.5
(minimum-p-new 15 0.01)    ;  ->Number of calls to good-bag: 50
				;00.5000000000000002
(minimum-p-new 15 0.001)    ;  ->Number of calls to good-bag: 500
				;0.5000000000000003
(minimum-p-new 15 0.0001)    ;  ->Number of calls to good-bag: 5001
				;0.5000999999999612
(minimum-p-new 15 0.00001)    ; ->Number of calls to good-bag: 50000
				;0.5000000000003593


;;; Description of minimum-p-binary: returns number of time good bag is called and minimum p where minimum p is found by binary search 
 

(define minimum-p-binary
  (lambda (n inc)
     (minimum-p-binary-helper n inc 0 1.0 0))
  )


 (define minimum-p-binary-helper
  (lambda (n inc a b count)
    (cond ((< (- b a) inc) (begin
                             (display "Number of calls to good-bag: ")
                             (display count)
                             (newline)
                             (display b)
                             (newline)))
          ((good-bag n (/ (+ a b) 2)) (minimum-p-binary-helper n inc a (/ (+ a b) 2) (+ count 1)))
          (else (minimum-p-binary-helper n inc (/ (+ a b) 2) b (+ count 1)))
          )
))


; Test cases for minimum-p-binary:

(minimum-p-binary 12 0.1)    ; ->Number of calls to good-bag: 4
				;5/8
(minimum-p-binary 12 0.01)    ; ->Number of calls to good-bag: 7
				;5/8
(minimum-p-binary 12 0.001)    ; ->Number of calls to good-bag: 10
				;637/1024
(minimum-p-binary 12 0.0001)    ; ->Number of calls to good-bag: 14
				;10183/16384
(minimum-p-binary 12 0.00001)    ; ->Number of calls to good-bag: 17
				;40729/65536

		
;_BANNER_
;;; Problem 6: Monte-Carlo Simulations

;;; Description of coin-toss: return true or false raandomly

(define coin-toss
  (lambda (p)
    (if (>= (random) p)
        #f
        #t
        )
    ))

; Test cases for coin-toss:
(coin-toss 1)     ; -> #t
(coin-toss 0)     ; -> #f


;;; Description of random-bag:returns the number of orange Smarties in the bag by using a helper function where the helper calls coin-toss n times and hence
;;;randomly keeps track of the orange Smarties count and returns the count.

(define random-bag
  (lambda (n p)
    (random-bag-helper n p 0)
    ))

(define random-bag-helper
  (lambda(n p count)
    (cond ((= n 0) count)
          ((= p 0) 0)
          ((coin-toss p) (random-bag-helper (- n 1) p (+ 1 count)))
          (else (random-bag-helper (- n 1) p count)))))

; Test cases for random-bag:
(random-bag 10 1.0)     ; -> 10
(random-bag 20 1.0)     ; -> 20
(random-bag 100 0.5)     ; -> 51, 49, 45 (outcomes for 3 runs) 
(random-bag 100 0.0)     ; -> 0
(random-bag 10 0.0)     ; -> 0 
(random-bag 100 0.0001)     ; -> 0

;;; Description of get-m-bags: calls random-bags m times and return true if at least one of these bags is good.

(define get-m-bags
  (lambda (m n p)
    (cond ((= m 0) #f)
          ((>= (random-bag n p) 8) #t)
          (else(get-m-bags (- m 1) n p)))
    ))

; Test cases for get-m-bags:
(get-m-bags 1 10 1)      ; ->  #t
(get-m-bags 2 20 1)      ; -> #t
(get-m-bags 0 10 1)      ; ->  #f
(get-m-bags 100 10 0.0001)      ; -> #f
(get-m-bags 100 4 0.25)      ; -> #f

;;; Description of estimate-good-probability: make t calls to get-m-bags and returns t/g as its estimate

(define estimate-good-probability
  (lambda (m n p t)
    (/ (estimate-good-probability-helper m n p t 0) t )
))

(define estimate-good-probability-helper
  (lambda (m n p t count)
    (cond ((= t 0) count)
          ((get-m-bags m n p) (estimate-good-probability-helper m n p (- t 1) (+ 1 count)))
           (else (estimate-good-probability-helper m n p (- t 1) count)))))



; Test cases for estimate-good-probability:

(estimate-good-probability 24 12 0.5 1000)    ; -> 995/1000, 990/1000, 997/1000
(estimate-good-probability 24 16 0.5 1000)    ; -> 1, 1, 1
(estimate-good-probability 24 16 0.3 1000)    ; -> 819/1000, 834/1000, 859/1000
(estimate-good-probability 24 16 0.2 1000)    ; -> 175/1000, 153/1000, 131/1000




;_BANNER_
;;; Problem 7: Monte-Carlo Again

;;; Description of estimate-good-probability-2: does the same as estimate-good-probability with new definitons of good-bag and random-bag

(define estimate-good-probability-2
  (lambda (m n p q t)
    (/ (estimate-good-probability-2-helper m n p q t 0) t )
))

(define estimate-good-probability-2-helper
  (lambda (m n p q t count)
    (cond ((= t 0) count)
          ((>(+ p q) 1) 0)
          ((get-m-bags-new m n p q) (estimate-good-probability-2-helper m n p q (- t 1) (+ 1 count)))
           (else (estimate-good-probability-2-helper m n p q (- t 1) count)))))

;New defination of the "good-bag"
;o is the number of orange smarties in the current bag
(define good-bag-new
  (lambda (n q o)
    (cond ((> (/ n 2) o) #f)
          ((> (* q n) (/ n 5)) #f)
          (else (if (> o (/ n 2))
                    (if(< (* q n) (/ n 5))
                       #t
                       #f)
                    #f)))
          )
  )

;this new get-m-bags-new first chooses the orange smarties with the given probability of p than
;pass it to the good-bag-new function to the jobs.
(define get-m-bags-new
  (lambda (m n p q)
    (good-bag-new m n (* n p))
))

;;;____PLACE FOR ESSAY QUESTIONS_________;
;;;Answer following questions:
;;;1. Why do we test even simple procedures?
;;;To be able to keep track of errors with especially higher order procedures and for easier debugging.
;;;
;;;
;;;2. What makes a test case set a good test case set?
;;;If test case set takes care of every exception, base case for recursive procedures and every possibility of error then it is a good test case set
;;;
;;;3. How can we automate testing?
;;;???
;;;
;;;4. Why testing is required? Why do we have to test even the simplest procedure?
;;;So that it is easier to track your program and detect errors.
;;;
;;;5. Testing procedures which use random variables is a problem. How would you test the coin-toss procedure and decide if it is working correctly?
;;;by returning the random number or random boolean at the end as well so that substitution model can be applied
;;;
;;;______________________________________;


;_BANNER_
; END OF PROJECT
; Ignore the following
; This is necessary so the file loads without errors initially:
(define your-code-here #f)

