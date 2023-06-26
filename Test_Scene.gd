extends Node2D

#var cave_1 = preload("res://cave_1.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if Input.is_action_just_pressed("End_Mini"):
		
#		get_tree().change_scene("res://cave_1.tscn")
		get_tree().change_scene_to_file("res://cave_1.tscn")
