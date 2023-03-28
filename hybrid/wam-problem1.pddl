
(define (problem wam2)

	(:domain wam)

	(:objects
		m1 m2 m3 - mole
		h1 h2 - hammer
	)

	(:init
		(= (score) 0)

		(not (ready h1))
		(not (ready h2))

		(up m1)
		(up m2)
		(up m3)

		(= (hammer-timer h1) 0)
		(= (hammer-timer h2) 0)

		(= (hammer-lethargy h1) 1)
		(= (hammer-lethargy h2) 1)


		(= (mole-cowardice m1) 1)
		(= (mole-cowardice m2) 1)
		(= (mole-cowardice m3) 1)

		(= (mole-lethargy m1) 1)
		(= (mole-lethargy m2) 1)
		(= (mole-lethargy m3) 1)

		(= (mole-timer m1) 0)
		(= (mole-timer m2) 0)
		(= (mole-timer m3) 0)

	)

	(:goal
		(= (score) 2)
	)
)
