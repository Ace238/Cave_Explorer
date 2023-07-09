extends Node2D

@onready var tile_map = $Wall_Tile_Map
@onready var stability = $Wall_Stability
@onready var gem_count_label = $Gem_Count

var stability_count = 10
var gem_count = 0


func _ready():
	# Initialize labels.
	stability.text = str("Stability: ", stability_count)
	gem_count_label.text = str("Gem Count: ", gem_count)
	
	print("Before: ",Inventory.Total_Gems)
	

func _unhandled_input(event):
	# Check for left mouse click.
	if Input.is_action_just_pressed("click_left"):
		# Get position of cell clicked on.
		var clicked_cell_position = tile_map.local_to_map(tile_map.get_local_mouse_position())
		
		# Get cell information from layer 0.
		var clicked_cell_data = tile_map.get_cell_tile_data(0, clicked_cell_position)
		var clicked_cell_depth = -1

		# Check if cell exists. 
		if clicked_cell_data:
			if stability_count > 0:
				# Decrament wall stability and update label.
				stability_count = stability_count - 1
				stability.text = str("Stability: ", stability_count)
				
				# Decrament tile depth and update sprite.
				clicked_cell_depth = clicked_cell_data.get_custom_data("depth")
				clicked_cell_depth = max(0, clicked_cell_depth - 1)
				tile_map.set_cell(0, clicked_cell_position, 0, Vector2i(clicked_cell_depth, 0), 0)
				
				# Hide tile when depth is 0.
				if clicked_cell_depth == 0:
					tile_map.set_cell(0, clicked_cell_position)
					
					# Check if gem found on layer 1
					var gem_found = tile_map.get_cell_tile_data(1, clicked_cell_position)
					if gem_found:
						# Increment gem count and update label. (Local)
						gem_count = gem_count + 1
						gem_count_label.text = str("Gem Count: ", gem_count)
#						print(gem_count)
						
						# Increment Total Gems (Global)
						Inventory.Total_Gems += 1
						print("Update: ", Inventory.Total_Gems)
				
				# When wall is not stable, switch to cave scene.
				if stability_count == 0:
					print("Wall collapsed.")
					stability.text = "Wall collapsed."
					
					# TODO: Add some delay or inbetween state.
					get_tree().change_scene_to_file("res://Cave_1/cave_1.tscn")
		
		else:
			return 0
