extends Node2D


onready var follow_camera = $FollowCamera
onready var player = $Entities/Player


func _ready():
	follow_camera.current = true
	player.connect("player_died", self, "_on_player_died")


func _process(delta):
	follow_camera.global_position = follow_camera.global_position.linear_interpolate(
				player.global_position,
				1 - exp(-1.5 * delta))


func _on_player_died():
	EventBus.emit_signal("restart_level")
