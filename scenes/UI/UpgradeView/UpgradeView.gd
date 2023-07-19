extends Control


func _ready():
	EventBus.connect("upgrade_chosen", self, "_on_upgrade_chosen")


func _on_upgrade_chosen(upgrade):
	get_tree().paused = false
	queue_free()
