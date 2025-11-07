The project will begin with some preliminary work with a simple game state. 

The game state will be a set of islands, in which the ASP program will be asked to procedurally generate a set of bridges. 

This program can set up different specifications for how the bridges should be generated. 

Some of these specifications might include: 

- any set of bridges in which there exists a walk (or path) between the start and end island,
- the minimal number of bridges to get from the start island to the end island, or
- the minimal number of bridges to traverse between each island (a Hamiltonian path along the islands, or minimal spanning tree of the islands).

The output from the ASP program will then be parsed into a graphical form. 
