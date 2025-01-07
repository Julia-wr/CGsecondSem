extends Node3D

@export var tiles: Array[PackedScene]
@export var tile_length = 20.0
@export var tile_rim = 5.0

var cur_tile_center = tile_length / 2

var cur_tile : Node3D
var last_tile : Node3D

func spawn_next_tile() -> Node3D:
	
	var tile_node = tiles.pick_random().instantiate() as RunnerTile
	add_child(tile_node)
	
	tile_node.obstacle_hit.connect(on_obstacle_hit)
	tile_node.coins_earned.connect(on_coins_earned)
	
	cur_tile_center -= tile_length
	tile_node.position.z = cur_tile_center
	return tile_node

func kill_tile(tile: Node3D):
	tile.obstacle_hit.disconnect(on_obstacle_hit())
	tile.coins_earned.disconnnect(on_coins_earned())
	remove_child(tile)
	tile.queue_free()

func on_obstacle_hit():
	print("Obstacle hit")
	

func on_coins_earned():
	print("Money")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cur_tile = spawn_next_tile()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Player.position.z < cur_tile_center - tile_length/2 + tile_rim:
		if(last_tile != null):
			kill_tile(last_tile)
		last_tile = cur_tile
		cur_tile = spawn_next_tile()
	pass
