extends Node


var _upgrade_view_scene = preload("res://scenes/UI/UpgradeView/UpgradeView.tscn")
var _upgrade_view


func _ready():
	var player = Globals.get_player_node() as Player
	if player == null:
		return
	player.connect("leveled_up", self, "_on_player_leveled_up")
	player.excess_energy += 90


func _on_player_leveled_up(current_level):
	var ui_node = Globals.get_ui_node()
	if ui_node == null:
		return
	get_tree().paused = true
	_upgrade_view = _upgrade_view_scene.instance()
	ui_node.add_child(_upgrade_view)

