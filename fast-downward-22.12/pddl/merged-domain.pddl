(define (domain merged)

    (:requirements
        :typing
        :strips
    )

    (:types
        room locatable - object
        robot crate - locatable
    )

    (:predicates
        (in ?r - room ?o - locatable)
        (holding ?r - robot ?c - crate)
        (hands-free ?r - robot)
        (connected ?r1 ?r2 - room)
        (top ?c - crate)
        (on ?s1 ?s2 - crate)
    )


    (:action move

        :parameters (?rob - robot ?r1 ?r2 - room)

        :precondition (and (in ?r1 ?rob)
                           (connected ?r1 ?r2))

        :effect (and (in ?r2 ?rob)
                     (not (in ?r1 ?rob)))

    )


    (:action pickup

        :parameters (?rob - robot ?rm - room ?c-top ?c-bot - crate)

        :precondition (and (in ?rm ?rob)
                           (in ?rm ?c-top)
                           (hands-free ?rob)
                           (top ?c-top)
                           (on ?c-top ?c-bot))

        :effect (and (holding ?rob ?c-top)
                     (top ?c-bot)
                     (not (top ?c-top))
                     (not (on ?c-top ?c-bot))
                     (not (hands-free ?rob))
                     (not (in ?rm ?c-top)))

    )


    (:action drop

        :parameters (?rob - robot ?rm - room ?c-top ?c-bot - crate)

        :precondition (and (in ?rm ?rob)
                           (holding ?rob ?c-top)
                           (top ?c-bot)
                           (in ?rm ?c-bot))

        :effect (and (in ?rm ?c-top)
                     (hands-free ?rob)
                     (on ?c-top ?c-bot)
                     (not (top ?c-bot))
                     (not (holding ?rob ?c-top)))

    )

    (:action shift

        :parameters (?rob - robot ?rm - room ?c-top ?c-bot ?c-target - crate)

        :precondition (and (on ?c-top ?c-bot)
                           (top ?c-top)
                           (top ?c-target)
                           (in ?rm ?rob)
                           (in ?rm ?c-top)
                           (in ?rm ?c-target)
                           (hands-free ?rob))

        :effect (and (on ?c-top ?c-target)
                     (top ?c-bot)
                     (not (on ?c-top ?c-bot))
                     (not (top ?c-target)))

    )

)
