extends Node


var current_camera: Camera2D = null

func get_player_node() -> Node2D:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() != 1:
		return null
	return players[0]
