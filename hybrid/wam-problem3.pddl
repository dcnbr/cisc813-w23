(define (problem wam_1)

	(:domain wam)

	(:objects
		m1 m2 m3 m4 m5 m6 m7 m8 - mole
		h1 h2 - hammer
	)

	(:init
		(= (score) 0)

		(not( ready h1))
		(not( ready h2))

		(up m1)
		(up m2)
		(up m3)
		(up m4)
		(up m5)
		(up m6)
		(up m7)
		(up m8)

		(= (hammer-timer h1) 0)
		(= (hammer-timer h2) 0)

		(= (hammer-lethargy h1) 1)
		(= (hammer-lethargy h2) 1)


		(= (mole-cowardice m1) 2)
		(= (mole-cowardice m2) 3)
		(= (mole-cowardice m3) 5)
		(= (mole-cowardice m4) 2)
		(= (mole-cowardice m5) 3)
		(= (mole-cowardice m6) 5)
		(= (mole-cowardice m7) 2)
		(= (mole-cowardice m8) 3)


		(= (mole-lethargy m1) 0)
		(= (mole-lethargy m2) 0)
		(= (mole-lethargy m3) 0)
		(= (mole-lethargy m4) 0)
		(= (mole-lethargy m5) 0)
		(= (mole-lethargy m6) 0)
		(= (mole-lethargy m7) 0)
		(= (mole-lethargy m8) 0)

		(= (mole-timer m1) 5)
		(= (mole-timer m2) 5)
		(= (mole-timer m3) 5)
		(= (mole-timer m4) 5)
		(= (mole-timer m5) 5)
		(= (mole-timer m6) 5)
		(= (mole-timer m7) 5)
		(= (mole-timer m8) 5)

	)

	(:goal
		(= (score) 3)	
	)
)
