(define (domain wam)

	(:requirements
		:equality
		:negative-preconditions
		:typing
		:adl
		:fluents
	)

	(:types
		mole - object
		hammer - object
	)

	(:predicates
		(up ?m - mole)
		(ready ?h - hammer)
	)

	(:functions
		(hammer-timer ?h - hammer)
		(hammer-lethargy ?h - hammer)

		(mole-timer ?m - mole)
		(mole-cowardice ?m - mole)
		(mole-lethargy ?m - mole)

		(score)
	)

	(:action whack
		:parameters (?m - mole ?h - hammer)
		:precondition(and
			(up ?m)
			(ready ?h)
		)
		:effect(and
			(not (ready ?h))
			(assign (hammer-timer ?h) (hammer-lethargy ?h))
			;(not (up ?m))
			;(assign (mole-timer ?m) (mole-lethargy ?m))
			(increase (score) 1)
		)
	)

	(:event mole-pop-up
		:parameters (?m - mole)
		:precondition (and
			(not (up ?m))
			(<= (mole-timer ?m) 0)
		)
		:effect(and
			(up ?m)
			(assign (mole-timer ?m) (mole-cowardice ?m))
		)
	)

	(:event mole-panic
		:parameters (?m - mole)
		:precondition(and
			(up ?m)
			(<= (mole-timer ?m) 0)
		)
		:effect(and
			(not(up ?m))
			(assign (mole-timer ?m) (mole-lethargy ?m))
		)
	)

	(:event hammer-restored
		:parameters (?h - hammer)
		:precondition (and
			(not (ready ?h))
			(<= (hammer-timer ?h) 0)
		)
		:effect(and
			(ready ?h)
		)
	)

	(:process mole-enduring
		:parameters(?m - mole)
		:precondition(and
			(>= (mole-timer ?m) 0)
		)
		:effect(decrease (mole-timer ?m) #t)) 
	)


	(:process hammer-recovering
		:parameters(?h - hammer)
		:precondition(and
			(>= (hammer-timer ?h) 0)
		)
		:effect (decrease (hammer-timer ?h) #t) 
	)

)
