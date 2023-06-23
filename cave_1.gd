extends Node2D

@onready var tile_map : TileMap = $TileMap
@onready var temp_player = $Temp_Player
@onready var sourceID : int = 2
@onready var atlas : Vector2i = Vector2i(0,0)

var background_layer : int = 0
var foreground_layer : int = 1
#var mined_layer : int = 2

var can_be_mined_custom_layer : String = "Can_be_mined"

func _ready():
	pass


func _input(event):
	if Input.is_action_just_pressed("click"):
		
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos)
#		var sourceID : int = 2
#		var atlas : Vector2i = Vector2i(0,0)
		var tiledata : TileData = tile_map.get_cell_tile_data(foreground_layer, tile_mouse_pos)
		
		if tiledata:
			var can_be_mined = tiledata.get_custom_data(can_be_mined_custom_layer)
			if can_be_mined:
				tile_map.set_cell(foreground_layer, tile_mouse_pos, sourceID, atlas)
			else:
				print("Cannot be mined")
		else:
			print("No tile data")
		
		

	if Input.is_action_just_pressed("Interact"):
		var global_char_pos : Vector2 = temp_player.global_position
		var tile_char_pos : Vector2i = tile_map.local_to_map(global_char_pos)
#		print(tile_char_pos)
		
		var surroundingtiles = []
		for a in range(tile_char_pos[0]-2,tile_char_pos[0]+3):
			for b in range(tile_char_pos[1]-2,tile_char_pos[1]+3):
				var currenttile = Vector2i(a,b)
#				print(currenttile)
				if not surroundingtiles.has(currenttile) and not currenttile == tile_char_pos:
					surroundingtiles.append(currenttile)
					
		var mineable_exist : int = 1
		var mined : int = 0
		
		for i in surroundingtiles:
			var tiledata : TileData = tile_map.get_cell_tile_data(foreground_layer, i)
		
			if tiledata:
				var can_be_mined = tiledata.get_custom_data(can_be_mined_custom_layer)
				if can_be_mined:
					tile_map.set_cell(foreground_layer, i, sourceID, atlas)
					mined = 1
					print("Yay, you mined something!!!!")
					return
				else:
					if mined == 1:
						return
					else:
						pass
			else:
				mineable_exist = 0
				
		if mineable_exist == 0:
			print("No mineable object found")
