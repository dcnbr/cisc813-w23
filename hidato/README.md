# A2: modelling Hidato
- December Stuart
- Sal Choueib

## Background

Hidato is a pencil puzzle played on a grid, the goal is to place numbers into
cells so that a continuous line can be drawn through all numbers in ascending
order. In general, Hidato is played on any regularly-spaced grid, but for this
assignment, we limit ourselves to square-tile grids.

## In this .zip

### genhidato.py
We provide a generator script that takes a csv file of a puzzle-instance, and
translates it into a PDDL problem-instance. Should work for rectangular grids
of arbitrary dimensions. Useage is as follows:

`~$ python3 genhidato.py [puzzle.csv]`

The script writes to standard output.

### hidato-domain.pddl
The domain specification. Broadly, we model the placement of numbers into the
grid with two actions:

1. `fill_forwards`, which places a number orthogonally to its predecessor
2. `fill_backwards`, which places a number orthogonally to its follower

These actions guarantee all numbers at least one in-order neighbour, but is not
sufficient to guarantee a continuous in-order path; most numbers in the path
will need exactly two in-order neighbours for the solution to be valid.
To remedy this, we introduce the notion of path traversal with a third action:

3. `walk_forwards`, which advances to an adjacent number if it is the following
number in-order

This action ensures non-contiguous paths are rejected as solutions, and allows
for a relatively simple goal.

### \*.csv and \*-problem.pddl
We include a few example problem-instances. .csv files are relatively compact
notation that is expanded into the .pddl problem files with the generator
script. 

The .pddl problems always contain initial predicates for specifying the order
of numbers, as well as the adjacency relation for the placement of tiles.
Each individual problem instance then contains the particular initial
placements.
Finally, every puzzle begins the in-order walk at the lowest number (1).

Using the in-order walk, our goal is simple: we have a valid solution if and
only if a forward traverse exists that can reach the largest number.

## Discussion

This formalism is extremely efficient with the 3x3 puzzle instances, often
finding solutions in milliseconds wuing lama-first.
Unfortunately, the solver is unable to find solutions for 4x4 and 6x6 puzzle
instances, claiming no solution exists.
This is expected to be a bug in the problem-specification, as these
puzzle-instances do have solutions, but the cause of the bug is currently
unknown.

Initially, this puzzle type was modeled without the use of an in-order walk, and
instead the complexity of the solutions was modeled with complex logic conitionson the state of a filled puzzle. This formalization was highly inefficient,
not solvable with average compute resources. We speculate that modelling in this
way was reducing to problem to predicate-satisfiability, which is undecidable
in general. Even in this instance, the predicate formula to be solved for was
too deeply nested and complex to be solvable with reasonable resources.
By moving the complexity of the problem into planner-actions, we see the
strength of autonomous planning systems; avoiding full state expansion via
heuristics and conditional actions, the autonomous planner is able to
accomplish this specific satisfiability problem much faster.




