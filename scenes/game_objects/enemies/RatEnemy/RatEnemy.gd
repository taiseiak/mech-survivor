extends KinematicBody2D


export var max_speed: float = 50
export var acceleration: float = 1

var player: Node2D
var velocity: Vector2 = Vector2.ZERO


func _ready():
	player = Globals.get_player_node()


func _process(delta):
	if player == null:
		return

	var target_position = player.global_position
	target_position = global_position.direction_to(player.global_position) * max_speed
	velocity = velocity.linear_interpolate(target_position, 1 - exp(-acceleration * delta))
	move_and_slide(velocity)
