extends Node


var dune_level_scene


func _ready():
	EventBus.connect("restart_level", self, "_on_restart_level")
	dune_level_scene = preload("res://scenes/levels/DuneLevel.tscn") as PackedScene


func _on_restart_level():
	$TransitionLayer/AnimationPlayer.play("dissolve_transition")
	get_tree().paused = true
	yield($TransitionLayer/AnimationPlayer, "animation_finished")
	var new_scene = dune_level_scene.instance()
	for child in $World.get_children():
		$World.remove_child(child)
		child.queue_free()
	$World.add_child(new_scene)
	$TransitionLayer/AnimationPlayer.play_backwards("dissolve_transition")
	get_tree().paused = false

