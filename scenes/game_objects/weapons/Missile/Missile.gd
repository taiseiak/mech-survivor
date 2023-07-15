extends Node2D


export var max_flight_speed: float = 3
export var acceleration: float = 1
export var max_flight_time: float = 3

var target: Node2D

var _velocity: Vector2
var _direction: Vector2 = Vector2.RIGHT

onready var hit_box_component = $HitBoxComponent
onready var flight_timer = $FlightTimer


func _ready():
	_velocity = Vector2.ZERO
	hit_box_component.connect("area_entered", self, "_on_hit_box_area_entered")
	flight_timer.connect("timeout", self, "_on_flight_timer_timeout")
	flight_timer.wait_time = max_flight_time
	flight_timer.start()


func _process(delta):
	look_at(global_position + _velocity)

	var target_pos

	if target != null and is_instance_valid(target):
		target_pos = target.global_position
	else:
		target_pos = _direction


	_direction = global_position.direction_to(target_pos)
	var desired_velocity = _direction * max_flight_speed
	_velocity = _velocity.linear_interpolate(desired_velocity, 1 - exp(-acceleration * delta))
	position += _velocity


func _on_hit_box_area_entered(area: Area2D):
	if area is HurtBoxComponent:
		hit_box_component.set_deferred("monitoring", false)
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("explode")


func _on_flight_timer_timeout():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("explode")
