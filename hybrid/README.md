# Whack-A-Mole Hybrid Planning 
December Stuart | Sal Choueib

## Abstract

We use hybrid modelling to model the whack-a-mole game.
Both hammers and moles have some 'lethargy' that delay their repetitive use.
ENHSP-2020 is almost entirely unable to solve plans of this type beyond simple
cases. 
We observe that if hammers are given no delay, but moles are, ENHSP-2020
preforms much better.
These behaviours persist on ENHSP-2019 and -2018.

## Domain Description

Whack-A-Mole is an arcade game played by a single player at an arcade cabinet.
The player interacts with the gave via a hammer. On the cabinet are some small
number of holes, from which 'moles' pop-up at random. A player scores points
by hitting moles with the hammer before they disappear back into the hole after
some random duration. Usually, the goal is to score a certain number of points
within a time limit.

Our model differs from the above model in two ways:
1. We allow arbitrarty numbers of hammers and moles
2. The goal is simply to achieve a certain score; no time limit exists


## PDDL Description

Hammers are either `(ready ?h)` or `(not (ready ?h))` at all times.
Moles are either `(up ?m)` or `(not (up ?m))` at all times.

The agent has only one action to take, which whacks an available mole with an
available hammer:

1. `whack(?h - hammer ?m - mole)`: whack mole `?m` with hammer `?h`

A whack action increases a `score` counter by 1.

After whacking a mole with a hammer, both the hammer and mole must rest for
a span of time before becoming available again (hammers) or poping up again
(moles). Moles also have an upper limit for their time 'up' before they must
rest, if they are never hit. The hyper-parameters that control these delays are:

1. (hammer-lethargy ?h): the time a hammer must rest inbetween 'whack' actions
2. (mole-leghargy ?m)  : the time a mole must rest before poping up
3. (mole-cowardice ?m) : the time a mole will stay up before disappearing


There are two timers that track these delays per object, which processes
linearly decay with `#t` time:

1. (hammer-timer ?h) : counts down each hammers rest period
2. (mole-timer ?m)   : counts down each mole's current state (up or resting)


Events handle the transition of objects after these countdowns expire:

1. hammer-restored : turns a hammer `ready` once it's countdown is `<= 0`
2. mole-pop-up     : turns a `not up` mole `up` once it's countdown is `<= 0`
3. mole-panic      : turns an `up` mole `not up` once it's countdown is `<= 0`


## Observations

### wam-problem1.pddl

With delays for both hammers and moles, ENHSP frequently declares relatively 
simple problems unsolvable.

For example, consider the problem with the following properties:
- 3 moles
- 2 hammers
- all delays = 1
- goals in the form `(= (score) x)` where x is some integer

In this setting, ENHSP does the following:
- `(= (score) 1)` : solvable
- `(= (score) 2)` : solvable 
- `(= (score) 3)` : unsolvable

In a similar setting, with only one hammer:
- (= (score) 1) : solvable
- (= (score) 2) : unsolvable 

In general, there seems to be a trend that ENHSP can only solve problems in
which the goal is immediately reachable with one whack per hammer; if a hammer
is needed more than once, ENHSP fails. This seems to be invariant to changes in
delay.


### wam-problem2.pddl

We originally though this might be a bug in the way we were modelling delay,
and so tried to isolate the issue by removing some delays. When only moles have 
delay, and hammers are immediately available after hits (i.e. they are given
a delay time of 0), ENHSP can solve much higher score plans.

But when only hammers have delay, and moles are always immediately available, we
again see the restriction of `goal score <= # of hammers` occur.

We are unsure if the way mole timers are implemented are to blame, or if ENHSP
cannot find plans with this much complexity. Earlier versions of the domain
did allow for multiple hammer uses, but required ever-present moles. The inter-
action of delays does not seem to have an impact. Nor does turning the goal into
a dummy action.
 




