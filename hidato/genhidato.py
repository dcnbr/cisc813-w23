import sys

grid_width = 3
grid_height = 3

preamble = """(define (problem REPLACE)
    (:domain hidato)
"""
print(preamble)



# base objects
print("\t(:objects")
total_numbers = grid_width*grid_height
tile_string = ""
number_string = ""
for i in range(0,total_numbers):
    tile_string = tile_string + "t"+str(i) + " "
    number_string = number_string + "n"+str(i+1) + " "
print("\t\t"+tile_string+"- tile")
print("\t\t"+number_string+"- number")

# end base objects
print("\t)\n")

# initial predicates
print("\t(:init")

# consecutive numbers
symmetric = False
print("\t\t(are_consecutive n1 n2)")
for i in range(2,total_numbers):
    print("\t\t(are_consecutive n"+str(i)+" n"+str(i+1)+")")
    if symmetric:
        print("\t\t(are_consecutive n"+str(i)+" n"+str(i-1)+")")

# grid adjacency pairs (symmetric)
for i in range(0,grid_width*grid_height):
    row=int(i/grid_width)
    col=int(i%grid_width)
    adj = [(row-1,col-1), (row+0, col-1), (row+1,col-1),
           (row-1,col+0), (row+0, col+0), (row+1,col+0),
           (row-1,col+1), (row+0, col+1), (row+1,col+1)]
    for (x,y) in adj:
        if 0<=x<grid_height and 0<=y<grid_width:
            lin = 3*x + y
            if lin != i:
                print("\t\t(are_adjacent t"+str(i)+" t"+str(lin)+")")

# puzzle start
with open(sys.argv[1]) as file:
    line_count = 0
    for line in file:
        row = line.rstrip().split(",")
        for i in range(len(row)):
            try:
                val = int(row[i])
                print("\n")
                print("\t\t(is_placed n"+str(val)+")")
                print("\t\t(is_occupied t"+str(line_count+i)+")")
                print("\t\t(has_value t"+str(line_count+i)+" n" +str(val)+")")
            except:
                pass
        line_count = line_count + grid_width


# end initial predicates
print("\t)\n")

postamble = """
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
"""
print(postamble)


