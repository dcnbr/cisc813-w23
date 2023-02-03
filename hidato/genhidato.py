
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


# Generate grid adjacency pairs (symmetric)
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

postamble = """
    )
    
    (:goal (and

    ))
)
"""
print(postamble)


