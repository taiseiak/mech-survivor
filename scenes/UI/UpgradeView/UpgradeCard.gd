extends Control


export(float, 1.0, 5.0) var scale_increase = 1.2

var tween: SceneTreeTween


func ready():
	$CenterContainer/PanelContainer/VBoxContainer/UpgradeName.connect("mouse_entered", self, "_on_mouse_entered")
	$CenterContainer/PanelContainer/VBoxContainer/UpgradeName.connect("mouse_exited", self, "_on_mouse_exited")


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		EventBus.emit_signal("upgrade_chosen", "upgrade")


func _on_mouse_entered():
	print("mouse entered")
	rect_scale = Vector2(scale_increase, scale_increase)


func _on_mouse_exited():
	print("mouse entered")
	rect_scale = Vector2.ONE


func _on_CenterContainer_mouse_entered():
	if tween != null and tween.is_valid():
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "rect_scale", Vector2(scale_increase, scale_increase), 0.1)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)


func _on_CenterContainer_mouse_exited():
	if tween != null and tween.is_valid():
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "rect_scale", Vector2.ONE, 0.1)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

