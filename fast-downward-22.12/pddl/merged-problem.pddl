(define (problem merged1)

    (:domain merged)

    (:objects
        r2d2 c3po - robot
        r1 r2 r3 r4 - room
        b1 b2 b3 b4 b5 c1 c2 c3 - crate
    )

    (:init

        (in r1 r2d2)
        (in r4 c3po)

        (connected r1 r2)
        (connected r2 r3)
        (connected r3 r4)
        (connected r4 r3)
        (connected r3 r2)
        (connected r2 r1)

        (in r1 b1)
        (in r2 b2)
        (in r2 b3)
        (in r3 b4)
        (in r4 b5)
        
        (in r2 c1)
        (in r2 c2)
        (in r3 c3)
        
        (top b1)
        (top c2)
        (top b3)
        (top c3)
        (top b5)
        
        (on c2 c1)
        (on c1 b2)
        (on c3 b4)

        (hands-free r2d2)
        (hands-free c3po)
    )

    (:goal
        (and (in r4 c1)
             (in r1 c3))
    )

)
