extends Node2D

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed(): 
#		var pos = event.position
#		print(pos)

		var tile_map = $my_map
		var tile_map_layer = 0
		var clicked_cell_position = tile_map.local_to_map(tile_map.get_local_mouse_position())
#		print("POS:\t",  clicked_cell_position)
#		print("DATA:\t", tile_map.get_cell_tile_data(0, clicked_cell_position))
#		print("Source ID:\t", tile_map.get_cell_source_id(tile_map_layer, clicked_cell_position))
#		print("Atlas Coords:\t", tile_map.get_cell_atlas_coords(tile_map_layer, clicked_cell_position))
#		print("Alt Tile:\t", tile_map.get_cell_alternative_tile(tile_map_layer, clicked_cell_position))
#		var all_tile_pos = tile_map.get_used_cells_by_id(0)
		
		var clicked_cell_data = tile_map.get_cell_tile_data(0, clicked_cell_position)
		var clicked_cell_depth = -1
		
		if clicked_cell_data:
			clicked_cell_depth = clicked_cell_data.get_custom_data("depth")
			print(clicked_cell_depth)
			clicked_cell_depth = max(0, clicked_cell_depth - 1)
			
			tile_map.set_cell(0, clicked_cell_position, 0, Vector2i(clicked_cell_depth, 0), 0)	
		else:
			return 0
		
