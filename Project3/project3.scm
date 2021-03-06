;;; YOUR NAME: Dilara Deveci
;;;
;;; Comp200 Project 3
;;;
;;; Before you start:
;;;
;;; * Please read the detailed instructions for this project from the
;;; file project3.pdf available in the Projects section of the
;;; course website.
;;;
;;; * Please read the project submission instructions carefully and make
;;; sure you understand everything before you start working on your
;;; project in order to avoid problems.
;;;
;;; While you are working:
;;; * Type all your work and notes in the appropriate sections of this file.
;;; * Please do not delete any of the existing lines.
;;; * Use the procedure names given in the instructions.
;;; * Remember to frequently save your file.
;;; * Use semicolon (;) to comment out text, tests and unused code.
;;; * Remember to document your code.
;;; * Remember our collaboration policy: you can discuss with your friends but:
;;;
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;
;;; When you are done:

;;; * Perform a final save and copy the file to the following location
;;;   DriveF@VOL\UGRADS\COMP200\HOMEWORK\username\project3.zip
;;;   where the username is your login name.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email comp200-group@ku.edu.tr if you have any questions.
;;; * Make sure your file loads without errors:
;;;
;;;
;;; Before the definition of each procedure, please write a description
;;; about what the procedure does and what its input and output should
;;; be, making sure the lines are commented out with semi-colons.
(define your-answer-here -1)
(load "databases.scm")

;_BANNER_
;;; problem 1 ;;;

;; your code should have the following general form

(define example-table
 (make-empty-table
 	       (list (make-column 'name 'symbol)
 		     (make-column 'major 'number))))

