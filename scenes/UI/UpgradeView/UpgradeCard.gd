extends PanelContainer


export(float, 1.0, 5.0) var scale_increase = 1.2

var tween: SceneTreeTween
var _initial_scale: Vector2


func _ready():
	_initial_scale = rect_scale


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		EventBus.emit_signal("upgrade_chosen", "upgrade")


func _on_UpgradeCard_mouse_entered():
	if tween != null and tween.is_valid():
		tween.kill()
	tween = create_tween()
	var scale_factor = _initial_scale * scale_increase
	tween.tween_property(self, "rect_scale", scale_factor, 0.1)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)


func _on_UpgradeCard_mouse_exited():
	if tween != null and tween.is_valid():
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "rect_scale", _initial_scale, 0.1)\
			.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
