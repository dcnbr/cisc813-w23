
grid_width = 3
grid_height = 3
 
preamble = """(define (problem REPLACE)
    (:domain hidato)
"""
print(preamble)


# Numbers are consecutive
symmetric = True
total_numbers = grid_width*grid_height
print("\t\t(are_consecutive n0 n1)")
for i in range(1,total_numbers-1):
    print("\t\t(are_consecutive n"+str(i)+" n"+str(i+1)+")")
    if symmetric:
        print("\t\t(are_consecutive n"+str(i)+" n"+str(i-1)+")")
        
print("\t\t(are_consecutive n"+str(total_numbers-1)+ " n"+str(total_numbers-2)+")")



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