(table-insert! (list 'ben 6) example-table)
    (table-insert! (list 'jen 3) example-table)
    (table-insert! (list 'amy 12) example-table)
    (table-insert! (list 'kim 13) example-table)
    (table-insert! (list 'alex 6) example-table)
    

;; test cases
(table-display example-table)

;_BANNER_
;;; problem 2 ;;;
(define (table-insert-all! lst table)
(if (null? lst)
    table
    (table-insert-all! (cdr lst) (table-insert! (car lst) table)))
)
;; test cases

 (define books (make-empty-table
 	       (list (make-column 'title 'symbol)
 		     (make-column 'author 'symbol)
 		     (make-column 'rating 'number))))


 (table-insert-all! '((sicp abelson-sussman 8)
 		     (return-of-the-king jrr-tolkien 9)
 		     (treatment-of-subordinates darth-vader 4)
 		     (project-grading tom 2)
 		     (all-things-stata frank-gehry 5)
 		     (biting-the-hand-that-feeds-me my-cat 1))
 		   books)
 (table-display books)

;_BANNER_
;;; problem 3 ;;;
;; Hint: Writing (filter predicate lst) might be helpful

(define (table-select selector table)
  (make-table
   (get-table-columns table)
   (filter selector (get-table-data table)))
    )

;; test cases

 (display "Testing Problem 3\n")
 (table-display
  (table-select
   (lambda (row)
     (> (get 'rating row) 4))
   books))

;_BANNER_
;;; problem 4 ;;;

;; Hint: Be careful about the comparator operator of the corresponding
;; row.  Writing a (get-column-type row column-name) might be helpful.


(define (get-column-type row name)
  (cond ((null? row) '())
  ((eq? name (column-name (car row))) (column-type (car row)))
  (else (get-column-type (cdr row) name))
  ))

(define (table-order-by column table)
  (let ((type (get-column-type (get-table-columns table) column)))
    (define (compare a b)
      ((type-comparator type) (get column a) (get column b))
      )  
    (make-table (get-table-columns table) 
              (sort compare (get-table-data table)))))

;; test cases
 (display "Testing Problem 4\n")
 (table-display
  (table-order-by 'rating books)
 )

 (table-display
  (table-order-by 'title books)
 )

;_BANNER_
;;; problem 5 ;;;

(define (table-delete! pred table)
  (change-table-data! table (filter (lambda(x) (not (pred x))) (get-table-data table))
  ))

;; test cases
 (display "Testing Problem 5\n")
 (table-delete!
  (lambda (row)
   (eq? (get 'author row) 'my-cat))
 books)

 (table-display books)

;_BANNER_
;;; problem 6 ;;;

(define (table-update! pred column proc table)
  (define (update list)
   (cond
  ((null? list) '())
  ((pred (car list)) (let ((new (row-col-replace (car list) column (proc (car list)))))
                                   (if (row-type-check new)
                                       (cons new (update (cdr list)))
                                       (error "Value doesn't match the column type: " new)
                                       )))
  (else (cons (car list) (update (cdr list))))
  )
    )
  (change-table-data! table (update (get-table-data table)))
  )

;; test cases

 (display "Testing Problem 6\n")
 (table-update! (lambda (row) (or (eq? (get 'name row) 'amy) (eq? (get 'name row) 'alex))) 
               'major 
               (lambda (row) '9) 
               example-table) 
 (table-display example-table)

;_BANNER_
;;; problem 7 ;;;

(define *type-table*
(list 
 (list 'number number? <)
 (list 'symbol symbol? symbol<?)
 (list 'string string? string<?))
)

(define example-table2
 (make-empty-table
 	       (list (make-column 'name 'string)
 		     (make-column 'major 'number))))

;; test cases
 (display "Testing Problem 7\n")
 (table-insert! '("jen" 3) example-table2)
 (table-insert! '("ben" 6) example-table2)
 (table-insert! '("alex" 6) example-table2)
 (table-insert! '("amy" 12) example-table2)
 (table-insert! '("kim" 13) example-table2)


 (table-display example-table2)
 (display "\nordered example-table2\n")
 (table-display
  (table-order-by 'name example-table2)
 )

;_BANNER_
;;; problem 8 ;;;

;; Hint: Writing these two procedures might be helpful (contains? lst
;; x) returns true if x in the lst and (get-pos lst x) returns the
;; position of x if it is in the list.  
;; Ex: (get-pos '(1 2 3 4) 2) => 2
;;     (get-pos '(1 2 3 4) 5) => 0
(define (contains? lst x)
  (cond ((null? lst) #f)
        ((eq? x (car lst)) #t)
        (else (contains? (cdr lst) x))))

(define (get-pos lst x)
  (cond
    ((not (contains? lst x)) 0)
    ((null? lst) 0)
    ((eq? x (car lst)) 1)
    (else (+ 1 (get-pos (cdr lst) x))))
  )

(define (make-enum-checker lst)
  (lambda (x) (if (contains? lst x) #t #f)))

(define (make-enum-comparator lst)
(lambda (x y)
  (cond
    ((null? lst) #f)
    ((< (get-pos lst x) (get-pos lst y)) #t)
    (else #f))
  ))
  
(define *days* '(sunday monday tuesday Wednesday thursday friday saturday)) 
(define day-checker (make-enum-checker *days*)) 
(define day-comparator (make-enum-comparator *days*)) 

;; test cases
 (display "Testing Problem 8\n")
 (day-checker 'monday)   ;=> #t 
 (day-checker 7)         ;=> #f
 (day-comparator 'monday 'tuesday)   ;=> #t (monday is "less than" tuesday) 
 (day-comparator 'friday 'sunday)    ;=> #f (sunday is before friday) 


(define *type-table*
(list 
 (list 'number number? <)
 (list 'symbol symbol? symbol<?)
 (list 'string string? string<?)
 (list 'day day-checker day-comparator))
)

 (define example-table3
   (make-empty-table 
    (list (make-column 'name 'string)
          (make-column 'date 'day) 
          (make-column 'major 'number)))
    )
                    
 (table-insert! '("jen" monday 3) example-table3)
 (table-insert! '("ben" sunday 6) example-table3)
 (table-insert! '("alex" friday 6) example-table3)
 (table-insert! '("amy" tuesday 1) example-table3)
 (table-insert! '("kim" saturday 2) example-table3)

 (table-display example-table3)
 (display "\nordered example-table3\n")
 (table-display
  (table-order-by 'date example-table3)
 )

;_BANNER_
;;; Problem 9
;; Hint: Similar with Problem 8
(define *gender* '(male female))

(define gender-checker 
(make-enum-checker *gender*)
)

(define gender-comparator
  (make-enum-comparator *gender*)
  )

(define *race* '(white black red))

(define race-checker 
(make-enum-checker *race*)
)

(define race-comparator
(make-enum-comparator *race*)
) 

(define *type-table*
  (list 
   (list 'number number? <)
   (list 'symbol symbol? symbol<?)
   (list 'string string? string<?)
   (list 'day day-checker day-comparator)
   (list 'gender gender-checker gender-comparator)
   (list 'race race-checker race-comparator))
  )

;_BANNER_
;;; Problem 10
(define person-table
 (make-empty-table
 	       (list (make-column 'name 'string)
 		     (make-column 'race 'race)
                     (make-column 'gender 'gender)
                     (make-column 'birthyear 'number)))
)
;;; tests
 (display "Testing Problem 10\n")
 (table-insert! '("jen" white female 1983) person-table)
 (table-insert! '("axe" black male 1982) person-table)
 (table-display person-table)


;_BANNER_
;;; Problem 11
 (table-delete! (lambda (x) #t) person-table)
 (display "\nDeleted Person Table\n")
 (table-display person-table)

(define (make-person name race gender birthyear)
  (table-insert! (list name race gender birthyear) person-table)  
  name)

;; test cases

 (display "Testing Problem 11\n")

 (define p1 (make-person "Alex" 'white 'male 1983))
 (define p2 (make-person "Clark" 'black 'male 1982))
 (table-display person-table)

;_BANNER_
;;; Problem 12

(define (person-name person) person)

(define (lookup-person-row person)
  (let ((filter1 (filter (lambda (x) (eq? (get 'name x) person)) (get-table-data person-table))))
    (if (null? filter1)
        (error "There is no such person")
        (car filter1))
  ))

(define (person-race person) 
  (get 'race (lookup-person-row person))) 

(define (person-gender person) 
  (get 'gender (lookup-person-row person))) 

(define (person-birthyear person) 
  (get 'birthyear (lookup-person-row person))) 

(define (person-age person) 
; returns an approximation to the person's age in years 
  (let ((*current-year* 2019)) 
    (- *current-year* (person-birthyear person)))) 

;; test cases
 (display "Testing Problem 12\n")
 (lookup-person-row p1)
 (person-race p1)
 (person-gender p1)
 (person-birthyear p1)
 (person-age p1)
 (lookup-person-row "Muslera")


;_BANNER_
;;; Problem 13

(define (update-person-row! person colname newvalue)
  (table-update! (lambda (row) (eq? (get 'name row) person)) colname (lambda(row) newvalue) person-table)
  )

(define (set-person-name! person newname) 
  (update-person-row! person 'name newname))

(define (set-person-race! person newrace) 
  (update-person-row! person 'race newrace)) 

(define (set-person-gender! person newgender) 
  (update-person-row! person 'gender newgender)) 

(define (set-person-birthyear! person newbirthyear) 
  (update-person-row! person 'birthyear newbirthyear)) 

;; QUESTION What happens? Why? Comments?
;;

;;; test cases

; (display "Testing Problem 13\n")
; (define alyssa (make-person "alyssa-p-hacker" 'black 'female 1978)) 
; (set-person-name! alyssa "alyssa-p-hacker-bitdiddle")  ; got married! 
; (table-display person-table)
; (person-name alyssa) 
; (person-race alyssa) 

;_BANNER_
;;; Problem 14

(define life-table
 (make-empty-table
 	       (list (make-column 'year 'number)
 		     (make-column 'all-all 'number)
 		     (make-column 'all-male 'number)
                     (make-column 'all-female 'number)
                     (make-column 'white-all 'number)
                     (make-column 'white-male 'number)
                     (make-column 'white-female 'number)
                     (make-column 'black-all 'number)
                     (make-column 'black-male 'number)
                     (make-column 'black-female 'number)
                     ))
)

(table-insert-all! life-expect-data life-table)

 (display "Selecting 1950\n")
 (table-display
  (table-select
  (lambda (row)
    (= (get 'year row) 1950))
  life-table))

;_BANNER_
;;; Problem 15
(define (row-replacer lst)
  (list (list (list-ref lst 0) 'white 'male (list-ref lst 5))
        (list (list-ref lst 0) 'white 'female (list-ref lst 6))
        (list (list-ref lst 0) 'black 'male (list-ref lst 8))
        (list (list-ref lst 0) 'black 'female (list-ref lst 9))
        )
  )

(define (convert-lifetable lst)
;; Converts the data to the (year race gender expected) format
(if (null? lst) '()
    (append (row-replacer (car lst)) (convert-lifetable (cdr lst)))
))

;; test cases
;(convert-lifetable life-expect-data)

(define life-expect-data-new (convert-lifetable life-expect-data))

(define life-table-new
   (make-empty-table 
   (list (make-column 'year 'number)
         (make-column 'race 'race)
         (make-column 'gender 'gender)
         (make-column 'expected 'number)
   )))
(table-insert-all! life-expect-data-new life-table-new)
(display "Selecting 1950 from new data\n")
(table-display
(table-select
 (lambda (row)
  (= (get 'year row) 1950))
  life-table-new))


;_BANNER_
;;; Problem 16
(display "\nTesting Problem 16\n")
(define problem16-table
(table-select
 (lambda (x) (and
              (eq? (get 'race x) 'white)
              (eq? (get 'gender x) 'female)
              (>= 1959 (get 'year x))
              (<= 1950 (get 'year x))))
 life-table-new)
  )

;;; QUESTION Was life expectancy for white women steadily increasing
;;; in this decade?
;increasing

(table-display
  (table-order-by 'expected problem16-table)
)

;; Paste the output of Problem 16 for black female
;; between 1950 and 1959

;1950	white	female	72.2	
;1951	white	female	72.4	
;1952	white	female	72.6	
;1953	white	female	73.0	
;1957	white	female	73.7	
;1955	white	female	73.7	
;1954	white	female	73.7	
;1958	white	female	73.9	
;1956	white	female	73.9	
;1959	white	female	74.2

;_BANNER_
;;; Problem 17

(define p3 (make-person "GeorgeBest" 'white 'female 1987))
(define p4 (make-person "Lizarazu" 'white 'male 1940))

(define (expected-years person)
  (let ((race (person-race person))
        (gender (person-gender person))
        (age (person-age person))
        (byear (person-birthyear person))
        (data (get-table-data life-table-new)))
  (-
   (get 'expected (car
                   (filter
                    (lambda (x)
                      (and
                       (eq? (get 'race x) race)
                       (eq? (get 'gender x) gender)
                       (= (get 'year x) byear)))
                    data)))
   age)
  ))
  
;; test cases
(display "Testing problem 17")
(newline)
(expected-years p3)
(expected-years p4)

