extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tree = $appleTree
	tree.setState(2)
	#add_child(tree)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
