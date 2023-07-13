extends Node2D


onready var follow_camera = $FollowCamera
onready var player = $Player


func _ready():
	follow_camera.current = true


func _process(delta):
	follow_camera.global_position = follow_camera.global_position.linear_interpolate(
				player.global_position,
				1 - exp(-1.5 * delta))
