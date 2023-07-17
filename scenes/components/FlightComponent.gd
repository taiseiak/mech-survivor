extends Node2D


signal flight_timed_out

export var fly := true
export var max_flight_speed: float = 3
export var acceleration: float = 1
export var max_flight_time: float = 0
export var initial_speed: float = 0

var target: Node2D

var _velocity: Vector2 = Vector2.ZERO
var _direction: Vector2 = Vector2.ZERO

onready var flight_timer = $FlightTimer


func _ready():
	if target != null and is_instance_valid(target):
		_velocity = owner.global_position.direction_to(target.global_position) * initial_speed
	if max_flight_time > 0:
		flight_timer.connect("timeout", self, "_on_flight_timer_timeout")
		flight_timer.wait_time = max_flight_time
		flight_timer.start()


func _process(delta):
	if fly:
		owner.look_at(owner.global_position + _velocity)

		if target != null and is_instance_valid(target):
			_direction = owner.global_position.direction_to(target.global_position)


func _physics_process(delta):
	if fly:
		var desired_velocity = _direction * max_flight_speed
		_velocity = _velocity.linear_interpolate(desired_velocity, 1 - exp(-acceleration * delta))
		owner.position += _velocity


func _on_flight_timer_timeout():
	emit_signal("flight_timed_out")
