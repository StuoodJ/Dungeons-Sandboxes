extends TileMapLayer
var ZERO:int = 0
var setblockx = 1
var setblocky = 0

var noise_texture = NoiseTexture2D.new()  # Load your NoiseTexture2D

var map_width = int(1280 / 16)
var map_height = int(1280 / 16)
var tilemap = self  # Access your TileMap node


func generate_terrain():
	noise_texture.noise = FastNoiseLite.new()
	for x in range(map_width):
		for y in range(map_height):
			if(y == 1):
				tilemap.set_cell(Vector2i(x, y), 1, Vector2i(1, 0))
			elif(y>1):
				if(y<5):
					tilemap.set_cell(Vector2i(x, y), 1, Vector2i(1, 1))
				else:
					tilemap.set_cell(Vector2i(x, y), 1, Vector2i(randi_range(0, 4), randi_range(0, 3)))
	tilemap.set_cells_terrain_connect(get_used_cells(), 0, 0,true)


func _ready():
	generate_terrain()

func _process(delta):
	if (Input.is_action_just_pressed("blockchange")):
		setblockx += 1
		if(setblockx > 5):
			setblockx = -1
			setblocky += 1
		if(setblocky > 3):
			setblocky = -1
		print(str(setblockx) + "   " + str(setblocky))
	if (Input.is_action_just_pressed("mouseleft")):
		var tile : Vector2 = local_to_map(get_local_mouse_position())
		set_cell(tile, 1, Vector2i(setblockx, setblocky))
		tilemap.set_cells_terrain_connect(get_used_cells(), 0, 0,true)
	
	
	# Remove a tile if the right mouse button is pressed according to its global position
	if (Input.is_action_just_pressed("mouseright")):
		var tile : Vector2 = local_to_map(get_local_mouse_position())
		erase_cell(tile)
		tilemap.set_cells_terrain_connect(get_used_cells(), 0, 0,true)
