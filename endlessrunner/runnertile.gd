extends Node3D

class_name RunnerTile

signal obstacle_hit
signal coins_earned

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_obstacle_body_entered(body: Node3D) -> void:
	emit_signal("obstacle_hit")


func _on_coin_body_entered(body: Node3D) -> void:
	emit_signal("coins_earned")
