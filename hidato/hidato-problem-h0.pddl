(define (problem REPLACE)
    (:domain hidato)

	(:objects
		t0 t1 t2 t3 t4 t5 t6 t7 t8 - tile
		n1 n2 n3 n4 n5 n6 n7 n8 n9 - number
	)

	(:init
		(are_consecutive n1 n2)
		(are_consecutive n2 n3)
		(are_consecutive n3 n4)
		(are_consecutive n4 n5)
		(are_consecutive n5 n6)
		(are_consecutive n6 n7)
		(are_consecutive n7 n8)
		(are_consecutive n8 n9)
		(are_adjacent t0 t3)
		(are_adjacent t0 t1)
		(are_adjacent t0 t4)
		(are_adjacent t1 t0)
		(are_adjacent t1 t3)
		(are_adjacent t1 t4)
		(are_adjacent t1 t2)
		(are_adjacent t1 t5)
		(are_adjacent t2 t1)
		(are_adjacent t2 t4)
		(are_adjacent t2 t5)
		(are_adjacent t3 t0)
		(are_adjacent t3 t6)
		(are_adjacent t3 t1)
		(are_adjacent t3 t4)
		(are_adjacent t3 t7)
		(are_adjacent t4 t0)
		(are_adjacent t4 t3)
		(are_adjacent t4 t6)
		(are_adjacent t4 t1)
		(are_adjacent t4 t7)
		(are_adjacent t4 t2)
		(are_adjacent t4 t5)
		(are_adjacent t4 t8)
		(are_adjacent t5 t1)
		(are_adjacent t5 t4)
		(are_adjacent t5 t7)
		(are_adjacent t5 t2)
		(are_adjacent t5 t8)
		(are_adjacent t6 t3)
		(are_adjacent t6 t4)
		(are_adjacent t6 t7)
		(are_adjacent t7 t3)
		(are_adjacent t7 t6)
		(are_adjacent t7 t4)
		(are_adjacent t7 t5)
		(are_adjacent t7 t8)
		(are_adjacent t8 t4)
		(are_adjacent t8 t7)
		(are_adjacent t8 t5)


		(is_placed n6)
		(is_occupied t0)
		(has_value t0 n6)


		(is_placed n2)
		(is_occupied t4)
		(has_value t4 n2)


		(is_placed n8)
		(is_occupied t5)
		(has_value t5 n8)


		(is_placed n1)
		(is_occupied t6)
		(has_value t6 n1)
	)


    (:goal (and
        (forall (?n - number)(is_placed ?n))
        (forall (?t - tile) (is_occupied ?t))

		(forall (?n - number ?t - tile)

			; if that cell holds value ?n, then
			(imply (has_value ?t ?n)

				; either
				(or

					; (1) it is a 'middling' number, so it is adjacent to its
					; preceeding and succeding numbers
					(exists (?t2 ?t0 - tile ?n0 ?n2 - number)(and
						(has_value ?t2 ?n2)
						(are_adjacent ?t ?t2)
						(are_consecutive ?n ?n2)
						(has_value ?t0 ?n0)
						(are_adjacent ?t ?t0)
						(are_consecutive ?n0 ?n)
					))

					; (2) it is the lowest number, so it is only adjacent to
					; its succeeding number
					(and
						(exists (?t2 - tile ?n2 - number) (and
							(has_value ?t2 ?n2)
							(are_adjacent ?t ?t2)
							(are_consecutive ?n ?n2)
						))
						(not (exists (?n0 - number)(and
							(are_consecutive ?n0 ?n)
						)))
					)

					; (3) it is the highest number, so it is only adjacent to
					; its preceeding number
					(and
						(exists (?t0 - tile ?n0 - number) (and
							(has_value ?t0 ?n0)
							(are_adjacent ?t ?t0)
							(are_consecutive ?n0 ?n)
						))
						(not (exists (?n2 - number)(and
							(are_consecutive ?n ?n2)
						)))
					)
				)
			)
		)
    ))
)

