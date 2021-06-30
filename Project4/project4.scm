;_BANNER_
;;;   The Object-Oriented Adventure Game
;_BANNER_
;;;
;;; _EMAIL_  ddeveci18@ku.edu.tr   _DATE_ 23.12.2019
;;;                                
;;; Before you start:
;;; * Please read the project handout available on the course
;;;   web site first to get a basic idea about the project and the 
;;;   logic behind it, then to find out the details about what 
;;;   your tasks are for the rest of the project.
;;;
;;; * The following code should be studied and loaded for this
;;;   project.  Please do not modify these files, put all your work in
;;;   this file.
;;;
;;; - objsys.scm: support for an elementary object system
;;; - objtypes.scm: a few nice object classes
;;; - setup.scm: a bizarre world constructed using these classes
;;;
;;; * Plan your work with pencil and paper before starting to code.
;;;
;;; While you are working:
;;; * Type all your work and notes in the appropriate sections of this file.
;;; * Please do not delete any of the existing lines.
;;; * Use the procedure names given in the instructions.
;;; * Remember to frequently save your file.
;;; * Use semicolon (;) to comment out text, tests and unused code.
;;; * Remember to document your code (in this file)
;;; * Remember our collaboration policy: you can discuss with your friends but:
;;;
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;
;;;
;;; When you are done:
;;; * Perform a final save and submit your work following the instructions.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email to helpline [comp200-group@ku.edu.tr] if you have any questions.
;;; * Make sure your file loads without errors:
;;; ****************************************************************************
;;; ***  Your code should run without any syntactic errors. Projects  causing error will NOT be graded. ***
;;; ****************************************************************************
;;;
;; Do NOT modify or delete the lines below.
(#%require (only racket/base random))
(load "objsys.scm")     	   	  	
(load "objtypes.scm")     	   	  	
(load "setup.scm")     	   	  	
(define nil '())   
(define your-answer-here #f)
;;;;;;;;;

;_BANNER_
;;; PART II. Programming Assignment
;;;
;;; The answers to the computer exercises in Section 5 go in the
;;; appropriate sections below.
;;;



;_BANNER_
;;;;;;;;;;;;; Setting up ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;; CODES: ;;;;;;;;;;;;;
;;

;(setup 'dilara)
;(ask screen 'deity-mode #f)

;(ask (ask me 'location) 'name)

;(ask me ' say (list 'my 'name 'is (ask me 'name)))
;(ask me 'say (list 'Hello 'World)) 
;(ask me 'look-around)


;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;

;ready
;migros

;At migros dilara says -- my name is dilara 
;At migros dilara says -- hello world 
;You are in migros 
;You are not holding anything. 
;You see stuff in the room: milk 
;You see other people: alyssa-p-hacker 
;The exits are in directions: south ok
;> (ask me 'take (thing-named 'milk))

;At migros dilara says -- I take milk from migros 
;> (ask me 'toss 'milk)

;At migros dilara says -- I drop milk at migros 
;> (ask me 'go 'south)

;dilara moves from migros to cici-bufe 
;At cici-bufe dilara says -- Hi cici 
;At cici-bufe cici says -- Prepare to suffer, dilara ! 
;At cici-bufe dilara says -- Ouch! 3 hits is more than I want! 
;At cici-bufe dilara says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;dilara moves from cici-bufe to heaven 
;An earth-shattering, soul-piercing scream is heard... 
;At heaven lambda-man says -- Hi dilara 
;--- the-clock Tick 0 --- 
;You are in heaven 
;You are not holding anything. 
;There is no stuff in the room. 
;You see other people: lambda-man 
;There are no exits... you are dead and gone to heaven! #t
;> (ask me 'die)

;At heaven dilara says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;dilara moves from heaven to heaven 
;At heaven dilara says -- Hi lambda-man game-over-for-you-dude

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     

     
     
     
     
     

;_BANNER_
;;;;;; Understanding installation;;;;;
;_BANNER_
;;
;;;;;;;;;;;;; ANSWER: ;;;;;;;;;;;;;
;;
     
;make-autonomous-person calls the following line to make sure that an autonomous person obj is passed to the installer method as an argument (delegate person-part self 'INSTALL)
;if we use (ask person-part 'INSTALL) and pass the internal person-part as an argument instead of using delegates and passing self objects, we add person-part of the object to
;the corresponding person list of the location rather than the real object, autonomous person object which is referred as self. So when,
;(CHANGE-LOCATION)   	    	  	 
;	 (lambda (self new-location)
;	   (ask location 'DEL-THING self)
;	   (ask new-location 'ADD-THING self)
;	   (set! location new-location))
;is run, it properly adds self, autonomous person obj, to the corresponding person list of the new location but cannot delete it from the person list of the old location
;since the object that was added to the person list of the old location was not the autonomous person object but an internal person-part.
;Therefore, if we used what Louis Reasoner suggested, the same person would appear in two different locations at the same time although the person moved to a new place.

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_

     
     
     
     
     
     
     
     
     
     

;_BANNER_
;;;;;;;;;;;; Who just died? ;;;;;;;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;

;(setup 'dilara)
;(ask screen 'deity-mode #f)
;(run-clock 5)
;(ask me 'die)
;(ask me 'look-around)

;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;

;I waited for a time to pass so someone will die then killed myself with (ask me 'die)
;and hence go to heaven and used (ask me 'look-around) to see who else is in heaven i.e. died.
     
;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;
     
;--- the-clock Tick 0 --- 
;At cas-building alyssa-p-hacker says -- Hi dilara 
;--- the-clock Tick 1 --- 
;alyssa-p-hacker moves from cas-building to sos-building 
;--- the-clock Tick 2 --- 
;An earth-shattering, soul-piercing scream is heard... 
;--- the-clock Tick 3 --- 
;--- the-clock Tick 4 --- done

;At cas-building dilara says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;dilara moves from cas-building to heaven 
;At heaven dilara says -- Hi prof-yuret game-over-for-you-dude

;You are in heaven 
;You are not holding anything. 
;There is no stuff in the room. 
;You see other people: prof-yuret 
;There are no exits... you are dead and gone to heaven! ok

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     
 
;_BANNER_
;;;;;; Computer exercise: But I'm too young to die!! ;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;

(define (make-person name birthplace) ; symbol, location -> person
  (let ((mobile-thing-part (make-mobile-thing name birthplace))
	(container-part (make-container))
	(health 3)
	(strength 1)
        (lives 3))
    (lambda (message)
      (case message
        ((PERSON?) (lambda (self) #t))
	((STRENGTH) (lambda (self) strength))
	((HEALTH) (lambda (self) health))
        ((SAY)
         (lambda (self list-of-stuff)
           (ask screen 'TELL-ROOM (ask self 'location)
                (append (list "At" (ask (ask self 'LOCATION) 'NAME)
                                 (ask self 'NAME) "says --")
                           list-of-stuff))
                  'SAID-AND-HEARD))
	((HAVE-FIT)
	 (lambda (self)
	   (ask self 'SAY '("Yaaaah! I am upset!"))
	   'I-feel-better-now))

	((PEOPLE-AROUND)	; other people in room...
	 (lambda (self)
	   (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
		  (people (myfilter (lambda (x) (is-a x 'PERSON?)) in-room)))
	     (delq self people))))

	((STUFF-AROUND)		; stuff (non people) in room...
	 (lambda (self)
	   (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
		  (stuff (myfilter (lambda (x) (not (is-a x 'PERSON?))) in-room)))
	     stuff)))
	 
	((PEEK-AROUND)		; other people's stuff...
	 (lambda (self)
	   (let ((people (ask self 'PEOPLE-AROUND)))
	     (accumulate append '() (map (lambda (p) (ask p 'THINGS)) people)))))

	((TAKE)
	 (lambda (self thing)
	   (cond ((ask self 'HAVE-THING? thing)  ; already have it
		  (ask self 'SAY (list "I am already carrying"
				       (ask thing 'NAME)))
		  #f)
		 ((or (is-a thing 'PERSON?)
		      (not (is-a thing 'MOBILE-THING?)))
		  (ask self 'SAY (list "I try but cannot take"
				       (ask thing 'NAME)))
		  #F)
		 (else
		  (let ((owner (ask thing 'LOCATION)))
		    (ask self 'SAY (list "I take" (ask thing 'NAME) 
					 "from" (ask owner 'NAME)))
		    (if (is-a owner 'PERSON?)
			(ask owner 'LOSE thing self)
			(ask thing 'CHANGE-LOCATION self))
		    thing)))))

	((LOSE)
	 (lambda (self thing lose-to)
	   (ask self 'SAY (list "I lose" (ask thing 'NAME)))
	   (ask self 'HAVE-FIT)
	   (ask thing 'CHANGE-LOCATION lose-to)))

	((DROP)
	 (lambda (self thing)
	   (ask self 'SAY (list "I drop" (ask thing 'NAME)
				"at" (ask (ask self 'LOCATION) 'NAME)))
	   (ask thing 'CHANGE-LOCATION (ask self 'LOCATION))))

        ((GO-EXIT)
         (lambda (self exit)
           (ask exit 'USE self)))

	((GO)
	 (lambda (self direction) ; person, symbol -> boolean
	   (let ((exit (ask (ask self 'LOCATION) 'EXIT-TOWARDS direction)))
	     (if (is-a exit 'EXIT?)
                 (ask self 'GO-EXIT exit)
		 (begin (ask screen 'TELL-ROOM (ask self 'LOCATION)
			     (list "No exit in" direction "direction"))
			#F)))))
	((SUFFER)
	 (lambda (self hits)
	   (ask self 'SAY (list "Ouch!" hits "hits is more than I want!"))
	   (set! health (- health hits))
	   (if (<= health 0) (ask self 'DIE))
	   health))

	((DEATH-SCREAM)
	 (lambda (self)
	   (ask screen 'TELL-WORLD
		'("An earth-shattering, soul-piercing scream is heard..."))))

	((ENTER-ROOM)
	 (lambda (self)
	   (let ((others (ask self 'PEOPLE-AROUND)))
	     (if (not (null? others))
		 (ask self 'SAY (cons "Hi" (names-of others)))))
	   (ask (ask self 'location) 'make-noise self)
	   #T))
	
	;; Here is the original DIE method
   #|
	 ((DIE)
	  (lambda (self)
	    (ask self 'SAY '("SHREEEEK!  I, uh, suddenly feel very faint..."))
	    (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
	 	     (ask self 'THINGS))
	    (ask self 'DEATH-SCREAM)
	    (ask death-exit 'USE self)
	    'GAME-OVER-FOR-YOU-DUDE))
   |#
	;; Your version goes here:
 
          ((DIE)
           (lambda (self)   	    	  	 
             (ask self 'SAY '("SHREEEEK!  I, uh, suddenly feel very faint..."))
             (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
                       (ask self 'THINGS))
             (ask self 'DEATH-SCREAM)
             (set! lives (- lives 1))   ;only these parts are added
             (if (= lives 0)            ;;only these parts are added
                 (begin (ask death-exit 'USE self) 'GAME-OVER-FOR-YOU-DUDE)
                 (ask self 'CHANGE-LOCATION birthplace)   ;only these parts are added
                 )
             ))
        (else (find-method message mobile-thing-part container-part))))))


;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;
        
;Rather than asking for death-exit the code decreases the person's lives and if the number of lives equals to 0,
;then it asks for death-exists and then asks to change location to go to the birthplace for reappearing in their birthplace.
     
     
     
;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;     

;(setup 'dilara)
;(ask screen 'deity-mode #f)
;(ask me 'look-around)

;You are in sci-building 
;You are not holding anything. 
;There is no stuff in the room. 
;There are no other people around you. 
;The exits are in directions: south north ok
;> (ask me 'die)

;At sci-building dilara says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;> (ask me 'go 'north)

;dilara moves from sci-building to eng-building 
;At eng-building prof-yuret says -- Hi dilara 
;--- the-clock Tick 0 --- 
;You are in eng-building 
;You are not holding anything. 
;There is no stuff in the room. 
;You see other people: prof-yuret 
;The exits are in directions: south in west north #t
;> (ask me 'die)

;At eng-building dilara says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;> (ask me 'die) 

;At sci-building dilara says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;dilara moves from sci-building to heaven game-over-for-you-dude
     
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     
     
     
     
     
     
     
     
     

;_BANNER_
;;; Computer exercise: Perhaps to arm oneself against a sea of .... ;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;
(define (make-weapon name location damage-max)
  (let ((mobile-thing-part (make-mobile-thing name location)))
     (lambda (message)
       (case message
         ((WEAPON?) (lambda (self) #t))
         ((DAMAGE) (lambda (self) damage-max)) 
         ((HIT) (lambda (self person target-person)
                  (ask screen 'tell-room (ask person 'location) (list (ask person 'name) "has hit" (ask target-person 'name) "with the weapon:" (ask self 'name)))
                  (ask target-person 'suffer (random-number damage-max))
                  ))
         (else (get-method message mobile-thing-part))))))

(define (create-weapon name location damage-max)
  (create make-weapon name location damage-max))
     
;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;

;since every weapon is a mobile thing, it has a mobile-thing-part therefore weapon class inherits from the mobile thing class.
;((WEAPON?) (lambda (self) #T)) part of the code checks if it is a weapon
;((DAMAGE) (lambda (self) maxDamage)) part of code returns the value of the maximal damage of a weapon
;((HIT) (lambda (self user targetPerson) part of the code takes person who is using the weapon, target person as parameters and gives info about the scene,
;also makes the target person to suffer an amount between 1 and max damage of the weapon
     

;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;
;(setup 'dilara)
;(populate-weapons all-rooms)
;(ask me  'look-around)
;(ask screen 'deity-mode #f)

;You are in eng-building 
;You are not holding anything. 
;There is no stuff in the room. 
;You see other people: lambda-man comp200-student 
;The exits are in directions: south in west north ok
;> (ask me 'go 'north)

;dilara moves from eng-building to soccer-field 
;At soccer-field lambda-man says -- Hi dilara 
;At soccer-field comp200-student says -- Hi lambda-man dilara 
;comp200-student moves from soccer-field to eng-building 
;--- the-clock Tick 0 --- 
;You are in soccer-field 
;You are not holding anything. 
;You see stuff in the room: stick-of-chalk football 
;You see other people: lambda-man 
;The exits are in directions: south #t
;> (ask me 'get 'stick-of-chalk)

;At soccer-field dilara says -- I take stick-of-chalk from soccer-field 
;> (ask (thing-named 'stick-of-chalk) 'hit me (thing-named 'lambda-man))

;dilara has hit lambda-man with the weapon: stick-of-chalk 
;At soccer-field lambda-man says -- Ouch! 1 hits is more than I want! 2
;> (ask (thing-named 'stick-of-chalk) 'hit me (thing-named 'lambda-man))

;dilara has hit lambda-man with the weapon: stick-of-chalk 
;At soccer-field lambda-man says -- Ouch! 1 hits is more than I want! 1
;> (ask (thing-named 'stick-of-chalk) 'hit me (thing-named 'lambda-man))

;dilara has hit lambda-man with the weapon: stick-of-chalk 
;At soccer-field lambda-man says -- Ouch! 1 hits is more than I want! 
;At soccer-field lambda-man says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 0

;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
      
      
      
      
      
      
     
     
      
      
;_BANNER_
;;;;;;;; Computer exercise: Good thing I'm armed and dangerous ;;;;;;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;
(define (make-violent-person name birthplace activity miserly frequecy)
  (let ((autonomous-person-part (make-autonomous-player name birthplace activity miserly)))
        (lambda (message)
          (case message
            ((VIOLENT-PERSON) (lambda(self) #t))
            ((ACT-VIOLENTLY)
             (lambda(self)
               (let*
                   ((all-objects (ask (ask self 'LOCATION) 'THINGS))
                     (people-around (ask self 'PEOPLE-AROUND))
                     (weapons (myfilter (lambda (x) (is-a x 'WEAPON?)) (ask self 'THINGS)))
                     (random-person
                      (if (not (null? people-around))
                          (list-ref people-around (random (length people-around)))
                          #f))
                     (random-weapon
                      (if (not (null? weapons))
                          (list-ref weapons (random (length weapons)))
                          #f)))
               (if (and
                    (= (random frequency) 0)
                    (not (null? weapons-owned))
                    (not (null? people-around)))
                   (ask random-weapon 'hit self random-person)))))
            ((INSTALL)(lambda(self)
                        (ask clock 'ADD-CALLBACK
                             (make-clock-callback 'act-violently self 'ACT-VIOLENTLY))
                        (delegate autonomous-person-part self 'INSTALL)))
            (else (get-method message autonomous-person-part))))))

(define (create-violent-person name birthplace activity miserly frequency)
  (create make-violent-person name birthplace activity miserly frequency))
             

;_BANNER_
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;

;it inherits from autonomous-person with the internal object autonomous-person-part
;(ACT-VIOLENTLY) part of the code makes the violent person attack one of the people with a random weapon selected from his inventory if SMTTTT !!!!!!!!!!!
;(ask clock 'ADD-CALLBACK) part of the(INSTALL) in the code is a callback that is sent to the clock asking this object potentially to attack others on each clock tick
;(delegate autonomous-person-part self 'INSTALL) part of the(INSTALL) in the code is a call back to the install method of the autonomous person class
;to handle taking stuff and wandering around\others on each clock tick
     

;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;
;(setup 'dilara)
;(populate-players all-rooms)
;(ask screen 'deity-mode #t)
;(run-clock 3)

;cici moves from cici-bufe to divan 
;At suzy-cafe suzy says -- Prepare to suffer, lambda-man ! 
;At suzy-cafe lambda-man says -- Ouch! 3 hits is more than I want! 
;At suzy-cafe lambda-man says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;lambda-man moves from suzy-cafe to cici-bufe 
;At cici-bufe lambda-man says -- Hi cici 
;lambda-man moves from cici-bufe to divan 
;At divan lambda-man says -- Hi cici 
;At divan lambda-man says -- I take profiterol from divan 
;comp200-student moves from computer-club to cici-bufe 
;At cici-bufe comp200-student says -- Hi cici 
;At cici-bufe comp200-student says -- I take kofte from cici-bufe 
;prof-yuret moves from bursar-office to registrar-office 
;At registrar-office prof-yuret says -- Hi alyssa-p-hacker 
;At registrar-office prof-yuret says -- I take diploma from registrar-office 
;alyssa-p-hacker moves from cas-building to great-court 
;ben-bitdiddle moves from soccer-field to eng-building 
;At eng-building ben-bitdiddle says -- Hi lambda-man 
;ben-bitdiddle moves from eng-building to sci-building 
;At cici-bufe cici says -- Prepare to suffer, comp200-student ! 
;At cici-bufe comp200-student says -- Ouch! 2 hits is more than I want! 
;At suzy-cafe suzy says -- Prepare to suffer, suzy ! 
;At suzy-cafe suzy says -- Ouch! 1 hits is more than I want! 
;lambda-man moves from eng-building to sci-building 
;At sci-building lambda-man says -- Hi ben-bitdiddle 
;lambda-man moves from sci-building to eng-building 
;comp200-student moves from deans-office to eng-z21 
;At eng-z21 comp200-student says -- Hi dilara 
;At eng-z21 comp200-student says -- I take problem-set from eng-z21 
;prof-yuret moves from dorms to adm-building 
;alyssa-p-hacker moves from registrar-office to bursar-office 
;At bursar-office alyssa-p-hacker says -- Hi ben-bitdiddle 
;alyssa-p-hacker moves from bursar-office to registrar-office 
;At registrar-office alyssa-p-hacker says -- Hi prof-yuret 
;ben-bitdiddle moves from bursar-office to registrar-office 
;At registrar-office ben-bitdiddle says -- Hi alyssa-p-hacker prof-yuret 
;ben-bitdiddle moves from registrar-office to bursar-office 
;--- the-clock Tick 0 --- 
;At divan cici says -- Prepare to suffer, lambda-man ! 
;At divan lambda-man says -- Ouch! 1 hits is more than I want! 
;At divan lambda-man says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;At divan lambda-man says -- I lose profiterol 
;At divan lambda-man says -- Yaaaah! I am upset! 
;An earth-shattering, soul-piercing scream is heard... 
;suzy moves from suzy-cafe to student-center 
;comp200-student moves from cici-bufe to computer-club 
;At computer-club comp200-student says -- I take scheme-manual from computer-club 
;prof-yuret moves from registrar-office to adm-building 
;At adm-building prof-yuret says -- Hi prof-yuret 
;alyssa-p-hacker moves from great-court to graduation-stage 
;alyssa-p-hacker moves from graduation-stage to great-court 
;ben-bitdiddle moves from sci-building to sos-building 
;suzy moves from suzy-cafe to cici-bufe 
;At cici-bufe suzy says -- Hi cici 
;At cici-bufe suzy says -- Prepare to suffer, cici ! 
;At cici-bufe cici says -- Ouch! 2 hits is more than I want! 
;lambda-man moves from eng-building to eng-z21 
;At eng-z21 lambda-man says -- Hi comp200-student dilara 
;lambda-man moves from eng-z21 to eng-building 
;comp200-student moves from eng-z21 to deans-office 
;At deans-office comp200-student says -- I take transcript from deans-office 
;prof-yuret moves from adm-building to dorms 
;alyssa-p-hacker moves from registrar-office to bursar-office 
;At bursar-office alyssa-p-hacker says -- Hi ben-bitdiddle 
;alyssa-p-hacker moves from bursar-office to registrar-office 
;ben-bitdiddle moves from bursar-office to registrar-office 
;At registrar-office ben-bitdiddle says -- Hi alyssa-p-hacker 
;--- the-clock Tick 1 --- 
;cici moves from divan to cici-bufe 
;At cici-bufe cici says -- Hi suzy cici 
;At cici-bufe cici says -- Prepare to suffer, suzy ! 
;At cici-bufe suzy says -- Ouch! 2 hits is more than I want! 
;comp200-student moves from computer-club to cici-bufe 
;At cici-bufe comp200-student says -- Hi cici suzy cici 
;comp200-student moves from cici-bufe to migros 
;At migros comp200-student says -- I take milk from migros 
;prof-yuret moves from adm-building to dorms 
;At dorms prof-yuret says -- Hi prof-yuret 
;At dorms prof-yuret says -- I take tons-of-code from dorms 
;alyssa-p-hacker moves from great-court to cas-building 
;alyssa-p-hacker moves from cas-building to sos-building 
;At sos-building alyssa-p-hacker says -- Hi ben-bitdiddle 
;ben-bitdiddle moves from sos-building to amphitheater 
;At amphitheater ben-bitdiddle says -- I take umbrella from amphitheater 
;At cici-bufe cici says -- Prepare to suffer, cici ! 
;At cici-bufe cici says -- Ouch! 2 hits is more than I want! 
;At cici-bufe suzy says -- Prepare to suffer, cici ! 
;At cici-bufe cici says -- Ouch! 1 hits is more than I want! 
;At cici-bufe cici says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;lambda-man moves from eng-building to soccer-field 
;lambda-man moves from soccer-field to eng-building 
;comp200-student moves from deans-office to eng-z21 
;At eng-z21 comp200-student says -- Hi dilara 
;comp200-student moves from eng-z21 to eng-building 
;At eng-building comp200-student says -- Hi lambda-man 
;prof-yuret moves from dorms to adm-building 
;alyssa-p-hacker moves from registrar-office to bursar-office 
;alyssa-p-hacker moves from bursar-office to registrar-office 
;At registrar-office alyssa-p-hacker says -- Hi ben-bitdiddle 
;ben-bitdiddle moves from registrar-office to bursar-office 
;--- the-clock Tick 2 --- done
      
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     
     
     
     
     
     
     
     
;_BANNER_
;;; Computer exercise: A good hacker could defuse this situation ;;;;;;;
;_BANNER_
;;
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;

(define (make-bomb name birthplace power)
  (let ((mobile-thing-part (make-mobile-thing name birthplace))
	(aware-thing-part  (make-aware-thing))
        (armed? #f))
    (lambda(message)
      (case message
        ((ARM) (lambda(self) (set! armed? #t)))
        ((DISARM) (lambda(self) (set! armed? #f)))
        ((TRIGGER) (lambda(self)
                     (if armed? (ask self 'ACTIVATE))))
        ((HEARD-NOISE) (lambda(self who) (ask self 'TRIGGER)))
        ((ACTIVATE) (lambda(self)
                      (let ((people-around (myfilter (lambda (x) (is-a x 'PERSON?)) (ask (ask self 'LOCATION) 'THINGS))))
                        (begin (for-each (lambda(person) (ask person 'SUFFER power)) people-around)
                               (ask screen 'TELL-WORLD (list (ask self 'name) "has exploded."))
                               (ask self 'DESTROY)))))                               
        (else (find-method message mobile-thing-part aware-thing-part))))))

(define (create-bomb name birthplace power)
  (create make-bomb name birthplace power))
                                    

;_BANNER_
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;
;(setup 'dilara)
;(ask screen 'deity-mode #f)
;(populate-bombs all-rooms)
;(ask me 'look-around)
      
;You are in library 
;You are not holding anything. 
;You see stuff in the room: c4 engineering-book 
;There are no other people around you. 
;The exits are in directions: west east ok
;> (ask (thing-named 'c4) 'activate)

;At library dilara says -- Ouch! 2 hits is more than I want! 
;c4 has exploded. destroyed
       
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;_BANNER_
     
     
     
     
     
;_BANNER_
;# DO NOT FORGET TO SUBMIT YOUR WORK BEFORE THE DEADLINE!         #
;_BANNER_
;# GOOD LUCK!                                                     #
;_BANNER_
     
     




