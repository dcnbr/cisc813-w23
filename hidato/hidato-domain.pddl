(define (domain hidato)
    (:requirements
        :typing
        :adl
        :existential-preconditions
	:negative-preconditions
    )
    (:types
        tile number - object
    )

    (:predicates
        (has_value ?t - tile ?n - number)
        (is_occupied ?t - tile)
        (is_placed ?n - number)
        (are_adjacent ?t1 ?t2 - tile)
        (are_consecutive ?n1 ?n2)
    )

    (:action fill
        :parameters (?t - tile ?n - number)

        :precondition (and
            (not (is_occupied ?t))
            (not (is_placed ?n))
            (exists (?t2 - tile)
                (exists (?n2 - number)
                    (and
                        (are_adjacent ?t ?t2)
                        (are_consecutive ?n ?n2)
                        (has_value ?t2 ?n2)
                    )
                )
            )
        )

        :effect (and
            (is_placed ?n)
            (is_occupied ?t)
            (has_value ?t ?n)
        )
    )

	(:action fill_largest
		:parameters (?t - tile ?n - number)

		:precondition (and
			; no number greater than this one
            (not (exists (?n1 - number)
				(are_consecutive ?n ?n1)
			))
			(not (is_occupied ?t))
            (not (is_placed ?n))
		)

		:effect (and
            (is_placed ?n)
            (is_occupied ?t)
            (has_value ?t ?n)
        )
	)
)
