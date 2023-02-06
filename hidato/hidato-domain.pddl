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
        (are_consecutive ?n1 ?n2 - number)
		(at ?n - number)
    )

    (:action fill_backwards
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


    (:action fill_forwards
        :parameters (?t - tile ?n - number)

        :precondition (and
			(not (is_occupied ?t))
            (not (is_placed ?n))
            (exists (?t2 - tile)
                (exists (?n2 - number)
                    (and
                        (are_adjacent ?t ?t2)
                        (are_consecutive ?n2 ?n)
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

	(:action walk_forwards
		:parameters (?t1 ?t2 - tile ?n1 ?n2 - number)

		:precondition(and
			(at ?n1)
			(are_adjacent ?t1 ?t2)
			(are_consecutive ?n1 ?n2)
			(has_value ?t1 ?n1)
			(has_value ?t2 ?n2)
		)

		:effect(and
			(at ?n2)
			(not (at ?n1))
		)
	)

)
