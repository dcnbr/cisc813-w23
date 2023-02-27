# Assignment 4 - Snake RDDL
Sal Choueib - December Stuart


## Domain

"Snake" is a simple arcade game in which a user controls an ever-growing
snake around a map. In the map, some number of food items are placed. The user
is tasked with moving the snake towards the food items so that they are 'eaten',
while avoiding the snake's own tail. Each food item consumed increases the
length of the snake's tail, meaning that space becomes constrained the longer
the snake becomes. The goal is to maximize the length of the snake.


## Implementation

This implementation is played on a square-tile grid. The planner has 4 action
fluents, one for moving the snake's head up/down/left/right. In the wake of the
snake's head, a trail of 'tail' tiles is maintained of the current snake's
length. If the planner ever tries to move the snake's head into a tail tile or
off the board, the head is 'cut off', preventing further movement. When the
snake's head reaches a 'food' tile, it takes a turn off to eat, while new food
items are randomly spawned on the map. Eating food also has the effect of
increasing the length of the snake by 1. The reward function incentivises snake
length, but removes all reward if the head is ever cut.


